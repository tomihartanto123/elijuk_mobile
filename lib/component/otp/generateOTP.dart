import 'dart:math';

String generateOTP() {
  Random random = Random();
  // Generate random 4-digit OTP
  int otp = random.nextInt(9000) + 1000;
  return otp.toString();
}
