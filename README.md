# uplatform

UPlatform

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

DB_HOST=u-platform.cmgwucqkgqor.ap-northeast-2.rds.amazonaws.com
DB_DATABASE=shinyo
DB_USERNAME=admin
DB_PASSWORD=dbvmf2021!

ssh -i "/Users/hyungookim/document/uplatform/u-platform.pem" ubuntu@ec2-3-38-61-94.ap-northeast-2.compute.amazonaws.com

/var/www/html/uplatform_web

_paymentResult {imp_uid: imp_487875828006, merchant_uid: mid_1643108873780, imp_success: true}
_paymentResult {
    success: true, 
    imp_uid: imp_504552668921, 
    pay_method: card, 
    merchant_uid: mid_1643109551174, 
    name: (주)유플랫폼, 
    paid_amount: 100, 
    currency: KRW, 
    pg_provider: danal_tpay, 
    pg_type: payment, 
    pg_tid: 202201252019127404023400, 
    apply_num: 21453117, 
    buyer_name: 김현구, 
    buyer_email: foriton@kakao.com, 
    buyer_tel: 01090215093, 
    buyer_addr: , 
    buyer_postcode: , 
    custom_data: null, 
    status: paid, 
    paid_at: 1643109582, 
    receipt_url: https://www.danalpay.com/receipt/creditcard/view.aspx?dataType=receipt, 
    cpid: 9810030929, 
    data: 9i30UGU3h32Br6l3rNr6WE2m96/R0P66r08YthOhsF87mK/ls8tD20Lk1/ludWvr, 
    card_name: 신한카드, 
    bank_name: null, 
    card_quota: 0, 
    card_number: 451842******9935
}
