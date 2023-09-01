import 'package:admin_seller/app_const/app_exports.dart';
import 'package:admin_seller/features/seller/data/selling_data/wallet_model.dart';
import 'package:admin_seller/features/seller/presentation/widgets/add_order_field.dart';

part 'selling_event.dart';
part 'selling_state.dart';

class SellingBloc extends Bloc<SellingEvent, SellingState> {
  SellingBloc()
      : super(SellingState(
            walletList: [],
            furnitureModelTypeModelList: [],
            sellingWarehouseModel: [])) {
    on<GetWarehouseProducts>(_getWarehouseProducts);
    on<BookWarehouseProduct>(_bookWarehouseProduct);
    on<UnbookWarehouseProduct>(_unbookWarehouseProduct);
    on<GetSellingMyOrders>(_getSellingMyOrders);
    on<SearchFurnitureTypeModel>(_searchFurnitureModel);
    on<GetIdSelling>(_getIdSelling);
    on<CategorySelling>(_categorySelling);
    on<SelectFurnitureTypeAndModel>(_selectFurnitureTypeAndModel);
    on<SearchWarehouseProduct>(_searchWarehouseProduct);
    on<SearchHasEvent>(_searchHasEvent);
    on<GetWalletList>(_getWalletList);
    on<SelectTypePayment>(_selectTypePayment);
    on<ClientStatusChange>(_clientStatusChange);
    on<CheckOrderDatePick>(_checkOrderDatePick);
    on<LoadMoreWarehouseProducts>(_loadMoreWarehouseProducts);
  }

  final SellingRepository _sellingRepository = SellingRepository();
  final scrollController = ScrollController();
  int page = 1;
  List<Product?> warehouseProducts = [];

  void _searchHasEvent(SearchHasEvent event, Emitter<SellingState> emit) {
    emit(state.copyWith(isHasSearch: !state.isHasSearch, searchText: ''));
  }

  void _checkOrderDatePick(
      CheckOrderDatePick event, Emitter<SellingState> emit) {
    emit(state.copyWith(dateTimeDeliver: event.dateTimeDeliver));
  }

  void _clientStatusChange(
      ClientStatusChange event, Emitter<SellingState> emit) {
    emit(state.copyWith(clientStatus: event.clientStatus));
  }

  void _selectTypePayment(SelectTypePayment event, Emitter<SellingState> emit) {
    emit(state.copyWith(paymentValue: event.value));
  }

  Future<void> _getWalletList(
      GetWalletList event, Emitter<SellingState> emit) async {
    final walletList = await _sellingRepository.getWalletList();
    emit(state.copyWith(walletList: walletList));
  }

  void _selectFurnitureTypeAndModel(
      SelectFurnitureTypeAndModel event, Emitter<SellingState> emit) {
    emit(state.copyWith(
        furnitureTypeAndModel: event.furnitureTypeAndModel,
        idModel: event.idModel,
        furnitureModelTypeModelList: []));
  }

  void _categorySelling(CategorySelling event, Emitter<SellingState> emit) {
    emit(state.copyWith(category: event.category));
  }

  Future<void> _getIdSelling(
      GetIdSelling event, Emitter<SellingState> emit) async {
    final idSelling = await _sellingRepository.sellingGetId();
    emit(state.copyWith(idSelling: idSelling));
  }

  Future<void> _searchFurnitureModel(
      SearchFurnitureTypeModel event, Emitter<SellingState> emit) async {
    emit(state.copyWith(showSearchLoading: true));

    final searchModels =
        await _sellingRepository.searchFurnitureModel(event.searchText);
    debugPrint("${event.searchText}______");
    emit(state.copyWith(
        furnitureModelTypeModelList:
            event.searchText.isEmpty ? [] : searchModels,
        showSearchLoading: false));
  }

  Future<void> _getSellingMyOrders(
      GetSellingMyOrders event, Emitter<SellingState> emit) async {
    emit(state.copyWith(showLoadingSellingMyOrders: true));
    final sellingMyOrders = await _sellingRepository.getSellingMyOrders();

    emit(state.copyWith(
        sellingMyOrders: sellingMyOrders, showLoadingSellingMyOrders: false));
  }

  void _loadMoreWarehouseProducts(
      LoadMoreWarehouseProducts event, Emitter<SellingState> emit) async {
    if (state.loadMoreLoading) return;
    emit(state.copyWith(loadMoreLoading: true));
    if (!state.hasReached) {
      page++;
      debugPrint(page.toString());
    }
    final loadMoreWarehouseProducts =
        await _sellingRepository.getWarehouseProducts(page, 10, '');
    if (loadMoreWarehouseProducts!.products!.isEmpty) {
      emit(state.copyWith(hasReached: true));
    }
    warehouseProducts.addAll(loadMoreWarehouseProducts.products!);
    emit(state.copyWith(
        sellingWarehouseModel: warehouseProducts, loadMoreLoading: false));
  }

  Future<void> _getWarehouseProducts(
      GetWarehouseProducts event, Emitter<SellingState> emit) async {
    emit(state.copyWith(showLoadingWarehouseProducts: true));

    final sellingWarehouseModel =
        await _sellingRepository.getWarehouseProducts(1, 10, '');
    warehouseProducts = sellingWarehouseModel!.products!;
    page = 1;
    emit(state.copyWith(
        sellingWarehouseModel: warehouseProducts,
        showLoadingWarehouseProducts: false,
        hasReached: false));
  }

  Future<void> _searchWarehouseProduct(
      SearchWarehouseProduct event, Emitter<SellingState> emit) async {
    emit(state.copyWith(showLoadingWarehouseProducts: true));
    final sellingWarehouseModel =
        await _sellingRepository.getWarehouseProducts(1, 10, event.searchText);

    emit(state.copyWith(
        searchText: event.searchText,
        sellingWarehouseModel:
            event.searchText.isEmpty ? [] : sellingWarehouseModel!.products,
        showLoadingWarehouseProducts: false));
  }

  Future<void> _bookWarehouseProduct(
      BookWarehouseProduct event, Emitter<SellingState> emit) async {
    await _sellingRepository.bookWareHouseProduct(event.dateTime, event.id);
    final sellingWarehouseModel =
        await _sellingRepository.getWarehouseProducts(1, 10, state.searchText);
    emit(state.copyWith(
        sellingWarehouseModel: sellingWarehouseModel!.products!));
  }

  Future<void> _unbookWarehouseProduct(
      UnbookWarehouseProduct event, Emitter<SellingState> emit) async {
    await _sellingRepository.unbookWareHouseProduct(event.id);
    final sellingWarehouseModel =
        await _sellingRepository.getWarehouseProducts(1, 10, state.searchText);
    emit(state.copyWith(
        sellingWarehouseModel: sellingWarehouseModel!.products!));
  }
}
