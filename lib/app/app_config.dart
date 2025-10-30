// class Flavor {
//   static String defaultValue = "prod";
//   final String flavorName;

//   Flavor(this.flavorName);
// }
// Flavor sancharFlavor = Flavor("sanchar");

// List<Flavor> flavorChoices = [
//   Flavor("iSmart"),
//   Flavor("Sanchar"),
//   Flavor("Uddhamsil"),
//   Flavor("Punja"),
// ];

// Flavor get kBuildFlavor {
//   Flavor currentFlavor = Flavor("prod");
//   String flavorName = String.fromEnvironment(
//     'FLAVOR',
//     defaultValue: Flavor.defaultValue,
//   );
//   flavorChoices.forEach((element) {
//     if (element.flavorName.toLowerCase() == flavorName.toLowerCase()) {
//       currentFlavor = element;
//     }
//   });

//   return currentFlavor;
// }

// extension IsSame on Flavor {
//   bool isSame(Flavor flavor) {
//     bool _isSame = false;
//     if (kBuildFlavor.flavorName.toLowerCase() == flavorName.toLowerCase()) {
//       _isSame = true;
//     }
//     return _isSame;
//   }
// }
