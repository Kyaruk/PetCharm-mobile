import 'package:flutter/material.dart';
import 'package:pet_charm/main.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TermsAndConditions();
  }
}

class _TermsAndConditions extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
        leading: IconButton(
            color: const Color.fromRGBO(0, 0, 0, 1),
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Increase volume by 10',
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          padding: EdgeInsets.only(
            right: Global.deviceSize.width * 0.28,
          ),
          child: Text(
            "Please check",
            style: TextStyle(
                color: const Color.fromRGBO(208, 59, 51, 1.0),
                fontSize: Global.deviceSize.width * 0.1,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.03,
              left: Global.deviceSize.width * 0.05,
              right: Global.deviceSize.width * 0.17),
          child: Text(
            "PetCharm Terms and Conditions",
            style: TextStyle(
                color: const Color.fromRGBO(208, 59, 51, 1.0),
                fontSize: Global.deviceSize.width * 0.05,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.03,
              left: Global.deviceSize.width * 0,
              right: Global.deviceSize.width * 0.35),
          child: Text(
            "Last updated: May 1, 2022",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    By clicking \"sign in\", \"sign up\", or \"submit\" and entering or otherwise using our website or mobile application (the \"Site\"), you agree to and accept these terms and conditions. Certain products and services on our Site may have additional terms that apply (for example, if you subscribe to our Autoship & Save subscription program, you also will be subject to the Autoship Terms & Conditions). If these Terms of Use are inconsistent with terms applicable to a certain product or service, those other terms will control.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.032,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    THESE TERMS AND CONDITIONS, AS WELL AS ANY OTHER PRODUCT AND SERVICE SPECIFIC TERMS ON OUR SITE, CONSTITUTE YOUR SERVICE AGREEMENT (\"AGREEMENT\") WITH PetCharm, INC. AND ANY OF ITS OWNED OR OPERATED SITES WHERE THESE TERMS OF UES ARE POSTED (\"PetCharm\"). THIS AGREEMENT SETS FORTH THE LEGALLY BINDING TERMS FOR YOUR USE OF OUR SITE AND YOUR PURCHASE OR USE OF ANY PRODUCTS OR SERVICES OFFERED ON THE SITE. BY ACCESSING AND/OR USING THE SITE, YOU REPRESENT AND WARRANT THAT YOU HAVE THE RIGHT, AUTHORITY, AND CAPACITY TO ENTER INTO THE AGREEMENT AND TO ABIDE BY ALL OF THE TERMS AND CONDITIONS SET FORTH HEREIN. YOU MAY NOT ACCESS OR USE THIS SITE OR ACCEPT THIS AGREEMENT UNLESS YOU ARE AT LEAST 18 YEARS OLD.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    ARBITRATION NOTICE: THESE TERMS CONTAIN AN ARBITRATION CLAUSE A LITTLE LATER ON. YOU AND PetCharm AGREE THAT DISPUTES BETWEEN US WILL BE RESOLVED BY MANDATORY BINDING ARBITRATION, AND YOU AND PetCharm WAIVE ANY RIGHT TO PARTICIPATE IN A CLASS-ACTION LAWSUIT OR CLASS-WIDE ARBITRATION.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Privacy Policy",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    Please review our Privacy Policy, which also governs your use of our Site, to understand our practices.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Electronic Communications",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    When you use our Site, or send e-mails, text messages, and other communications from your desktop or mobile device to us, you are communicating with us electronically. You consent to receive communications from us electronically, such as e-mails, texts, mobile push notices, or notices and messages on this Site, and you can retain copies of these communications for your records. You agree that all agreements, notices, disclosures, and other communications that we provide to you electronically satisfy any legal requirement that such communications be in writing.Where required by applicable law, we will seek expres prior written consent for marketing text messages or calls to you.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Accounts",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    In order to use certain features of the Site (e.g., purchasing from the Site products and services (referred to collectively as \"Products\" herein)), you must register for an account with PetCharm (\"PetCharm Account\") and provide certain information about yourself as prompted by the Site registration form. You represent and warrant that: (a) all required registration information you submit is truthful and accurate; (b) you will maintain the accuracy of such information; and (c) your use of the Site does not violate any applicable law or regulation or the terms of this Agreement.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    You are responsible for maintaining the confidentiality of your PetCharm Account login information. You are fully responsible for all activities that are associated with your PetCharm Account (including but not limited to any purchases, use of the Site, or correspondence from your account to PetCharm). You agree to keep your username and password information confidential and not share it with anyone. You agree to immediately notify PetCharm of any unauthorized use or suspected unauthorized use of your PetCharm Account or any other breach of security. When you provide PetCharm with such notice, PetCharm will suspend or otherwise secure your Account to prevent future unauthorized activity.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Order Acceptance",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    The receipt of an order number or an email order confirmation does not constitute the acceptance of an order or a confirmation of an offer to sell. PetCharm reserves the right, without prior notification, to limit the order quantity on any item and/or to refuse service to any customer. Verification of information may be required prior to the acceptance of an order. Prices and availability of products on the Site are subject to change without notice. Errors will be corrected when discovered and PetCharm reserves the right to revoke any stated offer and to correct any error, inaccuracy, or omission (including after an order has been submitted). Certain orders constitute improper use of the Site.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    PetCharm reserves the right, at its sole discretion, to refuse or cancel any order for any reason. Your account may also be restricted or terminated for any reason, at PetCharm's sole discretion.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Risk of Loss",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    All items purchased from PetCharm are made pursuant to a shipment contract. This means that the risk of loss and title for such items pass to you upon our delivery to the carrier.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Product Descriptions",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    PetCharm attempts to be as accurate as possible. However, PetCharm does not warrant that product descriptions or other content on the Site are accurate, complete, reliable, current or error-free. If a product offered by PetCharm is not as described, your sole remedy is to return the product.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Pricing",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.09,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "    \"List Price\" means the suggested retail price of a product as provided by a manufacturer, supplier or other retailers (and with respect to RX products, veterinarians). Certain products may have a \"Was Price\" displayed, which is determined using recent price history of the product on PetCharm.com.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    PetCharm cannot confirm the price of an item until you submit an order. If you use Autoship, the price of an item will set at the time the order is processed. (See Autoship Terms and Conditions for more information). Despite our best efforts, it is possible that items in our catalog may be mispriced. If the correct price of an items is higher than our stated price, we will, at our discretion, either contact you for instructions before shipping or cancel our order and notify you of such cancellation. We do business throughout the United States and collect and remit sales tax as required by law.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Autoship & Save",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    By selecting Autoship on eligible items on PetCharm.com, you agree to the Autoship & Save Terms and Conditions (\"Autoship Terms\") applicable to our subscription ordering program (\"Autoship\").",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "PetCharm Gift Cards",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    PetCharm Gift Cards are issued by PetCharm Promotions LLC and redeemable at PetCharm.com for merchandise and services purchased by residents of the contiguous US. Only one PetCharm Gift Card can be redeemed per order. PetCharm Gift Cards have no fees and do not expire. PetCharm Gift Cards are not transferrable and not redeemable for cash, except where required by law; there are no refunds or returns. Lost, stolen, or damaged Gift Cards may only be cancelled and the remaining balance replaced with proof of purchase. Subject to full PetCharm Gift Card Terms and Conditions available at PetCharm.com; subject to change. By using your PetCharm Gift Card, you accept these terms.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Permissible Uses of Site",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "Subject to the terms of this Agreement, PetCharm grants you a limited, non-transferable, non-exclusive, license to access and make personal use of the Site. This license does not include the right to access or use the Site for any of the restricted purposes set forth below. PetCharm may terminate this license at any time for any reason.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    The rights granted to you in this Agreement are subject to the following restrictions: (a) you shall not use the Site to place an order on behalf of yourself or a third party for resale to that third party; (b) you shall not license, sublicense, reproduce, sell, rent, lease, transfer, assign, distribute, host, or otherwise commercially exploit the Site, its products or its content without the express written consent of PetCharm; (c) you shall not modify, make derivative works of, disassemble, reverse compile or reverse engineer any part of the Site; (d) you shall not access the Site in order to build a similar or competitive service, or to download, copy or collect content or account information for the benefit of another merchant; (e) except as expressly stated herein, no part of the Site may be copied, reproduced, distributed, republished, downloaded, displayed, posted or transmitted in any form or by any means without PetCharm's express written consent; and (f) you shall not frame or utilize framing techniques to enclose any trademark, logo, or other proprietary information or content (including images and text descriptions) of the Site without PetCharm's express written consent.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    PetCharm reserves the right, at any time, to modify, suspend, or discontinue the Site or any part thereof with or without notice. You agree that PetCharm will not be liable to you or to any third party for any modification, suspension, or discontinuance of the Site or any part thereof.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Intellectual Property Rights",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    The Site contains valuable trademarks and service marks owned and used by PetCharm, including but not limited to, PetCharm, the PetCharm design logo, the tag line \"where pet lover shop\" and certain brands including Tylee's, Dr. Lyons, Frisco and American Journey (collectively, the \"PetCharm Marks\"). Any use of the PetCharm Marks without the prior written permission of PetCharm is strictly prohibited. The arrangement and layout of the Site including but not limited to, the PetCharm Marks, images, text, graphics, buttons, screenshots, and other content or material (collectively, the \"Site Content\") are the sole and exclusive property of PetCharm.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    UNAUTHORIZED COPYING, REPRODUCTION, MODIFYING, REPUBLISHING, UPLOADING, DOWNLOADING, POSTING, TRANSMITTING, MAKING DERIVATIVE WORKS OF OR DUPLICATING ALL OR ANY PART OF THE SITE IS PROHIBITED.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    PetCharm uses a network of independent product and content suppliers, distributors and other such third parties to supply some of the products and content advertised on the Site. All other trademarks, service marks, product names, package designs and company names or logos associated with these products, and other such third parties, that are not owned by us but appear on the Site are the property of their respective owners.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Limitations Regarding Information,",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Articles and Advice",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    PetCharm offers information, articles and advice to pet parents through this site for educational purposes only. Any information offered through this site is not intended to diagnose, treat or cure your pet and is not a substitute for veterinary care provided by a licensed veterinarian. For any medical or health related advice concerning the care and treatment of your pet contact your regulator veterinarian or local animal hospital.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    PetCharm and its independent contractors, including veterinarians, offer information, articles and advice to pet parents through this site for educational purposes only or, in the case of independent contractors who are veterinarians, to provide teletriage services. Any information offered through this site or in the course of communications as part of teletriage services is not intended to diagnose, treat or cure your pet and is not a substitute for veterinary care provided by a licensed veterinarian. For any medical or health related advice concerning the care and treatment of your pet contact your regular veterinarian or local animal hospital.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "User Content",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    \"User Content\" of the Site user means any and all information and content that such user submits to PetCharm by any means, including through social media (e.g., Facebook, YouTube, Instagram, Pinterest, Twitter), or uses with the Site (e.g., a user profile, product review, question & answer). You are solely responsible for your User Content. You assume all risks associated with use of your User Content, including any reliance on its accuracy, completeness or usefulness by others, or any disclosure of your User Content that makes you or any third party personally identifiable. You hereby affirm, represent, and warrant that (a) you own, or have the necessary licenses, rights, and/or consents to use your User Content with the Site as described herein and (b) your User Content does not violate the Acceptable Use Policy. You may not state or imply that your User Content is in any way provided, sponsored, or endorsed by PetCharm. Because you alone are responsible for your User Content (and not PetCharm), you may expose yourself to liability if, for example, your User Content violates the Acceptable Use Policy. PetCharm is not obligated to backup any User Content, makes no representation that it will do so, and you agree that PetCharm may delete User Content at any time.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    By submitting your User Content or using it with the Site , you automatically grant, and you represent and warrant that you have the right to grant, to PetCharm an irrevocable, nonexclusive, royalty-free and fully paid worldwide license to reproduce, distribute, publicly display and perform, prepare derivative works of, incorporate into other works, and otherwise use your User Content, and to grant sublicenses of the foregoing, solely for the purposes of including your User Content in the Site, PetCharm social media platforms or marketing initiatives. You agree to irrevocably waive (and cause to be waived) any claims and assertions of publicity or moral rights, or attribution with respect to your User Content.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    PetCharm will treat any feedback, communications, or suggestions you provide to PetCharm as non-confidential and non-proprietary. Thus, in the absence of a written agreement with PetCharm to the contrary, you agree that you will not submit to PetCharm any information or ideas that you consider to be confidential or proprietary.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Acceptable Use Policy",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    You agree not to use the Site to collect, upload, transmit, display, or distribute any User Content (a) that violates any third-party right, including any copyright, trademark, patent, trade secret, moral right, privacy rights, right of publicity, or any other intellectual property or proprietary right; (b) that is unlawful, harassing, abusive, tortious, threatening, harmful, abusive, invasive of another's privacy, vulgar, defamatory, false, intentionally misleading, trade libelous, pornographic, obscene, patently offensive (e.g., material that promotes racism, bigotry, hatred, or physical harm of any kind against any group or individual) or otherwise objectionable material of any kind or nature or which is harmful to minors in any way; or (c) in violation of any law, regulation, or obligations or restrictions imposed by any third party.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    In addition, you agree not to use the Site to: (a) upload, transmit, or distribute any computer viruses, worms, or any software intended to damage or alter a computer system or data; (b) send unsolicited or unauthorized advertising, promotional materials, junk mail, spam, chain letters, pyramid schemes, or any other form of duplicative or unsolicited messages, whether commercial or otherwise; (c) harvest, collect, gather or assemble information or data regarding other users, including e-mail addresses, without their consent; (d) interfere with or disrupt servers or networks connected to the Site or violate the regulations, policies or procedures of such networks; (e) attempt to gain unauthorized access to the Site, other computer systems or networks connected to or used together with the Site, through password mining or other means; or (f) harass or interfere with another user's use and enjoyment of the Site.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    We reserve the right (but have no obligation under this Agreement) to review any User Content, investigate, and/or take appropriate action against you, at our sole discretion, if you violate the Acceptable Use Policy or any other provision of this Agreement, including removing or modifying your User Content, terminating your PetCharm Account, and/or reporting you to law enforcement authorities. We may also remove or modify your User Content if it, in our sole judgment, violates the rights of, harms, or threatens the safety of any other person, or creates liability for us or any other person. In order to cooperate with legitimate governmental requests, subpoenas or court orders, or to protect our business and members, we may access and disclose any information we consider necessary or appropriate, including your PetCharm Account username and password, IP address and traffic information, usage history, and your User Content.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Third Party Sites and Other Users",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    The Site may contain links to, or advertisements for, third party web sites (collectively, \"Third Party Sites\") (for example, social media sites such as Facebook, YouTube, Twitter, or Pinterest). Such Third Party Sites are not under the control of PetCharm and PetCharm is not responsible for any Third Party Sites. PetCharm provides links to these Third Party Sites only as a convenience and does not review, approve, monitor, endorse, warrant, or make any representations with respect to Third Party Sites. You agree that you use all Third Party Sites at your own risk. When you link to a Third Party Site, the applicable service provider's terms and policies, including privacy and data gathering practices govern. You should make whatever investigation you feel necessary or appropriate before proceeding with any transaction with any Third Party Site.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    Each Site user is solely responsible for any and all of its User Content. Because we do not control User Content, you acknowledge and agree that we are not responsible for any User Content and we make no guarantees regarding the accuracy, currency, suitability, or quality of any User Content, and we assume no responsibility for any User Content. Your interactions with other Site users are solely between you and such user. You agree that PetCharm will not be responsible for any loss or damage incurred as the result of any such interactions. If there is a dispute between you and any Site user, we are under no obligation to become involved.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    You hereby release us, our officers, employees, agents, affiliates, subsidiaries, parents, joint ventures, successors and any other companies under common control with us from claims, demands any and all losses, damages, rights, claims, and actions of any kind including personal injuries, death, and property damage, that are either directly or indirectly related to or arise out of any interactions with or conduct of other Site users or Third Party Sites.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Disclaimer of Warranties",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    PetCharm intends for the information and data contained in the Site to be accurate and reliable but since the information and data have been compiled from a variety of sources, they are provided 'AS IS' and \"AS AVAILABLE\". You expressly agree that your use of the Site and any information contained therein is at your sole risk. NEITHER PetCharm NOR ITS THIRD PARTIES WARRANT THE ACCURACY, OR COMPLETENESS OF THE CONTENT PROVIDED ON THIS SITE OR THE PRODUCTS OR SERVICES OFFERED FOR SALE ON THIS SITE. WE CANNOT AND DO NOT WARRANT THAT YOUR USE OF THIS SITE WILL BE UNINTERRUPTED, SECURE OR ERROR FREE. Accordingly, to the extent permitted by applicable law, PetCharm EXPRESSLY DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION, IMPLIED WARRANTIES OF TITLE, NON-INFRINGEMENT, ACCURACY, MERCHANTABILITY AND FITNESS FOR A PURPOSE, AND ANY WARRANTIES THAT MAY ARISE FROM COURSE OF DEALING, COURSE OF PERFORMANCE OR USAGE OF TRADE. Some jurisdictions do not allow the disclaimer of warranties so such disclaimers may not apply to you.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Limitation on Liability",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    IN NO EVENT SHALL PetCharm, OUR OFFICERS, EMPLOYEES, AGENTS, AFFILIATES, SUBSIDIARIES, PARENTS, JOINT VENTURES, SUCCESSORS AND ANY OTHER COMPANIES UNDER COMMON CONTROL WITH US, OR ANY INDEPENDENT CONTRACTORS, INCLUDING VETERINARIANS, BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY LOST PROFIT OR ANY INDIRECT, CONSEQUENTIAL, EXEMPLARY, INCIDENTAL, SPECIAL OR PUNITIVE DAMAGES ARISING FROM OR IN ANY WAY RELATED TO YOUR RELATIONSHIP WITH PetCharm, YOUR USE OF THE WEB SITE, PRODUCTS, OR THIRD PARTY SITES, OR YOUR INTERACTION WITH OR RELIANCE ON ANY ADVICE FROM ANY SUCH PERSON OR ENTITY EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. ACCESS TO, AND USE OF, THE WEB SITE, PRODUCTS AND THIRD PARTY SITES AND ANY INTERACTIONS WITH OR RELIANCE ON ADVICE FROM ANY SUCH PERSON OR ENTITY ARE AT YOUR OWN DISCRETION AND RISK, AND YOU WILL BE SOLELY RESPONSIBLE FOR ANY DAMAGE TO YOUR COMPUTER SYSTEM OR LOSS OF DATA RESULTING THEREFROM. NOTWITHSTANDING ANYTHING TO THE CONTRARY CONTAINED HEREIN, OUR LIABILITY TO YOU FOR ANY DAMAGES ARISING FROM OR IN ANY WAY RELATED TO YOUR RELATIONSHIP WITH PetCharm, ANY INTERACTIONS WITH OR RELIANCE ON ADVICE FROM ANY SUCH PERSON OR ENTITY, OR THIS AGREEMENT (FOR ANY CAUSE WHATSOEVER AND REGARDLESS OF THE FORM OF THE ACTION), WILL AT ALL TIMES BE LIMITED TO THE GREATER OF (A) FIFTY US DOLLARS (\$50) OR (B) AMOUNTS YOU'VE PAID PetCharm IN THE PRIOR 12 MONTHS. WE AGREE THAT ANY CLAIM BETWEEN US MUST BE BROUGHT WITHIN TWO (2) YEARS.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    SOME JURISDICTIONS DO NOT ALLOW THE LIMITATION OR EXCLUSION OF LIABILITY FOR INCIDENTAL OF CONSEQUENTIAL DAMAGES, SO THE ABOVE LIMITATION OR EXCLUSION MAY NOT APPLY TO YOU AND YOU MAY ALSO HAVE OTHER LEGAL RIGHTS THAT VARY FROM JURISDICTION TO JURISDICTION.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Indemnity",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    You agree to indemnify and hold PetCharm, our officers, employees, agents, affiliates, subsidiaries, parents, joint ventures, successors, independent contractors, including veterinarians, and any other companies under common control with us harmless, including costs and attorneys' fees, from any claim or demand made by any third party due to or arising out of (a) your use of the Site or Products, (b) your User Content, (c) your violation of this Agreement, or (d) your interaction with such independent contractors or reliance on any advice provided by them. PetCharm reserves the right, at your expense, to assume the exclusive defense and control of any matter for which you are required to indemnify us and you agree to cooperate with our defense of these claims. You agree not to settle any matter without the prior written consent of PetCharm. PetCharm will use reasonable efforts to notify you of any such claim, action or proceeding upon becoming aware of it.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Arbitration",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    EXCEPT FOR A CLAIM THAT MAY BE BROUGHT IN SMALL CLAIMS COURT, YOU AND PetCharm AGREE TO GIVE UP ANY RIGHTS TO LITIGATE CLAIMS IN A COURT OR BEFORE A JURY OR TO PARTICIPATE IN A CLASS ACTION OR REPRESENTATIVE ACTION WITH RESPECT TO A CLAIM. OTHER RIGHTS THAT YOU WOULD HAVE IF YOU WENT TO COURT, SUCH AS ACCESS TO DISCOVERY, ALSO MAY BE UNAVAILABLE OR LIMITED IN ARBITRATION.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    Any and all disputes between you and PetCharm, its agents, employees, officers, directors, principals, successors, assigns, subsidiaries, affiliates, or independent contractors, including veterinarians, (collectively for purposes of this section, 'PetCharm'), including disputes arising from or relating to these Terms of Use, the Privacy Policy, Autoship Terms and Conditions, Gift Card Terms & Conditions, Customer Reviews and Q&A Terms and Conditions and their interpretation or the breach, termination or validity thereof, any purchase on www.PetCharm.com, communications between you and PetCharm, the reliance on any advice provided by such independent contractors, or other products, programs, services or promotions provided by PetCharm. including disputes about the validity, scope or enforceability of this arbitration provision (collectively, \"Covered Disputes\") will be settled by binding arbitration administered by the JAMS, Inc. under its rules applicable to consumer disputes, in effect on the date thereof. Information on JAMS and how to start arbitration can be found at www.jamsadr.com or by calling 800-352-5267. For purposes of this section, these Terms of Use and related transactions will be subject to and governed by the Federal Arbitration Act, 9 U.S.C. sec. 1-16 (FAA). To the extent state law applies to any portion of a proceeding brought by you or us, the applicable law will be the law of the state of your residence, as determined based on your shipping address on file with PetCharm.com. Except for a demand determined by an arbitrator or court to be frivolous, PetCharm will pay up to \$10,000 in costs and expenses that otherwise might be due by you under the JAMS consumer arbitration rules. At your election, the arbitration will take place in the county in which you reside or, if you choose, by telephone or based on the parties’ written submissions. Notwithstanding the above, you or PetCharm can bring any individual claim in small claims court consistent with the jurisdictional limitations of such court.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    PetCharm AND YOU AGREE THAT ANY COVERED DISPUTE HEREUNDER WILL BE SUBMITTED TO ARBITRATION ON AN INDIVIDUAL BASIS ONLY. NEITHER PetCharm NOR YOU ARE ENTITLED TO ARBITRATE ANY COVERED DISPUTE AS A CLASS, REPRESENTATIVE OR PRIVATE ATTORNEY ACTION AND THE ARBITRATOR(S) WILL HAVE NO AUTHORITY TO PROCEED ON A CLASS, REPRESENTATIVE OR PRIVATE ATTORNEY GENERAL BASIS. If any provision of the agreement to arbitrate in this section is found unenforceable, the unenforceable provision will be severed and the remaining arbitration terms will be enforced (but in no case will there be a class, representative or private attorney general arbitration).",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    Notwithstanding any provision in these terms to the contrary, we agree that if PetCharm makes any future material change to this dispute resolution provision, it will not apply to any individual claim(s) that you had already provided notice to PetCharm. In the event that this arbitration agreement does not apply to a given dispute, then the parties agree to the exclusive jurisdiction of the state and federal courts in Broward County, Florida to resolve such claims.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Term and Termination",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    Subject to this Section, this Agreement will remain in full force and effect while you use the Site. We may (a) suspend your rights to use the Site (as well as your PetCharm Account) or (b) terminate this Agreement, at any time for any reason at our sole discretion, including for any use of the Site in violation of this Agreement or if we believe you are younger than 18. Upon termination of this Agreement, your PetCharm Account and right to access and use the Site will terminate immediately. You understand that any termination of your PetCharm Account may involve deletion of any User Content you may have posted. PetCharm will not have any liability whatsoever to you for any termination of this Agreement, including for termination of your PetCharm Account or deletion of your User Content.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    The provisions herein related to our intellectual property rights, user content, acceptable use, disclaimer of warranties, indemnity, limitation and liability, and arbitration together with any other rights and obligations which by their nature are reasonably intended to survive such termination, including the end of any other aspect of the relationship between you and PetCharm, including your decision to stop purchasing from PetCharm or the cancellation or end of any participation in any service, program, or promotion offered by PetCharm, will survive any termination of these Terms of Use.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "Respect for Copyright Law",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    PetCharm respects the intellectual property of others and asks that users of our Site do the same. Except as authorized above, you are not permitted access or use of any of PetCharm's Intellectual Property without our prior written consent or the consent of such third party that may own intellectual property with respect to Products displayed on the web site. In connection with our Site, Products, and any services we offer, we have adopted and reasonably implemented a policy respecting copyright law that provides for the removal of any infringing materials and for the termination, in appropriate circumstances, of users of our Site who are repeat infringers of intellectual property rights, including copyrights. If you believe that your work has been copied in a way that constitutes copyright infringement and wish to have the allegedly infringing material removed from our Site, the following information in the form of a written notification (pursuant to 17 U.S.C. Â§ 512(c)) must be provided to our designated Copyright Agent:",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0,
              right: Global.deviceSize.width * 0.24),
          child: Text(
            "1. your physical or electronic signature;",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.09,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "    2. identification of the copyrighted work(s) that you claim to have been infringed;",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.09,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "    3. identification of the material on our services that you claim is infringing and that you request us to remove;",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.09,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "    4. sufficient information to permit us to locate such material;",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.09,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "5. your address, telephone number, and e-mail address;",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.09,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "    6. a statement that you have a good faith belief that use of the objectionable material is not authorized by the copyright owner, its agent, or under the law; and",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.09,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "    7. a statement that the information in the notification is accurate, and under penalty of perjury, that you are either the owner of the copyright that has allegedly been infringed or that you are authorized to act on behalf of the copyright owner.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    Please note that, pursuant to 17 U.S.C. Â§ 512(f), any misrepresentation of material fact (falsities) in a written notification automatically subjects the complaining party to liability for any damages, costs and attorneys' fees incurred by us in connection with the written notification and allegation of copyright infringement.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    You may submit your counter notification to PetCharm's Copyright Agent by mail or email as set forth below:",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0,
              right: Global.deviceSize.width * 0.35),
          child: Text(
            "PetCharm Copyright Agent",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0,
              right: Global.deviceSize.width * 0.57),
          child: Text(
            "Attn: Legal",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0,
              right: Global.deviceSize.width * 0.48),
          child: Text(
            "37 Xueyuan Road",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0,
              right: Global.deviceSize.width * 0.21),
          child: Text(
            "Beihang University, P.R.China 100191",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0,
              right: Global.deviceSize.width * 0.4),
          child: Text(
            "service@PetCharm.com",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.1,
              right: Global.deviceSize.width * 0.1),
          child: Text(
            "General",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    We reserve the right to make changes to our Site, this Agreement and other service terms, such as our Privacy Policy and the Subscribe & Save Terms & Conditions, and Gift Card Terms and Conditions at any time. Each time you use our Site, you should visit and review the then current Terms and Policies that apply to your transactions and use of our Site. If you do not agree to be bound by the then current Terms and Policies, your sole remedy is not to use our Site. If any terms of this Agreement or other service terms are deeded invalid, void, or for any reason unenforceable, any such term shall be deemed severable and shall not affect the validity and enforceability of any other terms.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: Global.deviceSize.width * 0.02,
              left: Global.deviceSize.width * 0.07,
              right: Global.deviceSize.width * 0.07),
          child: Text(
            "    Our failure to exercise or enforce any right or provision of this Agreement shall not operate as a waiver of such right or provision. This Agreement is governed by the laws of the State of Florida without regard to conflict of law provisions. The section titles in this Agreement are for convenience only and have no legal or contractual effect. The word \"including\" means including without limitation. If any provision of this Agreement is, for any reason, held to be invalid or unenforceable, the other provisions of this Agreement will be unimpaired and the invalid or unenforceable provision will be deemed modified so that it is valid and enforceable to the maximum extent permitted by law. This Agreement, and your rights and obligations herein, may not be assigned, subcontracted, delegated, or otherwise transferred by you without PetCharm's prior written consent, and any attempted assignment, subcontract, delegation, or transfer in violation of the foregoing will be null and void. The terms of this Agreement shall be binding upon assignees.",
            style: TextStyle(
                color: returnColorARGB(),
                fontSize: Global.deviceSize.width * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
      ])),
    );
  }

  Color returnColorARGB() {
    return const Color.fromARGB(255, 0, 0, 0);
  }
}
