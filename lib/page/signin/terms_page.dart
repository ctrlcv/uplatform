import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/constants/constants.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

  static const routeName = '/TermsPage';
  final double _hPaddingDepth1 = 33;
  final double _hPaddingDepth2 = 50;
  final double _hPaddingDepth3 = 60;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        (Get.arguments == null)
                            ? ""
                            : (Get.arguments == "서비스 이용약관")
                                ? "(주)유플랫폼 이용 약관"
                                : "(주)유플랫폼 개인정보 취급 방침",
                        style: const TextStyle(
                          fontSize: 24,
                          height: 1.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (Get.arguments == "서비스 이용약관") buildServiceTerms() else buildPrivacyTerms(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            buildBottomBar
          ],
        ),
      ),
    );
  }

  Widget buildServiceTerms() {
    return Column(
      children: [
        //--------------------------------------------------------------------------------------------------------------
        buildMidTitle("제 1 장 총칙"),
        buildSubTitle("제 1 조 (목적)"),
        buildParagraph(
            "이 약관은 이용자가 주식회사 유플랫폼(이하 “회사”)이 운영하는 인터넷 서비스 사이트(이 하 “사이트” 또는 “샤이니오”)를 통해 제공하는 인터넷 전자상거래 관련 서비스(이하 “서비 스”)와 관련하여 회사와 이용자의 권리, 의무, 책임사항을 규정함을 목적으로 합니다. 또한 본 약관은 유무선 PC통신, 태블릿 PC, 스마트폰(아이폰, 안드로이드폰 등) 어플리케이션 및 모바일웹 등을 이용하는 전자상거래 등에 대해서도 그 성질에 반하지 않는 한 준용됩니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("본 약관이 규정한 내용 이외의 회사와 이용자 간의 권리, 의무 및 책임사항에 관하여서는 전기통신사업법 기타 대한민국의 관련 법령과 상관습에 의합니다.",
            title: "2. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 2 조 (정의)"),
        buildParagraph("이 약관에서 사용하는 용어의 정의는 다음과 같습니다."),
        const SizedBox(height: 6),
        buildParagraph("회사가 운영하는 사이트는 아래와 같습니다.", title: "1. "),
        buildParagraph("hi-shiny-o.com, 추후 회사에서 공지하고 제공하는 기타 웹사이트, 스마트폰 및 이동통신 기기를 통해 제공되는 모바일 어플리케이션 포함",
            hPadding: 35),
        const SizedBox(height: 6),
        buildParagraph("이용자: 샤이니오에 접속하여 이 약관에 따라 서비스를 받는 회원 및 비회원을 말합니다.", title: "2. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회원: 본 약관에 따라 회사와 서비스 이용계약을 체결하고 회원 아이디(ID)를 부여받아 회 사가 제공하는 서비스를 이용하는 개인을 말합니다. 회원은 이용하는 서비스에 따라 일반 회원과 전문가 회원으로 나누어집니다.",
            title: "3. "),
        const SizedBox(height: 6),
        buildParagraph(
            "일반 회원: 회사에 개인정보를 제공하여 회원등록을 한 자로서, 회사와 서비스 이용계약을 체결하고 회원 아이디(ID)를 부여 받아 사이트 내에 게시된 광고를 열람하거나 요청서를 작 성하고 전문가 회원에게 요청서를 보내거나 바로구매 상품을 구매하는 등 원하는 용역의 전문가를 찾기 위해 사이트를 계속적으로 이용할 수 있는 자를 말합니다.",
            title: "4. "),
        const SizedBox(height: 6),
        buildParagraph(
            "전문가 회원: 회사에 개인정보를 제공하여 회원등록을 한 자로서, 회사와 서비스 이용계약 을 체결하고 회원 아이디(ID)를 부여 받아 고객에게 견적을 보내거나 바로구매 상품을 등록 하여 판매하는 등 고객을 찾기 위한 서비스를 계속적으로 이용할 수 있는 자를 말합니다.",
            title: "5. "),
        const SizedBox(height: 6),
        buildParagraph("요청서: 요청자가 원하는 용역에 대한 구체적인 정보를 담고 있는 서비스 요청서입니다.", title: "6. "),
        const SizedBox(height: 6),
        buildParagraph("견적(견적서): 전문가 회원이 자신이 제공할 수 있는 용역에 관하여 요청자에게 보낼 수 있 는 용역 금액 및 내용에 대한 요약본입니다.", title: "7. "),
        const SizedBox(height: 6),
        buildParagraph(
            "콘텐츠(Contents): 회사가 샤이니오에서 제공하는 정보, 요청서 작성, 견적 작성, 요청서 수신, 견적 수신, 프로그램 등 부호ᆞ문자ᆞ도형ᆞ색채ᆞ음성ᆞ음향ᆞ이미지ᆞ영상 및 복 합체의 정보나 자료를 의미합니다.",
            title: "8. "),
        const SizedBox(height: 6),
        buildParagraph("회원 아이디(이하 “ID”): 회원의 식별과 회원의 서비스 이용을 위하여 회원이 선정하고 회사가 승인하는 문자 또는 숫자의 조합을 말합니다.", title: "9. "),
        const SizedBox(height: 6),
        buildParagraph("비밀번호(Password): 이용자가 등록회원과 동일인인지 신원을 확인하고, 회원의 통신상 개인정보를 보호하기 위하여 회원이 정한 문자와 숫자의 조합을 말합니다.",
            title: "10. "),
        const SizedBox(height: 6),
        buildParagraph("비회원: 회원에 가입하지 않고 서비스를 이용하는 자로 샤이니오 이용자 및 정보의 수신 을 위해 전자우편 및 SMS 서비스를 온라인 또는 서면으로 신청한 자를 지칭합니다.",
            title: "11. "),
        const SizedBox(height: 6),
        buildParagraph("회원 탈퇴: 회원이 이용계약을 종료시키는 행위를 말합니다.", title: "12. "),
        const SizedBox(height: 6),
        buildParagraph("뉴스레터(Newsletter): 회사가 보내는 샤이니오 소식이 담긴 이메일을 의미합니다.", title: "13. "),
        const SizedBox(height: 6),
        buildParagraph("인터랙션 : 회원간의 채팅, 전화 등 샤이니오에서 제공하는 방식을 통해 상호작용 할 수 있는 행위를 의미 합니다.", title: "14. "),
        const SizedBox(height: 6),
        buildParagraph(
            "바로구매 : 전문가 회원이 자신이 제공할 수 있는 유형의 제품 또는 무형의 용역에 대한 금액과 내용을 회사가 제공하는 일정한 양식에 따라 회사의 사이트에 등록하고, 고객이 정해진 금액을 결제하여 전문가 회원으로부터 유형의 제품 또는 무형의 용역을 제공 받는 형태의 서비스를 말합니다.",
            title: "15. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 3 조 (약관의 명시, 효력 및 개정)"),
        buildParagraph(
            "회사는 이 약관의 내용과 주소지, 관리자의 성명, 개인정보보호 담당자의 성명, 연락처(전화, 팩스, 전자우편 주소 등) 등을 이용자가 알 수 있도록 샤이니오의 초기 서비스 화면에 게시합니다. 다만, 약관의 구체적 내용은 이용자가 연결화면을 통하여 볼 수 있습니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("이 약관은 그 내용을 샤이니오에 게시하거나 이메일 등 기타의 방법으로 회원에게 공지함으로써 효력이 발생합니다.", title: "2. "),
        const SizedBox(height: 6),
        buildParagraph("서비스 이용 시 화면에서 제시되는 경고 메시지의 효력은 본 약관의 효력과 동일합니다.", title: "3. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 약관의 규제에 관한 법률, 전자거래기본법, 전자서명법, 정보통신망 이용촉진 및 정보 보호 등에 관한 법률 기타 관련 법령을 위배하지 않는 범위 내에서 약관을 변경할 수 있으며, 변경된 약관은 2항과 같은 방법으로 효력을 발생합니다.",
            title: "4. "),
        const SizedBox(height: 6),
        buildParagraph(
            "제4항에 따라 공지된 적용일자 이후에 회원이 회사의 서비스를 계속 이용하는 경우에는 변경된 약관의 효력 발생일로부터 7일 이내에 거부의사를 표시하지 아니하고 서비스를 계속 사용할 경우 개정된 약관에 동의하는 것으로 간주합니다. 개정된 약관에 동의하지 아니하 는 회원은 언제든지 자유롭게 서비스 이용계약을 해지할 수 있습니다.",
            title: "5. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 4 조 (약관 외 준칙)"),
        buildParagraph("이 약관은 회사가 제공하는 개별서비스에 관한 이용안내(이하 ‘서비스별 안내’라 합니다)와 함께 적용합니다.", title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("이 약관에 명시되지 않은 사항에 대해서는 전기통신사업법, 전자거래기본법, 정보통신망법, 학원법, 기타 관련법령 및 서비스 별 안내의 규정에 의합니다.",
            title: "2. "),
        const SizedBox(height: 40),
        //--------------------------------------------------------------------------------------------------------------
        buildMidTitle("제 2 장 서비스 이용 계약"),
        buildSubTitle("제 5 조 (이용 계약의 성립)"),
        buildParagraph("이용 계약은 서비스 이용 희망자의 이 약관에 대해 동의한다는 의사표시와 이용 신청에 대한 회사의 승낙으로 성립됩니다.", title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("이 약관에 대한 동의는 이용 신청 당시 서비스 이용 희망자의 이용약관의 확인과 명시적 의사표시를 통해 성립됩니다.", title: "2. "),
        const SizedBox(height: 6),
        buildParagraph(
            "이용 계약은 만 14세 이상의 개인 또는 기업(개인사업자 및 법인사업자 등)이 할 수 있습니다. 타인의 정보를 도용하여 회원으로 가입한 자는 회사가 제공하는 서비스를 이용할 수 없으며, 이용하여서도 안 됩니다.",
            title: "3. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 6 조 (회원가입 및 승낙)"),
        buildParagraph(
            "회원가입은 회원이 되고자 하는 이용자(이하 “가입신청자”)가 약관의 내용에 동의를 하고, 회사가 정한 가입 양식에 따라 회원정보(이용자ID), 비밀번호, 주소, 연락처 등)를 기입하여 회원가입신청을 하고 회사가 이러한 신청에 대하여 승인함으로써 체결됩니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("이용자의 회원가입신청에 대하여 회사가 승낙한 경우, 회사는 회원 ID/Password와 기타 회사가 필요하다고 인정하는 내용을 이용자에게 통지합니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 이용자의 신청에 대해서 회원가입을 승낙하는 것을 원칙으로 합니다. 다만, 다음 각 호에 해당하는 신청에 대하여는 승인을 하지 아니할 수 있습니다.",
            title: "3. "),
        const SizedBox(height: 4),
        buildParagraph("본인 실명이 아니거나 다른 사람의 명의를 사용하여 신청하였을 때", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph("서비스 이용 계약 신청서의 내용을 허위로 기재하였을 때", title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph("사회의 안녕과 질서 혹은 미풍양속을 저해할 목적으로 신청하였을 때", title: "다. ", hPadding: _hPaddingDepth1),
        buildParagraph("부정한 용도로 본 서비스를 이용하고자 하는 경우", title: "라. ", hPadding: _hPaddingDepth1),
        buildParagraph("영리를 추구할 목적으로 본 서비스를 이용하고자 하는 경우", title: "마. ", hPadding: _hPaddingDepth1),
        buildParagraph("본 서비스와 경쟁관계에 있는 이용자가 신청하는 경우", title: "바. ", hPadding: _hPaddingDepth1),
        buildParagraph("기타 이용신청자의 귀책사유로 이용승낙이 곤란한 경우", title: "바. ", hPadding: _hPaddingDepth1),
        const SizedBox(height: 6),
        buildParagraph("회사는 서비스 이용신청이 다음 각 호에 해당하는 경우에는 그 신청에 대하여 승낙 제한사 유가 해소될 때까지 승낙을 유보할 수 있습니다.", title: "4. "),
        const SizedBox(height: 4),
        buildParagraph("회사가 설비의 여유가 없는 경우", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph("회사의 기술상 지장이 있는 경우", title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph("기타 회사의 귀책사유로 이용승낙이 곤란한 경우", title: "다. ", hPadding: _hPaddingDepth1),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 7 조 (서비스 이용)"),
        buildParagraph(
            "회원은 사이트를 통한 회원가입 시 발급된 ID 하나로 제1장 제2조 1항에 명시된 모든 사이 트에 자동 가입되며, 해당 서비스를 이용할 수 있습니다. 단, 일부 사이트의 특정 서비스는 별도의 가입절차를 통하여 이용할 수 있으며, 이 경우 해당 사이트의 이용 시에는 해당 사 이트의 특정서비스에 대한 이용약관이 이 약관보다 우선 적용됩니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회원의 최초 서비스 이용신청 이후 사이트가 늘어난 경우에도 신규 사이트의 이용약관에서 달리 명시되지 않는 한 제1항의 내용이 마찬가지로 적용됩니다. 이 경우 회사는 신규 사이 트의 서비스 개시 일자, 회원자동가입 사실 기타 관련 정보를 그 개시일 7일 이전부터 개시일까지 각 사이트에 공지하거나, 또는 그 개시일 7일 이전까지 이메일 통지 등으로 각 회원 에게 개별 통지합니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph("샤이니오 서비스 이용은 사이트의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간을 원칙으로 합니다.", title: "3. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사가 샤이니오에서 제공하는 서비스는 기본적으로 무료입니다. 단, 별도로 전문가 회원 이 고객에게 견적을 보내는 등 일부 특정 서비스를 이용하기 위해서는 사이트 내에서 별도 의 결제 과정을 거쳐야만 해당 서비스를 이용 가능합니다.",
            title: "4. "),
        const SizedBox(height: 6),
        buildParagraph("유료서비스 이용 요금 및 결제 방식은 해당 서비스에 명시되어 있는 규정에 따릅니다.", title: "5. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 통신판매중개업자로서 서비스 요금이 무료인 서비스와 일부 유료서비스 이용과 관 련하여 이용자들 사이에서 발생한 거래와 관련된 손해에 대해서는 회사에 고의 또는 중대 한 과실이 있는 경우를 제외하고는 책임을 지지 않습니다",
            title: "6. "),
        const SizedBox(height: 40),
        //--------------------------------------------------------------------------------------------------------------
        buildMidTitle("제 3 장 서비스 제공 및 변경"),
        buildSubTitle("제 8 조 (서비스 이용)"),
        buildParagraph("회사가 제공하는 서비스의 내용은 다음과 같습니다.", title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("고객에게 전문가 회원의 견적 정보 제공", title: "2. "),
        const SizedBox(height: 6),
        buildParagraph("고객의 요청서를 전문가 회원에게 제공", title: "3. "),
        const SizedBox(height: 6),
        buildParagraph("전문가 회원에게 바로구매 상품 등록 및 판매 수단 제공 고객에게 바로구매 상품 구매 중개", title: "4. "),
        const SizedBox(height: 6),
        buildParagraph("기타 관련 부수적 서비스", title: "5. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 9 조 (정보의 제공 및 광고의 게재)"),
        buildParagraph(
            "회사는 회원에게 서비스 이용에 필요하다고 인정되는 각종 정보에 대해서 사이트 및 이메일, SMS, DM발송 등 각종 매체에 게재하는 방법 등으로 회원에게 제공할 수 있습니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 서비스 개선 및 소개 등을 목적으로 회원의 동의 하에 추가적인 개인정보를 요청할 수 있습니다.", title: "2. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 서비스의 운용과 관련하여 사이트, 이메일, SMS, DM 등에 광고 등을 게재할 수 있습니다.", title: "3. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 10 조 (서비스 제공의 제한 및 중단)"),
        buildParagraph(
            "회사는 정기점검, 보수, 교체 등 회사가 필요한 경우 및 부득이한 사유로 인하여 서비스 이용에 지장이 있는 경우에는 서비스의 이용의 전부 또는 일부를 제한하거나 일시 중단할 수 있습니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "전시, 사변, 천재지변 또는 이에 준하는 국가 비상사태가 발생하거나 발생할 우려가 있는 경우와 정전, 서비스 이용 폭주 등으로 정상적인 서비스가 불가능한 경우 등 기타 불가항력적인 사유가 있는 경우에는 서비스 이용의 전부 또는 일부를 제한하거나 중지할 수 있습니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph(
            "제1항에 의한 서비스 중단의 경우에는 사이트는 회원에게 제11조의 방법으로 통지를 합니다. 단, 사이트가 통제할 수 없는 사유로 인한 서비스 중단으로 사전 통지가 불가능한 경우 에는 그러하지 아니합니다.",
            title: "3. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, 회사의 고의 또는 과실이 없음을 입증하는 경우에 는 그러하지 아니합니다.",
            title: "4. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 11 조 (회원에 대한 통지)"),
        buildParagraph("회사가 회원에 대한 통지를 하는 경우에는 회원이 서비스 이용 신청 시 사이트 화면 또는 회원가입 시 제출한 이메일 주소로 할 수 있습니다.", title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 불특정 다수 회원에 대한 통지의 경우 7일 이상 사이트 상에 게시함으로써 개별 통 지에 갈음할 수 있습니다.", title: "2. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 12 조 (회원탈퇴 및 자격상실)"),
        buildParagraph(
            "회원이 이용계약을 해지하고자 하는 때에는 회원 본인이 샤이니오 내의 메뉴 또는 전화 등의 방법을 이용하여 가입해지를 신청할 수 있으며, 회사는 즉시 회원 탈퇴 처리를 합니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("회원 탈퇴가 이루어짐과 동시에 서비스 이용과 관련된 모든 정보는 삭제됩니다. 이로 인해 발생하는 불이익에 대한 책임은 회원 본인에게 있습니다.", title: "2. "),
        const SizedBox(height: 6),
        buildParagraph("회원이 다음 각 호의 사유에 해당하는 경우, 회사는 회원의 회원자격을 적절한 방법으로 제한 및 정지, 상실 시킬 수 있습니다.", title: "3. "),
        const SizedBox(height: 4),
        buildParagraph("가입 신청 시에 허위 내용을 등록한 경우", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph("다른 사람의 ‘서비스’이용을 방해하거나 그 정보를 도용하는 등 전자거래질서를 위협하는 경우", title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph("서비스를 이용하여 법령과 본 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우", title: "다. ", hPadding: _hPaddingDepth1),
        buildParagraph("제1호 내지 제3호 기타 부정한 방법으로 결제 행위를 한 경우", title: "라. ", hPadding: _hPaddingDepth1),
        buildParagraph("회사가 회원 자격을 제한ᆞ정지 시킨 후, 동일한 행위가 2회 이상 반복되거나 10일 이내에 그 사유가 시정되지 아니하는 경우",
            title: "마. ", hPadding: _hPaddingDepth1),
        const SizedBox(height: 6),
        buildParagraph("회사가 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 소명할 기회를 부여합니다.", title: "4. "),
        const SizedBox(height: 40),
        //--------------------------------------------------------------------------------------------------------------
        buildMidTitle("제 4 장 서비스 이용 계약의 해제, 해지"),
        buildSubTitle("제 13 조 (회사의 서비스 이용 계약해제, 해지 및 이용제한)"),
        buildParagraph("회사는 거래의 안정성을 위해 해당 약관에서 정한 바에 따라 회원 자격을 정지하거나, 서비 스 이용 제한 등의 조치를 취할 수 있습니다.", title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 다른 이용자의 약관 위반 행위에 가공하거나 공모한 이용자 또는 약관 위반 행위를 돕거나 그로 인해 부당한 이득을 취한 이용자에 대해서도 해당 약관 위반 행위에 대한 제재를 적용할 수 있습니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사가 회원자격을 정지하거나 이용제한 등 기타 필요한 조치를 취할 경우 이 약관에 특별한 규정이 없는 한 사전에 회원에게 유선 또는 메일 등 알림을 통해 통보하며 회원이 연락 두절 되거나 긴급을 요하는 부득이한 경우 선조치 후통보 할 수 있습니다.",
            title: "3. "),
        const SizedBox(height: 6),
        buildParagraph("계정 공유 중 제 3자가 이용자 본인의 계정을 이용하여 약관 위반 행위가 발생한다고 하더 라도 이용자 본인 및 해당 계정에 제재가 적용될 수 있습니다.",
            title: "4. "),
        const SizedBox(height: 4),
        buildParagraph("상업적 광고 행위", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph("“상업적 광고 행위” 란 채팅, 프로필, 게시글 등을 이용하여 이루어지는 아래 각 호의 행위를 의미합니다.", hPadding: _hPaddingDepth2),
        buildParagraph("음란사이트 광고 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("피라미드, 금융 서비스를 광고하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("위법, 위조 등이 가능한 서비스를 광고하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("사행 행위", title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph("“사행행위” 란 아래 각 호의 행위를 의미합니다.", hPadding: _hPaddingDepth2),
        buildParagraph("불법 도박 사이트 서비스를 광고하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("사회통념상 납득되지 않는 서비스를 광고하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("버그 및 제한사항 악용", title: "다. ", hPadding: _hPaddingDepth1),
        buildParagraph("“버그 및 제한사항 악용” 이란 아래 각 호의 행위를 의미합니다.", hPadding: _hPaddingDepth2),
        buildParagraph("고의로 서비스 오류를 이용하여 이득을 얻고, 서비스 내 경제 시스템에 영향을 주는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("고용건수 오류를 이용하여 반복적으로 이를 획득하는 행위", title: "예) ", hPadding: _hPaddingDepth2),
        buildParagraph("고의로 서비스 오류를 이용하여 다른 이용자에게 피해를 주는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("리뷰 작성을 이용하여 다른 이용자에게 고의적 악성 리뷰를 작성하여 피해를 주는 행위", title: "예) ", hPadding: _hPaddingDepth2),
        buildParagraph("고의로 서비스 오류를 이용하여 시스템에 영향을 주는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("프로그램 오류를 이용하여 서버를 다운 시키는 행위", title: "예) ", hPadding: _hPaddingDepth2),
        buildParagraph("어뷰징", title: "라. ", hPadding: _hPaddingDepth1),
        buildParagraph("“어뷰징” 이란 아래 각 호의 행위를 의미합니다.", hPadding: _hPaddingDepth2),
        buildParagraph("고의로 리뷰 및 고용 수 등을 조작하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("일반적으로 서비스에 통용되지 아니하는 방법으로 재화를 늘리는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("비정상적으로 시스템 설계상 제한을 회피하여 이익을 취하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("시스템상 허용되지 않는 방법으로 다른 이용자의 평판 이익을 늘리는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("불건전 언어 사용", title: "마. ", hPadding: _hPaddingDepth1),
        buildParagraph("“불건전 언어 사용” 이란 아래 각 호의 행위를 의미합니다.", hPadding: _hPaddingDepth2),
        buildParagraph("욕설, 비/속어 등을 사용하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("음란한 단어나 노골적인 성 묘사 등을 통해 성적 수치심을 느끼게 하는 표현이나 행 동을 하는 행위",
            title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("다른 이용자에게 불쾌감이나 성적 수치심을 줄 수 있는 명칭을 사용하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("현실에 대한 위협이나 상대방에게 공포심을 느끼게 하는 표현이나 행동을 하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("기타 약관에서 금지하는 표현이나 통신을 하여 상대방에게 불쾌감이나 혐오감을 주는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("제3자의 명예, 초상권, 개인정보를 포함한 제반 권리를 침해, 훼손할 목적의 내용이 포함된 대화등 이에 준하는 행위",
            title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("불건전 이름(닉네임) 사용", title: "바. ", hPadding: _hPaddingDepth1),
        buildParagraph(
            "“불건전 이름 사용” 이란 온라인 문화를 저해하거나 관계 법령 및 사회질서와 미풍 양속을 저해하는 내용과 욕설 또는 음란한 내용으로 만든 이름, 비즈니스 네임 등을 포함 하여 명명 된 아래 각 호의 행위를 의미합니다.",
            hPadding: _hPaddingDepth2),
        buildParagraph("샤이니오 직원 및 관리자 또는 제3자를 사칭하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("욕설, 비/속어 등을 사용하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("다른 이용자에게 불쾌감이나 성적 수치심을 줄 수 있는 명칭을 사용하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("기타 약관에서 금지하는 명칭을 사용하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("관련 계정의 닉네임 등은 임의로 변경될 수 있습니다.", hPadding: _hPaddingDepth2),
        buildParagraph("명의도용", title: "사. ", hPadding: _hPaddingDepth1),
        buildParagraph("“명의도용” 이란 아래 각 호의 행위를 의미합니다.", hPadding: _hPaddingDepth2),
        buildParagraph("타인의 개인정보를 이용하여 계정을 생성하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("결제도용", title: "아. ", hPadding: _hPaddingDepth1),
        buildParagraph("“결제도용” 이란 아래 각 호의 행위를 의미합니다.", hPadding: _hPaddingDepth2),
        buildParagraph("타인의 결제수단을 무단으로 이용하여 서비스 이용요금 등을 결제하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("불건전 게시물 게시", title: "자. ", hPadding: _hPaddingDepth1),
        buildParagraph("“불건전 게시물 게시” 란 아래 각 호의 행위를 의미합니다.", hPadding: _hPaddingDepth2),
        buildParagraph("회사 또는 제3자의 권리(저작권, 특허 등)를 침해하는 게시물", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("본인/타인의 개인정보(신상정보, 위치, 연락처, 이메일 등)이 포함된 게시물", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("다른 사람에게 성적 수치심을 주거나 혐오감, 불쾌감을 유발하는 게시물", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("다른 사람을 비방하거나 음해하는 목적의 게시물(인신공격, 루머 포함)", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("영리 목적의 광고 게시물(경품, 상품광고, 사이트 홍보 등)", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("악성코드가 포함되어 있거나 시스템 장애를 유도하는 게시물", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("특정 사상/종교적 색채가 짙은 게시물", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("특정 개인 및 회사에 대한 허위 사실을 악의적으로 유포하는 게시물", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("인종, 성, 특정 지역을 비하하거나 차별하는 게시물", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("폭력, 비행, 사행심을 조장하는 게시물", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("약관 위반 행위와 관련된 게시물", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("기타 약관, 관련 법령에서 금지하는 게시물", title: "- ", hPadding: _hPaddingDepth2),
        buildParagraph("짧은 시간에 많은 양의 게시물을 등록하거나 동일한 내용을 반복 게시하여 운영을 방 해하는 행위", title: "- ", hPadding: _hPaddingDepth2),
        const SizedBox(height: 6),
        buildParagraph(
            "회원은 회사의 해제.해지 및 이용제한에 대하여 이의신청을 할 수 있습니다. 회원의 이의신 청이 정당한 경우 회사는 즉시 회원이 서비스를 이용할 수 있도록 필요한 조치를 취합니다.",
            title: "5. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 14 조 (회사의 계약해제.해지의 효과)"),
        buildParagraph(
            "회사가 제19조 제2항에 따라 서비스 이용계약을 해제 또는 해지한 경우 회사는 회원에게 손해배상을 청구할 수 있습니다. 다만, 회원이 고의 또는 과실 없음을 증명한 경우에는 그러하지 않습니다.",
            title: "1. "),
        const SizedBox(height: 40),
        //--------------------------------------------------------------------------------------------------------------
        buildMidTitle("제 5 장 바로구매"),
        buildSubTitle("제 15 조 (바로구매)"),
        buildParagraph(
            "회사는 바로구매를 통하여 전문가 회원과 고객 간의 유형의 제품 또는 무형의 용역 거래를 위한 통신판매중개서비스의 운영 및 관리 책임을 제공하며, 바로구매를 통하여 이루어지는 거래와 관련하여 전문가 회원 또는 고객을 대리하지 않습니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("바로구매를 이용한 거래에 동의한 전문가 회원과 고객에 한하여 바로구매를 이용할 수 있습니다.", title: "2. "),
        const SizedBox(height: 6),
        buildParagraph("고객은 회사가 마련한 결제 서비스를 통하여 거래를 완료하여야 하며, 회사는 거래 과정에 서 결제대금예치 서비스(에스크로)를 제공합니다.", title: "3. "),
        const SizedBox(height: 6),
        buildParagraph(
            "바로구매를 이용한 모든 거래는 고객이 금액과 내용을 확인한 후 고객의 요구에 따라 개시 됩니다. 전문가 회원이 서비스를 이행한 이후 고객이 서비스 상 거래 확정 버튼을 클릭하는 방식으로 거래 확정을 하면 회사는 결제대금예치업자를 통해 수수료를 제외한 서비스 금액 을 전문가 회원에게 지급합니다.",
            title: "4. "),
        const SizedBox(height: 6),
        buildParagraph(
            "분쟁 및 그 밖의 사유 발생 시 회사는 합리적인 판단에 따라 전문가 회원과 고객에게 이용 제한 등의 필요한 조치를 취할 수 있으며, 진행 중인 거래의 대금 지급이나 대금 환불을 보 류할 수 있습니다.",
            title: "5. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 16 조 (바로구매 이용료)"),
        buildParagraph("고객은 전문가 회원이 명시한 서비스의 기본 판매 단가 외의 별도의 서비스 이용료를 납부 하지 않습니다.", title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 전문가 회원에게 다음과 같은 서비스 이용료를 부과할 수 있습니다. 서비스 이용료 는 필요에 따라 변경될 수 있으며, 변경될 경우 사전에 공지사항 등을 통해 공지합니다.",
            title: "2. "),
        const SizedBox(height: 4),
        buildParagraph("결제 수수료 및 결제망 이용료", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph("부가서비스 제공 등 이용을 위한 서비스 이용료", title: "나. ", hPadding: _hPaddingDepth1),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 17 조 (전문가 회원의 바로구매 등록 및 이용의 의무 등)"),
        buildParagraph("전문가 회원은 자신이 제공할 수 있는 유형의 제품 또는 무형의 용역을 상품으로 등록하여 바로구매 서비스를 이용할 수 있습니다.", title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "전문가 회원은 회사가 제공하는 일정한 양식에 따라 상품을 등록할 수 있으며, 허위정보 또 는 지식재산권(상표권, 저작권 등) 등 타인의 권리를 침해하는 정보를 기재하지 않아야 합 니다. 이를 위반하는 경우 발생하는 불이익 또는 법적 책임은 전문가 회원 본인에게 있으 며, 회사는 별도의 통지 없이 상품 판매 중단 및 이용 제한 등의 필요한 조치를 취할 수 있 습니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 소비자보호 및 상품의 수준 유지 또는 관련 법령 준수를 위해 전문가 회원이 등록 한 정보가 양식에 맞지 않거나 해당 정보의 사실 및 허위/과장 여부의 증명이 필요한 경우 해당 정보의 수정 또는 증빙을 요구할 수 있으며, 정정이 이루어지기 전까지 상품의 판매를 제한할 수 있습니다.",
            title: "3. "),
        const SizedBox(height: 6),
        buildParagraph("전문가 회원은 서비스 이용료, 부가세를 포함한 기본 판매 단가를 명시하여야 합니다.", title: "4. "),
        const SizedBox(height: 6),
        buildParagraph(
            "전문가 회원은 고객에게 샤이니오를 통해서가 아닌 직접 결제를 요청하지 않아야 합니다. 이를 위반하는 경우 직접 결제 유도 행위 또는 과도한 견적 요청 등으로 간주되며, 회사는 별도의 통지 없이 상품 판매 중단 및 이용 제한 등의 필요한 조치를 취할 수 있습니다. 또 한 저전문가 회원과 일반 회원 간의 직접 결제로 인하여 발생한 문제에 대해 회사는 어떠 한 책임도 지지 않습니다.",
            title: "5. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 소비자보호 및 상품의 수준 유지 또는 관련 법령 준수를 위해 필요에 따라 상품을 등록할 수 있는 전문가 회원의 자격을 정지하거나 기타 필요한 조치를 취하여 회원의 자격 을 제한할 수 있습니다.",
            title: "6. "),
        const SizedBox(height: 6),
        buildParagraph(
            "전문가 회원은 거래가 이루어진 시점부터 고객과의 연락 및 상담, 고객과의 거래 이행 및 결과 제공을 성실하게 수행하여야 하며, 전자상거래법 제 17조에서 정한 기간 동안 고객회 원이 청약철회를 할 수 있도록 조치하여야 합니다. 이를 이행하기 불가능한 경우 고객과 거 래 이행 및 취소 사항에 관해 합의해야 하며, 거래 건의 철회 또는 취소로 인한 불이익은 전문가 회원 본인이 부담하여야 합니다.",
            title: "7. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 18 조 (거래확정 및 취소)"),
        buildParagraph("고객은 결제가 완료된 후 3시간 이내에 제한 없이 주문을 취소하여 대금을 100% 환불받을 수 있습니다.", title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "고객은 결제가 완료된 후 7일 이내 또는 거래 확정 전 전문가 회원과의 협의 하에 취소 및 환불 신청할 수 있으며, 전문가 회원은 다음의 사유에 해당하지 않는 한 고객의 취소 및 환불 신청에 응해야 합니다.",
            title: "2. "),
        const SizedBox(height: 4),
        buildParagraph("전문가 회원이 유형의 제품을 제공하거나 무형의 용역을 개시한 경우", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph("고객이 제공 받은 유형의 제품을 사용하거나 소비하여 재화로써의 가치가 현저히 감소한 경우", title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph("고객의 주문에 따라 개별적으로 생산되는 제품 또는 용역에 대하여 취소 및 환불 시 전문가 회원에게 중대한 피해가 예상되는 경우",
            title: "다. ", hPadding: _hPaddingDepth1),
        buildParagraph("결제가 완료된 후 7일 이내 전문가 회원이 유형의 제품을 제공하거나 무형의 용역을 완료하여 고객이 거래 확정한 경우",
            title: "라. ", hPadding: _hPaddingDepth1),
        const SizedBox(height: 6),
        buildParagraph(
            "고객은 전문가 회원이 서비스 용역 이행을 완료하였을 때 지체 없이 거래 확정을 하여 전 문가 회원에게 대금이 원활히 지급될 수 있도록 하여야 합니다. 다음과 같은 사유로 대금이 지급되지 못하는 경우, 회사는 별도의 통지 없이 거래 확정 등의 필요한 조치를 취할 수 있습니다.",
            title: "3. "),
        const SizedBox(height: 4),
        buildParagraph("전문가 회원이 용역 이행을 완료하였음을 고지하였음에도 고객이 5일 이상 전문가회원 이나 회사의 연락에 응하지 아니하는 경우",
            title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph("전문가 회원이 용역 이행을 완료하여 이를 고지하였고 고객이 이를 확인하였음에도 고객이 해당 확인 일자로부터 5일 이상 거래 확정을 하지 아니하는 경우",
            title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph("기타 고객이 정당한 사유 없이 거래확정을 아니하여 회사가 거래 확정처리를 하는 경우", title: "다. ", hPadding: _hPaddingDepth1),
        const SizedBox(height: 6),
        buildParagraph(
            "전문가 회원이 다음과 같이 정당한 사유 없이 환불 의무를 다하지 않는 경우 회사는 전문가 회원에게 환불 의사가 있다고 간주하고 대금 환불 관련 절차를 진행할 수 있습니다. 다음과 같은 사유로 대금이 환불되지 못하는 경우, 회사는 별도의 통지 없이 거래 취소 등의 필요한 조치를 취할 수 있습니다.",
            title: "4. "),
        const SizedBox(height: 4),
        buildParagraph("고객이 환불을 요청하였고 이를 고지하였음에도 전문가 회원이 5일 이상 고객이나 회사의 연락에 응하지 아니하는 경우",
            title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph("고객이 환불을 요청 및 고지하였고 전문가 회원이 이를 확인하였음에도 해당 확인 일자로부터 5일 이상 환불에 동의하지 아니하는 경우",
            title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph("용역 이행이 개시되지 않은 시점에 고객이 환불을 요청하였고 이를 고지하였음에도 전문가 회원이 환불 동의를 거부하는 경우",
            title: "다. ", hPadding: _hPaddingDepth1),
        buildParagraph("기타 전문가 회원이 정당한 사유 없이 환불 동의를 거부하여 회사가 거래를 환불하는 경우", title: "라. ", hPadding: _hPaddingDepth1),
        const SizedBox(height: 6),
        buildParagraph(
            "판매된 상품에 대한 고객의 거래 확정이 이루어지는 경우, 회사는 곧바로 대금에서 서비스이용료, 회사에 대한 미납금 및 기타 채무금액을 공제한 나머지 금액을 전문가 회원에게 지급하는 것을 원칙으로 합니다. 다만 금융기관 또는 전기통신사업자의 귀책 등 회사의 귀책 사유가 아닌 사유로 지급이 늦어질 수 있습니다.",
            title: "5. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 자사의 서비스 정산 정보를 이용하여 전문가 회원에게 대금을 지급하며, 고객이 거 래 확정을 한 이후에도 전문가 회원의 정산정보 등록이 완료되지 않았을 경우에는 대금의 지급이 보류됩니다.",
            title: "6. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 19 조 (바로구매에 대한 회사의 면책)"),
        buildParagraph(
            "회사는 전문가 회원과 고객 간의 상품 공급과 이용을 위한 중개 서비스만을 제공할 뿐, 전문가 회원이 바로구매를 통해 취급하는 상품에 대하여 어떠한 보증을 제공하지 아니합니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 바로구매를 이용하는 전문가 회원과 고객 중 어느 일방을 대리, 대행하거나 그 이행을 보조하는 위치에 있지 아니합니다. 회사는 거래 당사자 간 자금의 흐름에 직접 관여하거나 개입하지 않으며, 샤이니오와 계약을 체결한 결제대금 예치업자가 고객 회원이 입금한 금액을 전문가 회원에게 전달합니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph("회원이 바로구매 이용시 잘못된 정보를 입력하여 잘못된 대금지급이 이루어졌을 경우 회사는 이에 대하여 책임지지 않습니다.", title: "3. "),
        const SizedBox(height: 6),
        buildParagraph(
            "고객이 거래를 확정하면 바로구매 거래가 종료됩니다. 따라서 거래 확정을 통하여 대금의 지급이 완료된 이후 발생한 분쟁 또는 불만 사항은 원칙적으로 거래 당사자 간 협의를 통해 해결해야 합니다. 거래 확정 후 전문가 회원의 정산 정보 미등록으로 인한 거래 승인 대기 중에도 거래 확정은 철회되지 않습니다.",
            title: "4. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회원, 결제대행업체, 금융기관 등과의 사이에 발생한 분쟁은 당사자 간의 해결을 원칙으로 하며, 회사는 이와 관련한 어떠한 책임도 지지 않으며, 해당 사안의 결제대행업체 또는 금융기관의 약관이 우선됩니다.",
            title: "5. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 전문가 회원과 고객 간의 거래와 관련하여 판매의사 또는 구매의사의 존부 및 진정성, 전문가 회원이 제공하는 유형의 제품 또는 무형의 용역품질, 안전성, 적법성, 타인의권리에 대한 비침해성 등 일체에 대하여 보증하지 아니하며, 이와 관련한 일체의 위험과 책임은 해당 전문가 또는 구매회원이 직접 부담해야 합니다.",
            title: "6. "),
        const SizedBox(height: 40),
        //--------------------------------------------------------------------------------------------------------------
        buildMidTitle("제 6 장 개인 정보의 처리"),
        buildSubTitle("제 20 조 (회원의 개인정보 보호)"),
        buildParagraph(
            "회사는 회원의 개인정보를 보호하기 위하여 정보통신망법 및 개인정보 보호법 등 관계법 령에서 정하는 바를 준수하며 이용자의 개인 식별이 가능한 개인정보를 수집하는 때에는 반드시 당해 이용자의 동의를 받습니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("회사의 개인정보 보호는 샤이니오 개인정보처리방침에 따릅니다.", title: "2. "),
        const SizedBox(height: 40),
        //--------------------------------------------------------------------------------------------------------------
        buildMidTitle("제 7 장 당사자의 의무"),
        buildSubTitle("제 21 조 (회사의 의무)"),
        buildParagraph("회사는 회원이 희망한 서비스 제공 개시일에 특별한 사정이 없는 한 서비스를 이용할 수 있도록 하여야 합니다.", title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 계속적이고 안정적인 서비스의 제공을 위하여 설비에 장애가 생기거나 기계의 결함이 있는 때에는 부득이한 사유가 없는 한 지체 없이 이를 수리 또는 복구합니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 개인정보 보호를 위해 보안시스템을 구축하며 개인정보 보호정책을 공시하고 준수 합니다.", title: "3. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 회원으로부터 제기되는 의견이나 불만이 정당하다고 객관적으로 인정될 경우에는 적절한 절차를 거쳐 즉시 처리하여야 합니다. 다만, 즉시 처리가 곤란한 경우는 이용자에게 그 사유와 처리일정을 통보하여야 합니다.",
            title: "4. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 22 조 (회원의 의무)"),
        buildParagraph("회원은 다음 각 호의 행위를 하여서는 안 됩니다.", title: "1. "),
        const SizedBox(height: 4),
        buildParagraph("회원가입신청 또는 변경 시 허위내용을 등록하는 행위", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph("샤이니오에 게시된 정보를 허위로 변경하는 행위", title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph("회사 기타 제3자의 인격권 또는 지적재산권을 침해하거나 업무를 방해하는 행위", title: "다. ", hPadding: _hPaddingDepth1),
        buildParagraph("다른 회원의 ID를 도용하는 행위", title: "라. ", hPadding: _hPaddingDepth1),
        buildParagraph("관련 법령에 의하여 그 전송 또는 게시가 금지되는 정보(컴퓨터 프로그램 등)의 전송 또는 게시하는 행위",
            title: "마. ", hPadding: _hPaddingDepth1),
        buildParagraph("회사의 직원이나 관리자를 가장하거나 사칭하여 또는 타인의 명의를 오용하여 글을 게시하거나 메일을 발송하는 행위",
            title: "바. ", hPadding: _hPaddingDepth1),
        buildParagraph(
            "컴퓨터 소프트웨어, 하드웨어, 전기통신 장비의 정상적인 가동을 방해, 파괴할 목적으로 고안된 소프트웨어 바이러스, 기타의 다른 컴퓨터 코드, 파일, 프로그램을 포함하고 있 는 자료를 게시하거나 전자우편으로 발송하는 행위",
            title: "사. ",
            hPadding: _hPaddingDepth1),
        buildParagraph("스토킹(stalking) 등 다른 회원을 괴롭히는 행위", title: "아. ", hPadding: _hPaddingDepth1),
        buildParagraph("다른 회원에 대한 개인정보를 그 동의 없이 수집, 저장, 공개하는 행위", title: "자. ", hPadding: _hPaddingDepth1),
        buildParagraph(
            "회사가 제공하는 서비스에 정한 약관 기타 서비스 이용에 관한 규정을 위반하는 행위 카. 외설 또는 폭력적인 메시지ᆞ화상ᆞ음성 기타 공서양속에 반하는 정보를 공개 또는 게시하는 행위",
            title: "차. ",
            hPadding: _hPaddingDepth1),
        buildParagraph("사실관계를 왜곡하는 정보제공 등 기타 회사가 부적절하다고 판단하는 행위", title: "타. ", hPadding: _hPaddingDepth1),
        buildParagraph("제1호 내지 제12호 기타 부정한 방법으로 샤이니오 결제 시스템을 이용한 경우", title: "파. ", hPadding: _hPaddingDepth1),
        buildParagraph("기타 관계 법령이나 회사에서 정한 규정에 위배되는 행위", title: "하. ", hPadding: _hPaddingDepth1),
        const SizedBox(height: 6),
        buildParagraph("회원이 개인의 정보를 허위 또는 잘못 기재하여 생기는 불이익에 대한 책임은 회원 본인에게 있으며, 이에 대해 회사는 아무런 책임이 없습니다.", title: "2. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사가 사이트 운영상 부적절하다고 판단한 정보가 게시된 경우, 회사는 게시를 행한 자의 승낙없이 게재된 당해 정보를 삭제할 수 있습니다. 단, 회사는 이러한 정보의 삭제 등을 할 의무를 지지 않습니다.",
            title: "3. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 회원이 본 약관 또는 당사 정책에 위반되는 내용의 메시지를 프로필 영역에 작성하거나 타 회원에게 해당 메시지 내용을 발송하는 경우 별도의 통지 없이 작성 또는 발송된 내용을 임의로 수정 또는 삭제할 수 있습니다.",
            title: "4. "),
        const SizedBox(height: 6),
        buildParagraph(
            "제1항에 해당하는 행위를 한 회원이 있을 경우 회사는 본 약관 제12조, 제21조에서 정한 바에 따라 회원의 회원자격을 적절한 방법으로 제한 및 정지, 상실시킬 수 있으며, 특히 아래 각 호에 해당하는 행위를 할 경우에는 각각에 대응되는 조치를 취할 수 있습니다. 다만, 회사가 취할 수 있는 조치는 아래 각 호에 한정되지 아니하며, 회사가 조치를 취할 수 있는 회원의 불법적인 행위 역시 아래 각 호의 경우에 한정되지 아니합니다.",
            title: "5. "),
        const SizedBox(height: 4),
        buildParagraph(
            "타 회원들에 대한 무단 마케팅(요청서 및 견적에 제공 용역에 대한 내용 외 본인의 영리 적 목적을 위한 내용을 무단으로 작성하는 것을 의미하며 광고 등을 포함): 모든 기능 사용 정지",
            title: "가. ",
            hPadding: _hPaddingDepth1),
        buildParagraph("타 회원들에 대한 부적절한 대화 시도 및 메시지 발송 등(욕설, 성희롱, 기타 부적절한 표현을 포함함): 모든 기능 사용 정지(영구 제재)",
            title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph(
            "타 회원들에게 허위사실을 유포하거나 표시광고를 위반하는 경우(견적에 회사에 상당한 수수료를 지불하고 있어, 절대 채팅으로 답변하지 말라는 내용을 기재하거나, 명함에 샤이니오 로고를 무단으로 표시하고 자신을 샤이니오 협력사로 소개하는 등을 포함함): 모든 기능 사용 정지(영구 제재)",
            title: "다. ",
            hPadding: _hPaddingDepth1),
        buildParagraph(
            "전문가 회원의 의무 및 서비스 정책 위반(프로필에 계속하여 휴대폰 번호 등 개인정보 를 노출, 요청서 또는 견적에 본인 연락처를 작성하여 직접 연락을 유도하는 등의 경우 를 포함함): 모든 기능 사용 정지",
            title: "라. ",
            hPadding: _hPaddingDepth1),
        const SizedBox(height: 6),
        buildParagraph("회원은 그 귀책사유로 인하여 회사나 다른 회원이 입은 손해를 배상할 책임이 있습니다.", title: "6. "),
        const SizedBox(height: 6),
        buildParagraph("회원은 서비스의 이용과 관련하여 관계법령, 약관, 세부이용지침, 서비스 이용안내 및 회사 가 통지한 공지사항 등을 준수하여야 하며, 이를 수시로 확인하여야 합니다.",
            title: "7. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 23 조 (고객의 의무)"),
        buildParagraph("고객은 제공받기 원하는 용역에 대한 내용으로 요청서를 작성하여 회사에 제공하고 회사가 이를 다수의 전문가 회원에게 전달하는 것에 대하여 동의합니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "고객은 허위나 과장된 내용으로 요청서를 작성하거나 또는 용역을 제공받고자 하는 의사가 없음에도 요청서를 작성할 수 없으며 허위 및 과장된 내용으로 요청서를 작성함에 따라 용 역을 제공받지 못하거나 법적인 문제가 발생할 경우 이에 대한 책임은 고객에게 있습니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph(
            "고객은 용역을 구매하기 전에 반드시 전문가 회원이 견적에 작성한 용역의 상세 내용과 거 래의 조건을 정확하게 확인해야 합니다. 구매하려는 용역의 내용과 거래의 조건을 확인하 지 않고 구매하여 발생한 모든 손실과 손해는 고객 본인이 부담합니다.",
            title: "3. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 24 조 (전문가 회원의 서비스 관련 의무)"),
        buildParagraph(
            "전문가 회원은 용역의 제공, 계약내용의 변경, 용역 대금 결제 및 환불 등 용역 제공과 관 련한 일체의 업무를 처리하며, 이를 신의성실 하게 이행하여야 할 의무가 있습니다. 또한 용역 제공과 관련하여 발생하는 모든 책임과 의무를 부담합니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "전문가 회원이 작성한 견적, 프로필 등에 허위 또는 과장, 기재누락, 오기가 있어서는 아니 되며 이를 준수하지 아니하여 발생하는 모든 법적문제에 대하여는 전문가 회원이 모든 책 임을 부담합니다. 전문가 회원은 해당 견적 및 제공 용역에 대한 진실성과 적법성에 대해 보증합니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph("전문가 회원은 작성한 견적, 용역의 내용, 용역 제공 시기 등 내용의 변경 사항이 있을 경우 이를 바로 갱신하여야 할 의무를 집니다.", title: "3. "),
        const SizedBox(height: 6),
        buildParagraph(
            "전문가 회원은 관련법령 등을 위반하는 불법적인 용역을 제공하지 않는 다른 점에 대해 보 증하며 불법적이거나 본 이용약관을 위반하는 내용으로 견적및 허위 내용을 작성하여 고객 에게 송부할 수 없습니다.",
            title: "4. "),
        const SizedBox(height: 6),
        buildParagraph(
            "전문가 회원은 견적을 수령한 고객과의 샤이니오 서비스에서 제공하는 메시지 기능이나 전 화 등 별도의 연결수단을 통하여 세부사항을 조정할 수 있습니다. 회사는 견적 발송 이후 전문가 회원과 고객 간에 발생한 일체의 문제에 대하여 어떠한 책임도 지지 않습니다.",
            title: "5. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 25 조 (회원의 ID 및 비밀번호에 대한 의무)"),
        buildParagraph("원칙적으로 ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.", title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("회원은 자신의 ID 및 비밀번호를 제 3자에게 이용하게 해서는 안 되며, 그로 인한 모든 책 임은 회원에게 있습니다.", title: "2. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 회사에 통보하고 회사의 안내가 있는 경우 그에 따라야 합니다. 만약 회원이 위 사실 을 인지하고도 회사에 대한 통보를 지체함으로써 발생한 손해에 대해서 회사는 배상할 의 무가 없습니다.",
            title: "3. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 26 조 (게시물 또는 내용물의 삭제)"),
        buildParagraph(
            "회원이 회사에 등록하는 게시물 및 타인 게시물의 활용 등으로 인하여 본인 또는 타인에게 손해나 기타 문제가 발생하는 경우 회원은 이에 대한 책임을 지게 되며, 회사는 이에 대하 여 책임을 지지 않습니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 회원이 게시하거나 등록한 내용이 제27조 제 1항의 규정에 위반되거나 회사 소정의 게시기간을 초과하는 경우 사전 통지나 동의 없이 이를 삭제할 수 있습니다. 그러나 회사가 이러한 정보의 삭제 등을 할 의무를 지는 것은 아닙니다.",
            title: "2. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 27 조 (저작권의 귀속 및 권리, 의무)"),
        buildParagraph("회사가 작성한 저작물에 대한 저작권 기타 지식재산권은 회사에 귀속합니다.", title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회원은 회사의 서비스를 이용함으로써 얻은 정보를 회사의 사전승낙 없이 복제, 전송, 출 판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서 는 안 됩니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph("회원이 작성한 게시물에 대한 모든 권리 및 책임은 이를 게시한 회원에게 있습니다.", title: "3. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 회원 또는 요청자가 사이트에 게시한 다음 각 호의 게시물을 회사의 서비스 제공과 관련한 마케팅 용도로 사용ᆞ복제ᆞ수정ᆞ출판ᆞ배포 할 수 있습니다. 단, 회사는 게시물 이용 시 전문가 또는 요청자의 개인정보가 포함되지 않는 범위에서 해당 정보를 처리하고, 최대한 작성자의 권리를 보호할 수 있도록 노력할 것입니다.",
            title: "4. "),
        const SizedBox(height: 4),
        buildParagraph("전문가의 프로필 정보", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph("요청자 및 전문가가 작성한 후기(이에 포함된 글 및 사진)", title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph("요청서 및 견적의 내용", title: "다. ", hPadding: _hPaddingDepth1),
        buildParagraph("회사와 요청자 또는 전문가 사이의 연락 내용", title: "라. ", hPadding: _hPaddingDepth1),
        buildParagraph("기타 요청자 및 전문가가 서비스 이용과정에서 작성·게시한 콘텐츠", title: "마. ", hPadding: _hPaddingDepth1),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 28 조 (광고주 및 연결 사이트와의 관계)"),
        buildParagraph("회사의 공식 사이트 이외의 웹사이트 및 이메일에서 링크된 사이트에서는 회사의 개인정보 보호정책 및 본 약관이 적용되지 않습니다.", title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 샤이니오 사이트 또는 e-mail 상에 게재되어 있거나 본 서비스를 통한 광고주의 판촉활동에 회원이 참여하거나 교신 또는 거래를 함으로써 발생하는 손실과 손해에 대해 책임을 지지 않습니다.",
            title: "2. "),
        //--------------------------------------------------------------------------------------------------------------
        const SizedBox(height: 40),
        buildMidTitle("제 8 장 기타"),
        buildSubTitle("제 29 조 (양도의 금지)"),
        buildParagraph("회원은 서비스 이용 권리를 타인에게 대여, 양도 또는 증여 등을 할 수 없으며, 또한 질권의 목적으로도 사용할 수 없습니다."),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 30 조 (면책)"),
        buildParagraph(
            "회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 고의 또는 과실이 없는 한 구매자에게 발생한 손해에 대하여 서비스 제공에 관한 책임이 면제됩니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 회원의 귀책사유로 인한 서비스 이용의 장애에 대하여 책임을 지지 않습니다.", title: "2. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 회원이 서비스의 이용을 통해 예상했던 금전적인 수익을 얻지 못하게 되거나, 서비스를 통하여 얻은 자료로 인해 손해를 보게 되더라도 이에 관하여 책임을 지지 않습니다.",
            title: "3. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 회원이 서비스에 게재한 정보, 자료, 사실의 신뢰도, 정확성 등의 내용에 관하여는, 회사가 해당 정보의 허위성을 명백히 인지하였다는 특별한 사정이 없는 한, 책임을 지지 않습니다. 회사가 본 약관과 관련 법령에 따른 조치를 취한 경우에도 같습니다.",
            title: "4. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 서비스 이용과 관련하여 회사의 고의, 과실에 의하지 아니한 손해에 대하여 책임을 지지 않습니다.", title: "5. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 기간통신 사업자가 전기통신 서비스를 중지하거나 정상적으로 제공하지 아니하여 손해가 발생한 경우 책임이 면제됩니다.", title: "6. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 회원들에게 요청서와 견적을 전달하거나 광고플랫폼을 제공하고 이에 대한 부수적인 서비스를 제공할 뿐이므로 회원 상호간 서비스를 매개로 하여 거래를 한 경우 이용자 각자의 의무이행에 대한 책임은 각 이용자에게 있으며 회사는 이에 대한 책임이 없습니다.",
            title: "7. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 회원들에게 요청서와 견적을 전달하거나 광고플랫폼 서비스를 제공하고 이에 대한 부수적인 서비스를 제공할 뿐이므로 전문가 회원과 일반회원 간 거래와 관련하여 발생한 의무의 불완전 이행, 이행 지체 등 용역 이행 미비, 사후처리, 대금 정산, 완성품의 하자, 청약철회, 물품의 반품 등 어떠한 법적 분쟁 및 사후처리에 대해서도 개입하거나 책임지지 않습니다.",
            title: "8. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 무료로 제공되는 서비스 이용과 관련하여 관련법에 특별한 규정이 없는 한 책임을 지지 않습니다.", title: "9. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 회원 간에 분쟁이 발생하였을 경우 고의 또는 중과실이 없는 한 회원 간 법적 문제에 대하여 책임을 지지 않습니다.", title: "10. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 31 조 (손해배상)"),
        buildParagraph("당사자 일방이 본 계약상 의무를 위반함으로 인하여 상대방에게 손해가 발생한 경우, 귀책사유가 있는 당사자는 상대방이 입은 손해를 배상합니다."),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 32 조 (비밀유지)"),
        buildParagraph("당사자는 서비스를 이용하는 과정에서 알게 된 상대방의 정보 또는 이용자의 정보를 제3자 에게 누설, 공개하지 아니합니다.", title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("본 조는 이용계약이 해지되거나 서비스 제공이 중단된 이후에도 유효합니다.", title: "2. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 33 조 (고객센터)"),
        buildParagraph(
            "회사는 이용자에게 생긴 문제를 해결하기 위해 최선을 다하며 이를 위하여 이용자로부터 고객센터에 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보합니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사와 이용자 간 분쟁이 발생할 경우 양자 간 합의에 의하여 처리하는 것을 원칙으로 하며 회사는 이용자 간 발생한 법적 문제에 대하여 고의 또는 중과실이 없는 한 책임이 없습니다. 그러나 회사는 고객센터를 통하여 피해 사항을 적극적으로 청취하여 이용자들간 발생한 문제가 해결하는 데에 도움이 될 수 있도록 최선을 다합니다.",
            title: "2. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 34 조 (재판권 및 준거법)"),
        buildParagraph("회사와 이용자 간 발생한 분쟁에 관한 소송의 관할은 민사소송법에 따라 정합니다.\n2. 회사와 이용자 간에 제기된 소송에는 대한민국 법을 적용합니다.",
            title: "1. "),
        const SizedBox(height: 40),
        //--------------------------------------------------------------------------------------------------------------
        buildMidTitle("부칙"),
        buildSubTitle("제1조 (시행일)"),
        buildParagraph("이 약관은 2022년 01월 25일부터 시행합니다."),
        const SizedBox(height: 40),
        buildBottomBar,
      ],
    );
  }

  Widget buildPrivacyTerms() {
    return Column(
      children: [
        //--------------------------------------------------------------------------------------------------------------
        buildParagraph(
            "주식회사 유플랫폼(이하 “회사”)은 이용자들의 개인정보보호를 매우 중요시하며, 이용자가 회사의 서비스 사이트를 이용함과 동시에 온라인상에서 회사에 제공한 개인정보가 보호 받을 수 있도록 최선을 다하고 있으며, 『개인정보 보호법』,『정보통신망 이용촉진 및 정보보호 등에 관한 법률』등 개인정보와 관련된 법령 상의 개인정보보호 규정을 준수하고 있습니다."),
        const SizedBox(height: 4),
        buildParagraph(
            "회사는 아래와 같이 개인정보처리방침을 명시하여 이용자가 회사에 제공한 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치를 취하는지 알려드립니다. 회사의 개인정보처리방침은 법령 및 고시 등의 변경 또는 회사의 약관 및 내부 정책에 따라 변경될 수 있으며 이를 개정하는 경우 회사는 변경사항에 대하여 서비스 화면에 게시하거나 이용자에게 고지합니다."),
        const SizedBox(height: 4),
        buildParagraph(
            "이용자는 개인정보의 수집, 이용, 제공, 위탁 등과 관련한 아래 사항에 대하여 원하지 않는 경우 동의를 거부할 수 있습니다. 다만, 이용자가 동의를 거부하는 경우 서비스의 전부 또는 일부를 이용할 수 없음을 알려드립니다."),
        const SizedBox(height: 4),
        buildParagraph("이용자께서는 홈페이지 방문 시 수시로 본 개인정보처리방침을 확인하시기 바랍니다."),
        const SizedBox(height: 40),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 1 조 (개인정보의 수집목적 및 이용목적)"),
        buildParagraph("회사는 이용자의 사전 동의 없이는 이용자의 개인 정보를 공개하지 않으며, 다음과 같은 목적을 위하여 개인정보를 수집하고 이용합니다.", title: "1. "),
        const SizedBox(height: 4),
        buildParagraph("서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금 정산", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph(
            "견적서·요청서 정보 제공 및 프로필 광고노출, 멤버십 등 기본적인 서비스 제공, 서비스 제공에 관한 계약 체결·유지·이행·관리·개선 및 서비스 제공에 따른 요금 정산 및 컨텐츠 서비스 이용, 구매 및 요금결제, 물품 배송 또는 청구지 등 발송, 이용자 레슨 정보 및 서비스 이용 정보 제공, 금융거래 본인 인증 및 금융서비스, 요금 추심",
            hPadding: _hPaddingDepth2),
        buildParagraph("회원관리", title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph(
            "회원제 서비스에 따른 본인 확인, 개인 식별, 불량회원의 부정 이용 방지와 비인가 사용 방지, 회원 가입∙유지∙탈퇴 의사 확인, 연령확인, 법령상 의무 이행, 법령 및 약관 위반 여부에 관한 조사, 고객 센터 운영 불만처리 등 민원 처리, 고지사항 전달, 샤이니오 보증 금액 지급 시 본인 확인 등",
            hPadding: _hPaddingDepth2),
        buildParagraph("마케팅 및 광고에 활용", title: "다. ", hPadding: _hPaddingDepth1),
        buildParagraph(
            "신규 서비스(제품) 개발 및 특화, 뉴스레터, 이벤트 등 광고성 정보 전달, 인구통계학적 특성에 따른 서비스 제공 및 광고 게재, 마케팅 및 광고 등에 활용, 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계, 신규 상품 안내 텔레마케팅",
            hPadding: _hPaddingDepth2),
        const SizedBox(height: 6),
        buildParagraph("수집하는 개인정보 항목에 따른 이용 목적은 다음과 같습니다.", title: "2. "),
        const SizedBox(height: 4),
        buildParagraph("성명, 아이디, 비밀번호: 회원제 서비스 이용에 따른 본인 확인, 회원 가입·유지·탈퇴", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph("이메일주소, 전화번호: 고지사항 전달, 불만처리 등을 위한 원활한 의사소통 경로의 확보, 새로운 서비스 및 신상품이나 이벤트 정보 등의 안내",
            title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph("신용카드정보(카드사 이름, 카드 번호 16자리, 카드 유효기간, 카드 명의자 생년월일): 서비스 및 부가 서비스 이용에 대한 요금 결제",
            title: "다. ", hPadding: _hPaddingDepth1),
        buildParagraph("고객센터 이용고객과의 통화 녹음: 고객센터 및 기본 서비스 개선", title: "라. ", hPadding: _hPaddingDepth1),
        buildParagraph("이메일, 전화번호 및 기타 선택 항목: 개인맞춤 서비스를 제공하기 위한 자료, 마케팅 활동", title: "마. ", hPadding: _hPaddingDepth1),
        buildParagraph("일반회원과 전문가 회원 간의 통화 녹음: 일반회원과 전문가 회원 간 분쟁 발생 시, 문제 확인을 위함",
            title: "바. ", hPadding: _hPaddingDepth1),
        buildParagraph("계좌 정보: 본인 계좌 및 허위 계좌 여부 확인", title: "사. ", hPadding: _hPaddingDepth1),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 2 조 (수집하는 개인정보 항목)"),
        buildParagraph("회사는 이용자들이 회원서비스를 이용하기 위해 회원으로 가입할 때 서비스 제공을 위하여 아래와 같은 개인정보를 필수적으로 수집하고 있습니다.", title: "1. "),
        const SizedBox(height: 4),
        buildParagraph("필수 항목:", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph(
            "이용자의 성명, 아이디, 비밀번호, 이메일 주소, 휴대전화번호, 은행계좌정보, 서비스 이 용기록, 접속 로그기록, 결제기록, 쿠키, IP Address, 불량 이용 기록, 고객센터 이용 시 고객센터 통화 내용",
            hPadding: _hPaddingDepth2),
        buildParagraph("선택 항목:", title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph("마케팅·이벤트 정보제공을 위하여 수집한 추가 개인정보", hPadding: _hPaddingDepth2),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 설문조사나 이벤트 행사 시 통계분석이나 경품제공 등을 위해 선별적으로 개인정보 입력을 요청할 수 있습니다. 회사가 발송하는 뉴스레터 내의 광고 메일 수신에 동의하셔서, 메일 수신과 함께 이벤트, 경품 등의 혜택을 받는 광고 메일 수신자가 되는 경우에도 선별 적으로 개인정보 입력을 요청받을 수 있습니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 자사의 교육 및 컨설팅 서비스 진행을 위해 아래 정보를 수집하고 있습니다.", title: "3. "),
        const SizedBox(height: 12),
        kHorizontalLine,
        Row(
          children: [
            const SizedBox(width: 20),
            Container(
              width: 1,
              height: 42,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                height: 42,
                color: const Color(0xFFE4E7ED),
                alignment: Alignment.center,
                child: const Text(
                  "분류",
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.0,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 42,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                height: 42,
                color: const Color(0xFFE4E7ED),
                alignment: Alignment.center,
                child: const Text(
                  "수집·이용\n동의 목적",
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.3,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 42,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                height: 42,
                color: const Color(0xFFE4E7ED),
                alignment: Alignment.center,
                child: const Text(
                  "항목",
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.0,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 42,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                height: 42,
                color: const Color(0xFFE4E7ED),
                alignment: Alignment.center,
                child: const Text(
                  "보유·이용기간",
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.0,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 42,
              color: const Color(0xFFE4E7ED),
            ),
            const SizedBox(width: 20),
          ],
        ),
        kHorizontalLine,
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 20),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "선택 정보",
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.0,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: const Text(
                  "공간정리교육 제공 및 소비자 분쟁 해결, 환불 처리",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: const Text(
                  "이메일을 통한 계정 등록 시\n성명, 이메일, 비밀번호\n타서비스(네이버, 페이스북, 카카오 등) 통한 계정 등록 시 성명, 이메일, 비밀번 호, 고유식별자 ID\n\n주문자 성함, 이메일, 휴대전화번호, 수취주소, 결제정보\n신용카드결제:카드사코드, 승인번호 등 결제관련 기록 무통장결제:가상계좌번호 등 결제관련 기록",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: const Text(
                  "개인정보 이용목적 달성 시까지. 단, 관계법령에 의해 보존할 필요성이 있는 경우 그 시점까지 보존 후 지체없이 파기",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            const SizedBox(width: 20),
          ],
        ),
        kHorizontalLine,
        const SizedBox(height: 8),
        buildParagraph(
            "회사는 이용자가 필요로 할 경우 본인확인 및 지급계좌 확인, 지급금액에 대한 기타소득 원 천징수 영수증 발급을 위해 별도의 신청양식 및 개인정보 수집 및 이용 동의를 통해 주민 등록번호와 계좌 정보를 요청할 수 있습니다.",
            title: "4. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 이용자의 기본적 인권 침해의 우려가 있는 민감한 개인정보(인종 및 민족, 사상 및 신조, 출신지 및 본적지, 정치적 성향 및 범죄기록, 건강상태 및 성생활 등)는 수집하지 않 으며 부득이하게 수집해야 할 경우 이용자들의 사전동의를 반드시 구할 것입니다.",
            title: "5. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 어떤 경우에라도 입력하신 정보를 이용자들에게 사전에 밝힌 목적 이외에 다른 목 적으로는 사용하지 않으며 외부로 유출하지 않습니다.", title: "6. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 이용자 및 회원 간 거래에서 분쟁을 예방하기 위하여 이용자에게 실명인증을 요구 할 수 있습니다.", title: "7. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 3 조 (개인정보 수집 방법)"),
        buildParagraph(
            "회사는 샤이니오 회원가입, 회원정보수정, 서면양식, 전화 또는 팩스, 서비스 이용, 제휴사로부터의 제공, 이메일, 이벤트 참여, 고객센터, 게시판과 같은 방법을 통하여 개인정보를 수집합니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "이용자는 회사가 마련한 개인정보 처리방침 또는 이용약관의 내용에 대해 동의 버튼을 클릭함으로써 개인정보 수집에 대하여 동의여부를 표시할 수 있으며, 동의 버튼을 클릭할 경우에는 개인정보 수집에 동의한 것으로 봅니다.",
            title: "2. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 4 조 (수집하는 개인정보의 보유 및 이용기간)"),
        buildParagraph(
            "법령에서 별도로 정하거나 귀하와 별도 합의하는 등의 특별한 사정이 없는 한 이용자가 샤 이니오 회원으로서 회사에 제공하는 서비스를 이용하는 동안 또는 제1조에서 정한 목적을 달성할 때까지 회사는 이용자들의 개인정보를 계속적으로 보유하며 서비스 제공 등을 위해 이용합니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "이용자의 개인정보는 다음과 같이 개인정보의 수집목적 또는 제공받은 목적이 달성되면 파 기하는 것을 원칙으로 합니다. 다만, 회사는 서비스 혼선 방지, 수사기관에 대한 협조, 불량 회원의 부정한 이용의 재발 및 재가입을 방지하고 분쟁 해결을 위하여 이용계약 해지일로 부터 6개월간 해당 회원의 이름, 아이디, 연락처, 부정이용 내역(서비스 이용기록, 접속로그, 쿠키, 접속IP정보)을 보관합니다. 공간정리교육의 경우 서비스 이용 혼란 및 부정 이용 방지를 위해 일반 회원 개인 정보를 1년간 보관하며, 통신비밀보호법을 준수하기 위해 서비스 이용관련 정보(서비스 이용기록, 접속로그, 접속IP정보)를 3개월간 보관합니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph(
            "상법, 전자상거래 등에서의 소비자보호에 관한 법률 등 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다. 이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다.",
            title: "3. "),
        const SizedBox(height: 4),
        buildParagraph("표시. 광고에 관한 기록: 6월 (전자상거래등에서의 소비자보호에 관한 법률)", title: "ㆍ", hPadding: _hPaddingDepth1),
        buildParagraph("계약 또는 청약철회 등에 관한 기록 : 5년 (전자상거래등에서의 소비자보호에 관한 법률)", title: "ㆍ", hPadding: _hPaddingDepth1),
        buildParagraph("대금결제 및 재화 등의 공급에 관한 기록 : 5년 (전자상거래등에서의 소비자보호에 관한법률)", title: "ㆍ", hPadding: _hPaddingDepth1),
        buildParagraph("소비자의 불만 또는 분쟁처리에 관한 기록 : 3년 (전자상거래등에서의 소비자보호에 관한 법률)", title: "ㆍ", hPadding: _hPaddingDepth1),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 5 조 (개인정보 제3자 제공)"),
        buildParagraph(
            "회사는 이용자들의 개인정보를 제1조에서 고지한 범위 내에서 사용하며, 이용자의 사전 동 의 없이는 동 범위를 초과하여 이용하거나 원칙적으로 이용자의 개인정보를 외부에 공개하 지 않습니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("다만, 아래의 경우에는 예외로 합니다.", title: "2. "),
        const SizedBox(height: 4),
        buildParagraph("이용자들이 사전에 동의한 경우", title: "가", hPadding: _hPaddingDepth1),
        buildParagraph("서비스 제공에 따른 요금정산을 위하여 필요한 경우", title: "나", hPadding: _hPaddingDepth1),
        buildParagraph("법령에 특별한 규정이 있는 경우", title: "다", hPadding: _hPaddingDepth1),
        buildParagraph("통계작성, 학술연구나 시장조사를 위하여 특정개인을 식별할 수 없는 형태로 광고주, 협력업체나 연구단체 등에 제공하는 경우",
            title: "라", hPadding: _hPaddingDepth1),
        const SizedBox(height: 6),
        buildParagraph("다만 아래와 같이 샤이니오 서비스 결제 시 개인정보를 제공 받는 자, 제공목적, 제공 항목, 이용 및 보유기간을 회원에게 고지하여 동의를 구한 후 제3자에게 제공합니다",
            title: "3. "),
        const SizedBox(height: 8),
        kHorizontalLine,
        Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 42,
                color: const Color(0xFFE4E7ED),
                alignment: Alignment.center,
                child: const Text(
                  "제공 받는 자",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 42,
                color: const Color(0xFFE4E7ED),
                alignment: Alignment.center,
                child: const Text(
                  "제공 목적",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 42,
                color: const Color(0xFFE4E7ED),
                alignment: Alignment.center,
                child: const Text(
                  "제공 정보",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 42,
                color: const Color(0xFFE4E7ED),
                alignment: Alignment.center,
                child: const Text(
                  "개인정보 보유\n및 이용기간",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        kHorizontalLine,
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                child: const Text(
                  "공간정리 전문가 및 공간정리 서비스 물품 관련 업체",
                  //textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                child: const Text(
                  "서비스 지역 방문 및 서비스 진행 배송업무 및 반품 교환 수거",
                  //textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                child: const Text(
                  "성명, 휴대폰번호, 서비스 수혜처 주소, 배송지 주소",
                  //textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                child: const Text(
                  "회원탈퇴 시 혹은 위탁계약 종료 시까 지",
                  //textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        kHorizontalLine,
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 6 조 (개인정보의 위탁 처리)"),
        buildParagraph(
            "회사는 서비스 향상을 위해서 이용자의 개인정보를 서비스 제공을 위해서 반드시 필요한 업무 중 일부의 수행을 위하여 본 조 제2항과 같이 개인정보를 위탁하고 있으며, 관계 법령 에 따라 위탁계약 시 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다. 또한 공유하는 정보는 당해 목적을 달성하기 위하여 필요한 최소한의 정보에 국한됩니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("수탁자 및 수탁업무 내용은 아래와 같습니다.", title: "2. "),
        const SizedBox(height: 8),
        kHorizontalLine,
        Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 42,
                color: const Color(0xFFE4E7ED),
                alignment: Alignment.center,
                child: const Text(
                  "위탁 업무 내용",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 42,
                color: const Color(0xFFE4E7ED),
                alignment: Alignment.center,
                child: const Text(
                  "수탁 업체",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 42,
                color: const Color(0xFFE4E7ED),
                alignment: Alignment.center,
                child: const Text(
                  "보유 및\n이용기간",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 42,
              color: const Color(0xFFE4E7ED),
            ),
            const SizedBox(width: 20),
          ],
        ),
        kHorizontalLine,
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "회원가입, 로그인",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "(주)카카오,\n(주)네이버",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "회원 탈퇴 및 위탁 계약 만료 시까지",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        kHorizontalLine,
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "전자 결제 서비스",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "NICE페이먼츠(주)\n(주)다날\n(주)아임포트",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "회원 탈퇴 및 위탁 계약 만료 시까지",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        kHorizontalLine,
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "본인인증 서비스",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "(주)다날",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "목적 달성 시 즉시 파기",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        kHorizontalLine,
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 20),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "SMS/LMS, 이메일, 카카오 알림톡 메시지 발송",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "(주)다우기술",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "목적 달성 시 즉시 파기",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            const SizedBox(width: 20),
          ],
        ),
        kHorizontalLine,
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 20),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "데이터 보관 및 시스템 운영",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "Amazon Web Service",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "회원 탈퇴 또는 개인정보 유효기간 도래시까지 보관",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            const SizedBox(width: 20),
          ],
        ),
        kHorizontalLine,
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 20),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "배송 업무 및 반품 교환 수거",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "CJ 대한통운 (주)",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: const Text(
                  "회원 탈퇴 및 위탁 계약 만료 시까지",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: const Color(0xFFE4E7ED),
            ),
            const SizedBox(width: 20),
          ],
        ),
        kHorizontalLine,
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 7 조 (이용자의 권리)"),
        buildParagraph("회사는 이용자의 권리를 다음과 같이 보호하고 있습니다.", title: "1. "),
        const SizedBox(height: 4),
        buildParagraph("언제든지 자신의 개인정보를 조회하고 수정할 수 있습니다.", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph("언제든지 개인정보 제공에 관한 동의철회/회원가입해지를 요청할 수 있습니다.", title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph(
            "이용자가 개인정보에 대한 열람·증명 또는 정정을 요청하는 경우 회사는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다. 회사는 개인정보 에 오류가 있거나 보존기간을 경과한 것이 판명되는 등 정정 또는 삭제할 필요가 있다고 인정되는 경우 지체 없이 그에 따른 조치를 취합니다.",
            title: "다. ",
            hPadding: _hPaddingDepth1),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 만 14세 미만 아동의 개인정보는 수집하지 않고 있습니다.다만, 만 14세 미만 아동의 개인정보를 수집하는 상황이 발생할 경우, 법정대리인의 만 14세 미만 아동의 개인정보 처리에 대한 법령상의 권리를 보장합니다.",
            title: "2. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 8 조 (개인정보 파기절차 및 방법)"),
        buildParagraph(
            "이용자가 샤이니오 서비스를 통해 입력한 정보는 목적이 달성된 후 별도의 DB로 옮겨져(출력물의 경우 별도의 서류함) 내부방침 및 기타 관계법령에 의한 정보보호 사유에 따라 (보유 및 이용기간 참조) 일정 기간 저장된 후 파기됩니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 제7조에서 설명한 절차와 방법에 따라 이용자 본인이 직접 정보 수정·삭제를 요청 하거나 가입해지를 요청한 경우에도 본 조에서 정한 바와 같이 파기 처리합니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph("제2조에서와 같이 일시적인 목적 (설문조사, 이벤트, 본인확인 등)으로 입력 받은 개인정보 는 그 목적이 달성된 이후에는 동일한 방법으로 파기 처리됩니다.",
            title: "3. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 귀중한 이용자의 개인정보를 안전하게 처리하며, 유출의 방지를 위하여 다음과 같은 방법을 통하여 개인정보를 파기합니다.", title: "4. "),
        const SizedBox(height: 4),
        buildParagraph("종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph("전자적 파일 형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.",
            title: "나. ", hPadding: _hPaddingDepth1),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 9 조 (비회원의 개인정보관리)"),
        buildParagraph(
            "회원 탈퇴를 거쳐 비회원이 된 회원이 남긴 리뷰는 삭제되지 않으며, 회원은 자신의 리뷰 노출을 원하지 않을 경우 탈퇴 전 자신이 남긴 리뷰 및 게시글 일체를 직접 삭제해야 합니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("리뷰는 서비스 운영과 관련한 용도 외에는 다른 어떠한 용도로도 사용되지 않습니다.", title: "2. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 10 조 (개인정보보호를 위한 기술적, 관리적 조치)"),
        buildParagraph(
            "회사는 이용자의 개인정보를 처리함에 있어 정보의 분실, 도난, 누출, 외부로부터의 공격, 해킹 등을 방지하고 안전성을 확보하기 위하여 기술적·관리적 및 물리적 조치를 하고 있습니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("회사가 수행하는 기술적∙관리적 및 물리적 조치는 다음과 같습니다.", title: "2. "),
        const SizedBox(height: 4),
        buildParagraph("개인정보의 안전한 처리를 위하여 별도의 내부 관리계획을 수립·시행하고 있습니다.", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph(
            "개인정보에 대한 접근 통제 및 접근 권한을 제한하기 위하여 이용자의 개인정보를 처리하는 담당인원을 최소한으로 제한하며, 관련 직원에 대해서는 지속적인 보안교육의 실시와 함께 본 정책의 준수여부를 수시로 점검하고 있습니다.",
            title: "나. ",
            hPadding: _hPaddingDepth1),
        buildParagraph(
            "개인정보를 안전하게 저장·전송할 수 있도록 이용자의 개인정보는 비밀번호에 의해 보호되며, 파일 및 전송 데이터를 암호화하여 중요한 데이터는 별도의 보안기능을 통해 보호하며, 암호화통신(SSL)등을 통하여 네트워크상에서 개인정보를 안전하게 전송할 수 있도록 하는 등 노력을 기울이고 있습니다.",
            title: "다. ",
            hPadding: _hPaddingDepth1),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 11 조 (쿠키(cookie)의 운영에 관한 사항)"),
        buildParagraph(
            "회사는 회원인증을 위하여 Cookie 방식을 이용하고 있습니다. 이는 로그아웃(Logout)시 자동으로 컴퓨터에 저장되지 않고 삭제되도록 되어 있으므로 공공장소나 타인이 사용할 수 있는 컴퓨터를 사용 하 실 경우에는 로그인(Login)후 서비스 이용이 끝나시면 반드시 로그 아웃(Logout)해 주시기 바랍니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "회사는 추가적으로 회원과 비회원의 접속 빈도나 방문시간 등을 분석, '이용자'의 취향과 관심분야를 파악 및 자취추적, 각종 이벤트 참여 정도 및 방문 횟수 파악 등을 통한 타겟 마케팅 및 개인 맞춤 서비스, 로그인 서비스 제공을 위한 목적으로 Cookie를 수집하고 있습니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph(
            "쿠키 설정을 거부하는 방법으로는 회원님이 사용하시는 웹 브라우저의 옵션을 선택함으로써 모든 쿠키를 허용하거나 쿠키를 저장할 때마다 확인을 거치거나, 모든 쿠키의 저장을 거부할 수 있습니다.",
            title: "3. "),
        const SizedBox(height: 4),
        buildParagraph("설정방법 예(인터넷 익스플로어의 경우): 웹 브라우저 상단의 도구 > 인터넷 옵션 > 개인정보", title: "- ", hPadding: _hPaddingDepth1),
        const SizedBox(height: 6),
        buildParagraph("단, 귀하께서 쿠키 설치를 거부하였을 경우 서비스 제공에 어려움이 있을 수 있습니다.", title: "4. "),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 12 조 (개인정보관련 의견수렴 및 불만처리에 관한 사항)"),
        buildParagraph(
            "회사는 개인정보보호와 관련하여 이용자 여러분들의 의견을 수렴하고 있으며 불만을 처리하기 위하여 모든 절차와 방법을 마련하고 있습니다. 이용자들은 하단에 명시한 제14조를 참고하여 전화나 메일을 통하여 불만사항을 신고할 수 있고, 회사는 이용자들의 신고사항에 대하여 신 속하고도 충분한 답변을 해 드릴 것입니다."),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 13 조 (개인정보 관리책임자 및 담당자의 소속-성명 및 연락처)"),
        buildParagraph(
            "회사는 귀하가 좋은 정보를 안전하게 이용할 수 있도록 최선을 다하고 있습니다. 개인정보를 보호하는데 있어 귀하께 고지한 사항들에 반하는 사고가 발생할 경우 개인정보관리책임자가 책임을 집니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph(
            "이용자 개인정보와 관련한 아이디(ID)의 비밀번호에 대한 보안유지책임은 해당 이용자 자신에게 있습니다. 회사는 비밀번호에 대해 어떠한 방법으로도 이용자에게 직접적으로 질문 하는 경우는 없으므로 타인에게 비밀번호가 유출되지 않도록 각별히 주의하시기 바랍니다. 특히 공공장소에서 온라인상에서 접속해 있을 경우에는 더욱 유의하셔야 합니다.",
            title: "2. "),
        const SizedBox(height: 6),
        buildParagraph("회사는 개인정보에 대한 의견수렴 및 불만처리를 담당하는 개인정보 관리책임자 및 담당자 를 지정하고 있고, 연락처는 아래와 같습니다.", title: "3. "),
        const SizedBox(height: 16),
        buildParagraph("이름: 김지우", hPadding: 60),
        buildParagraph("소속/직위: 개인정보 관리책임자", hPadding: 60),
        buildParagraph("E-MAIL: office@hi-shiny-o.com", hPadding: 60),
        buildParagraph("전화번호: 02-865-8506", hPadding: 60),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 14 조 (개인정보처리방침의 적용 제외)"),
        buildParagraph(
            "회사는 이용자에게 웹사이트를 통하여 다른 회사의 웹사이트 또는 자료에 대한 링크를 제공할 수 있습니다. 이 경우 회사는 외부사이트 및 자료에 대하여 통제권이 없을 뿐만 아니라 이들이 개인정보를 수집하는 행위에 대하여 회사의 '개인정보처리방침'이 적용되지 않습니다. 따라서, 회사가 포함하고 있는 링크를 클릭하여 타 사이트의 페이지로 이동할 경우에는 새로 방문한 사이트의 개인정보처리방침을 반드시 확인하시기 바랍니다."),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 15 조 (권익침해 구제방법)"),
        buildParagraph(
            "이용자는 다음 각 호의 기관에 대해 개인정보 침해에 대한 피해구제, 상담 등을 문의할 수 있습니다. 아래의 기관은 회사와 별개의 기관으로서, 회사의 자체적인 개인정보 불만처리, 피해구제 결과에 만족하지 못하시거나 보다 구체적이고 자세한 도움이 필요하시면 문의하여 주시기 바랍니다.",
            title: "1. "),
        const SizedBox(height: 6),
        buildParagraph("개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.", title: "2. "),
        const SizedBox(height: 4),
        buildParagraph("개인정보 침해신고센터 (한국인터넷진흥원 운영)", title: "가. ", hPadding: _hPaddingDepth1),
        buildParagraph("소관업무: 개인정보 침해사실신고, 상담신청", hPadding: _hPaddingDepth2),
        buildParagraph("홈페이지 privacy.kisa.or.kr", hPadding: _hPaddingDepth2),
        buildParagraph("전 화: (국번없이) 118", hPadding: _hPaddingDepth2),
        buildParagraph("주 소: (58324) 전남 나주시 진흥길 9(빛가람동 301-2) 3층 개인정보침해 신고센터", hPadding: _hPaddingDepth2),
        const SizedBox(height: 4),
        buildParagraph("개인정보 분쟁조정위원회 (한국인터넷진흥원 운영)", title: "나. ", hPadding: _hPaddingDepth1),
        buildParagraph("소관업무: 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)", hPadding: _hPaddingDepth2),
        buildParagraph("홈페이지: www.kopico.or.kr", hPadding: _hPaddingDepth2),
        buildParagraph("전 화: 1833-6972", hPadding: _hPaddingDepth2),
        buildParagraph("주 소: 03171 서울특별시 종로구 세종대로 209 정부서울청사 4층 개인정보 분쟁조정위원회", hPadding: _hPaddingDepth2),
        const SizedBox(height: 6),
        buildParagraph("대검찰청 사이버범죄수사단: 02-3480-3571 (cybercid.spo.go.kr)", title: "3. ", textAlign: TextAlign.start),
        const SizedBox(height: 6),
        buildParagraph("경찰청 사이버안전국: 182 (http://cyber.go.kr)", title: "4. ", textAlign: TextAlign.start),
        const SizedBox(height: 6),
        buildParagraph("정보보호마크인증위원회: 02-550-9531~2 (www.eprivacy.or.kr)", title: "5. ", textAlign: TextAlign.start),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 16 조 (고지의 의무)"),
        buildParagraph("현 개인정보처리방침의 내용은 정부의 정책 또는 보안기술의 변경에 따라 내용의 추가 삭제 및 수정이 있을 시에는 당사 홈페이지 공지사항 등을 통해 개별 고지할 것입니다."),
        //--------------------------------------------------------------------------------------------------------------
        buildSubTitle("제 17 조 (시행시기)"),
        buildParagraph("본 방침은 2022년 1월 25일부터 시행됩니다."),
      ],
    );
  }

  Widget buildMidTitle(String title) {
    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          height: 1.0,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildParagraph(String content,
      {String title = "", double hPadding = 20, TextAlign textAlign = TextAlign.justify}) {
    return Column(
      children: [
        const SizedBox(height: 1),
        Container(
          padding: EdgeInsets.only(left: hPadding, right: 20),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title.isNotEmpty)
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              Expanded(
                child: Text(
                  content,
                  textAlign: textAlign,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Color(0xFF686C73),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 1),
      ],
    );
  }

  Widget buildSubTitle(String title) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              height: 1.2,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget termsItem(String title, String content) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Container(
          height: 21,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            content,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF686C73),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
