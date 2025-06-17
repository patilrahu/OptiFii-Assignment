import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class StringConstant {
  static String appFontFamily = GoogleFonts.lexend().fontFamily!;
  static const uuid = Uuid();
  static String currencySymbol = '₹';
  static String reimbursementRequestHeading = "Reimbursement request";
  static String selectFromTransaction = "Select from transaction";
  static String orText = "Or";
  static String fileUploadText = "Fill form manually";
  static String uploadBillText = "Upload Bill";
  static String scanUploadText = "Scan & Upload";
  static String walletText = "Wallet";
  static String addAmountText = "Add amount";
  static String selectCategory = "Select category";
  static String purPoseText = "Purpose";
  static String marchantName = "Merchant name";
  static String dateText = "Date";
  static String remarkText = "Remark (optional)";
  static String saveBtnText = "Save";
  static String nextBtnText = "Next";
  static String paidFromWallet = "Paid from";
  static String addToReportText = "Add to report";
  static String savedText = "Saved";
  static String submitReport = "Submit Report";
  static String expenseListText = "Expense list";
  static String addExpenseText = "Add expense";
  static String addReportSuccess = "Successfully added to report";
  static String reportSuccessText =
      "Your reimbursement report is submitted successfully ";
  static String viewReport = "View Report";

  //error message
  static String noDataText = "Oops! We couldn't find any data";
  static String formEmptyText = "Please fill all fields!";
  static String selectTransactionErrorText = "Please select transaction!";

  // static list data
  static const selectCategoryOption = ["Food", "Fuel"];
}
