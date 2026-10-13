import 'package:flutter_test/flutter_test.dart';
import 'package:template/api/repositories/products_repository.dart';
import 'package:template/api/repositories/investment_repository.dart';
import 'package:template/api/services/dio_service.dart';
import 'package:template/api/Models/products/products_model.dart';
import 'package:template/api/Models/investments/investment_model.dart';
import 'package:template/api/Models/investments/investment_preview_model.dart';
import 'package:template/api/Models/investments/create_investment_model.dart';
import 'package:template/api/Models/errors/error_response.dart';

void main() {
  test('Test Products and Investments repositories', () async {
    final dio = DioService();
    final prodRepo = ProductsRepository(networkService: dio);
    final invRepo = InvestmentRepository(networkService: dio);

    // 1. Get products
    final prodRes = await prodRepo.getProducts();
    expect(prodRes.success, isTrue);
    expect(prodRes.data, isA<List<Productsmodelresponse>>());
    final products = prodRes.data as List<Productsmodelresponse>;
    expect(products.isNotEmpty, isTrue);
    final testProductId = products.first.id;
    print('Products fetched: ${products.length}');

    // 2. Get product details
    final prodDetailRes = await prodRepo.getProductDetails(productId: testProductId);
    expect(prodDetailRes.success, isTrue);
    expect(prodDetailRes.data, isA<Productsmodelresponse>());
    print('Product detail fetched: ${(prodDetailRes.data as Productsmodelresponse).name}');

    // 3. Preview investment
    final prevRes = await invRepo.previewInvestment(
      productId: testProductId,
      amount: 1000,
    );
    expect(prevRes.success, isTrue);
    expect(prevRes.data, isA<InvestmentPreviewModel>());
    print('Preview fetched: ${(prevRes.data as InvestmentPreviewModel).productName}');

    // 4. Create investment
    final createRes = await invRepo.createInvestment(
      productId: testProductId,
      amount: 1000,
      investorName: 'Test Runner',
      fundingSource: 'Bank Transfer',
      idempotencyKey: 'idemp-${DateTime.now().millisecondsSinceEpoch}',
    );
    expect(createRes.success, isTrue);
    expect(createRes.data, isA<CreateInvestmentModel>());
    final created = createRes.data as CreateInvestmentModel;
    print('Investment created: ${created.referenceNumber}');

    // 5. Get specific investment
    final specificRes = await invRepo.getSpecificUserInvestment(referenceNumber: created.referenceNumber);
    expect(specificRes.success, isTrue);
    expect(specificRes.data, isA<Investmentmodel>());
    print('Specific investment verified: ${(specificRes.data as Investmentmodel).referenceNumber}');

    // 6. Get users investments
    final userInvsRes = await invRepo.getUsersInvestments();
    expect(userInvsRes.success, isTrue);
    expect(userInvsRes.data, isA<List<Investmentmodel>>());
    print('User investments count: ${(userInvsRes.data as List<Investmentmodel>).length}');

    // 7. Simulate error
    final errRes = await prodRepo.getProducts(simulateError: true);
    expect(errRes.success, isFalse);
    expect(errRes.data, isA<ErrorResponse>());
    print('Simulated error verified: ${(errRes.data as ErrorResponse).message}');

    // 8. Reset investments
    final resetRes = await invRepo.resetInvestments();
    expect(resetRes.success, isTrue);
    print('Reset investments verified: ${resetRes.message}');
  });
}
