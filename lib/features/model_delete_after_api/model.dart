class TermOfConditionsModel {
  final String title;
  final String description;

  TermOfConditionsModel({required this.title, required this.description});
}

class Internet {
  final String user;
  final String internet;

  Internet({required this.user, required this.internet});
}
class InternetDetails {
  final String remainingPackage;
  final String usedPackage;
  final String startDate;
  final String endDate;
  final String currentDate;
  final String remainingPeriod;

  InternetDetails({required this.remainingPackage, required this.usedPackage, required this.startDate, required this.endDate, required this.currentDate, required this.remainingPeriod});

}
class AppItems {
  static List<TermOfConditionsModel> terms = [
    TermOfConditionsModel(
      title: "قبول الشروط",
      description: "باستخدامك لهذا التطبيق، فإنك توافق على الالتزام بهذه الشروط والأحكام. إذا كنت لا توافق على أي من هذه الشروط، يُرجى عدم استخدام الخدمة.",
    ),
    TermOfConditionsModel(
      title: "التعديلات على الشروط",
      description: "نحتفظ بالحق في تعديل أو تحديث هذه الشروط في أي وقت. سيتم إخطارك بأي تغييرات جوهرية. استمرارك في استخدام الخدمة بعد التعديلات يعني موافقتك عليها.",
    ),
    TermOfConditionsModel(
      title: "استخدام الخدمة",
      description: "يجب ألا تستخدم الخدمة لأي غرض غير قانوني أو ينتهك القوانين. يُحظر محاولة اختراق أو تعطيل الخدمة. قد تتطلب بعض الميزات تسجيل حساب بمعلومات دقيقة ومحدثة.",
    ),
    TermOfConditionsModel(
      title: "مسؤوليات المستخدم",
      description: "أنت مسؤول عن الحفاظ على سرية بيانات حسابك. أي استخدام غير قانوني تحت حسابك سيكون مسؤوليتك. تأكد من أن أي محتوى تشاركه يتوافق مع المعايير القانونية.",
    ),
    TermOfConditionsModel(
      title: "سياسة الخصوصية",
      description: "نحن نحترم خصوصيتك ونتعامل مع بياناتك وفقًا لسياسة الخصوصية الخاصة بنا. سيتم استخدام البيانات الشخصية وفقًا لما هو موضح في السياسة.",
    ),
    TermOfConditionsModel(
      title: "إنهاء الوصول",
      description: "نحتفظ بالحق في تعليق أو إنهاء استخدام الخدمة في حالة انتهاك الشروط. سيتم اتخاذ إجراءات قانونية إذا لزم الأمر.",
    ),
    TermOfConditionsModel(
      title: "حدود المسؤولية",
      description: "نحن غير مسؤولين عن أي أضرار مباشرة أو غير مباشرة ناتجة عن استخدام الخدمة. لا نضمن توفر الخدمة بدون انقطاع.",
    ),
    TermOfConditionsModel(
      title: "القانون المعمول به",
      description: "تحكم هذه الشروط القوانين المعمول بها في نطاق اختصاصك. سيتم حل أي نزاعات وفقًا للإجراءات القانونية المناسبة.",
    ),
  ];
  static List<Internet> internetUsers = [
    Internet(
      user: "أحمد",
      internet: "100 جيجابايت",
    ),
    Internet(
      user: "محمد",
      internet: "50 جيجابايت",
    ),
    Internet(
      user: "سارة",
      internet: "200 جيجابايت",
    ),
  ];
  static List<InternetDetails> internetDetailsList = [
    InternetDetails(
      remainingPackage: "20 جيجابايت",
      usedPackage: "80 جيجابايت",
      startDate: "2024-03-01",
      endDate: "2024-04-01",
      currentDate: "2024-03-20",
      remainingPeriod: "12 يومًا",
    ),
    InternetDetails(
      remainingPackage: "10 جيجابايت",
      usedPackage: "40 جيجابايت",
      startDate: "2024-03-05",
      endDate: "2024-04-05",
      currentDate: "2024-03-20",
      remainingPeriod: "16 يومًا",
    ),
    InternetDetails(
      remainingPackage: "120 جيجابايت",
      usedPackage: "80 جيجابايت",
      startDate: "2024-03-10",
      endDate: "2024-04-10",
      currentDate: "2024-03-20",
      remainingPeriod: "21 يومًا",
    ),
  ];
}
