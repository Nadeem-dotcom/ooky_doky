// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    List<Customer> customers;

    User({
        required this.customers,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        customers: List<Customer>.from(json["customers"].map((x) => Customer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "customers": List<dynamic>.from(customers.map((x) => x.toJson())),
    };
}

class Customer {
    int id;
    String email;
    bool acceptsMarketing;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic firstName;
    dynamic lastName;
    int ordersCount;
    String state;
    String totalSpent;
    dynamic lastOrderId;
    dynamic note;
    bool verifiedEmail;
    dynamic multipassIdentifier;
    bool taxExempt;
    String tags;
    dynamic lastOrderName;
    String currency;
    dynamic phone;
    List<dynamic> addresses;
    DateTime acceptsMarketingUpdatedAt;
    dynamic marketingOptInLevel;
    List<dynamic> taxExemptions;
    EmailMarketingConsent emailMarketingConsent;
    dynamic smsMarketingConsent;
    String adminGraphqlApiId;

    Customer({
        required this.id,
        required this.email,
        required this.acceptsMarketing,
        required this.createdAt,
        required this.updatedAt,
        required this.firstName,
        required this.lastName,
        required this.ordersCount,
        required this.state,
        required this.totalSpent,
        required this.lastOrderId,
        required this.note,
        required this.verifiedEmail,
        required this.multipassIdentifier,
        required this.taxExempt,
        required this.tags,
        required this.lastOrderName,
        required this.currency,
        required this.phone,
        required this.addresses,
        required this.acceptsMarketingUpdatedAt,
        required this.marketingOptInLevel,
        required this.taxExemptions,
        required this.emailMarketingConsent,
        required this.smsMarketingConsent,
        required this.adminGraphqlApiId,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        email: json["email"],
        acceptsMarketing: json["accepts_marketing"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        ordersCount: json["orders_count"],
        state: json["state"],
        totalSpent: json["total_spent"],
        lastOrderId: json["last_order_id"],
        note: json["note"],
        verifiedEmail: json["verified_email"],
        multipassIdentifier: json["multipass_identifier"],
        taxExempt: json["tax_exempt"],
        tags: json["tags"],
        lastOrderName: json["last_order_name"],
        currency: json["currency"],
        phone: json["phone"],
        addresses: List<dynamic>.from(json["addresses"].map((x) => x)),
        acceptsMarketingUpdatedAt: DateTime.parse(json["accepts_marketing_updated_at"]),
        marketingOptInLevel: json["marketing_opt_in_level"],
        taxExemptions: List<dynamic>.from(json["tax_exemptions"].map((x) => x)),
        emailMarketingConsent: EmailMarketingConsent.fromJson(json["email_marketing_consent"]),
        smsMarketingConsent: json["sms_marketing_consent"],
        adminGraphqlApiId: json["admin_graphql_api_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "accepts_marketing": acceptsMarketing,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "orders_count": ordersCount,
        "state": state,
        "total_spent": totalSpent,
        "last_order_id": lastOrderId,
        "note": note,
        "verified_email": verifiedEmail,
        "multipass_identifier": multipassIdentifier,
        "tax_exempt": taxExempt,
        "tags": tags,
        "last_order_name": lastOrderName,
        "currency": currency,
        "phone": phone,
        "addresses": List<dynamic>.from(addresses.map((x) => x)),
        "accepts_marketing_updated_at": acceptsMarketingUpdatedAt.toIso8601String(),
        "marketing_opt_in_level": marketingOptInLevel,
        "tax_exemptions": List<dynamic>.from(taxExemptions.map((x) => x)),
        "email_marketing_consent": emailMarketingConsent.toJson(),
        "sms_marketing_consent": smsMarketingConsent,
        "admin_graphql_api_id": adminGraphqlApiId,
    };
}

class EmailMarketingConsent {
    String state;
    String optInLevel;
    dynamic consentUpdatedAt;

    EmailMarketingConsent({
        required this.state,
        required this.optInLevel,
        required this.consentUpdatedAt,
    });

    factory EmailMarketingConsent.fromJson(Map<String, dynamic> json) => EmailMarketingConsent(
        state: json["state"],
        optInLevel: json["opt_in_level"],
        consentUpdatedAt: json["consent_updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "state": state,
        "opt_in_level": optInLevel,
        "consent_updated_at": consentUpdatedAt,
    };
}
