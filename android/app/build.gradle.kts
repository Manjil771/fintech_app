import java.util.Properties
import java.io.FileInputStream
import java.util.Locale

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.inputStream().use { localProperties.load(it) }
}

val flutterVersionCode = localProperties.getProperty("flutter.versionCode") ?: "1"
val flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

fun formatFlavorName(flavorName: String): String {
    return when (flavorName) {
        "prod" -> "iSmart"
        "youthVoice" -> "Youth Voice"
        "shreeShital" -> "Shree Shital"
        "shikshakHeet" -> "Shikshak Heet"
        "shubhsiris" -> "Shubhsiris"
        "sarbajyoti" -> "Sarbajyoti"
        "argha" -> "Argha"
        "pame" -> "Pame"
        "chirayu" -> "Chirayu"
        "automobilies" -> "Automobilies"
        "prerana" -> "Prerana"
        "shreepathibhara" -> "Shree Pathibhara"
        "mission" -> "Mission"
        "aabhash" -> "Aabhash"
        "maryadit" -> "Maryadit"
        "supya" -> "Supya"
        "arthikBikash" -> "Arthik Bikash"
        "janakalyan" -> "Jana Kalyan"
        "samudayik" -> "Samudayik"
        "tapobhumi" -> "Tapobhumi"
        "noor" -> "Noor"
        "janani" -> "Janani"
        "arthaGanesh" -> "Artha Ganesh"
        "shubhechha" -> "Shubhechha"
        "jharana" -> "Jharana"
        "sudarshan" -> "Sudarshan"
        "sarbashaktiKtm" -> "Sarbashakti Ktm" 
        "kanchanjungha" -> "Kanchanjungha"
        "ssbalkumari" -> "SS Balkumari"
        "pathibhara" -> "Pathibhara"
        "garima" -> "Garima"
        "agrajMahila" -> "Agraj Mahila"
        "nirika" -> "Nirika"
        "ekikrit" -> "Ekikrit"
        "shreeKalika" -> "Shree Kalika"
        "metrang" -> "Metrang"
        "indreni" -> "Indreni"
        "rastrautthan" -> "Rastrautthan"
        "chaughada" -> "Chaughada"
        "hathausa" -> "Hathausa"
        "paschimanchal" -> "Paschimanchal"
        "shubhodaya" -> "Shubhodaya"
        "avatar" -> "Avatar"
        "gagankalika" -> "Gagankalika"
        "shreeArunodaya" -> "Shree Arunodaya"
        "exotic" -> "Exotic"
        "subhaSandesh" -> "Subha Sandesh"
        "triyuga" -> "Triyuga"
        "saptakaushika" -> "Saptakaushika"
        "ajambari" -> "Ajambari"
        "mahilaAbhiyan" -> "Mahila Abhiyan"
        "mahabir" -> "Mahabir"
        "sundarbagmati" -> "Sundar Bagmati"
        "samadhan" -> "Samadhan"
        "upadesh" -> "Upadesh"
        "tikeshwar" -> "Tikeshwar"
        "jayarupatal" -> "Jayarupatal"
        "sunshineLaxmi" -> "Sunshine Laxmi"
        "skOdraha" -> "SK Odraha"
        "unnati" -> "Unnati"
        "skDharan" -> "SK Dharan"
        "abhiyankrishi" -> "Abhiyan Krishi"
        "sunshine" -> "Sunshine"
        "manokanksha" -> "Manokanksha"
        "aastha" -> "Aastha"
        "dupcheshwor" -> "Dupcheshwor"
        "aakashBani" -> "Aakash Bani"
        "arthabag" -> "Arthabag"
        "shreeHemja" -> "Shree Hemja"
        "uttarbahini" -> "Uttarbahini"
        "shreeSansari" -> "Shree Sansari"
        "chaulani" -> "Chaulani"
        "upakar" -> "Upakar"
        "starlight" -> "Starlight"
        "amrapali" -> "Amrapali"
        "wonderful" -> "Wonderful"
        "bhudev" -> "Bhudev"
        "autoBikash" -> "Auto Bikash"
        "safal" -> "Safal"
        "bhaktapur" -> "Bhaktapur"
        "nilgiree" -> "Nilgiree"
        "bishwakarma" -> "Bishwakarma"
        "race" -> "Race"
        "digoBikash" -> "Digo Bikash"
        "sajha" -> "Sajha"
        "sarbashakti" -> "Sarbashakti"
        "chamber" -> "Chamber"
        "marsyangdi" -> "Marsyangdi"
        "tanahunKalika" -> "Tanahun Kalika"
        "digitalCoop" -> "Digital Coop"
        "tarapunja" -> "Tarapunja"
        "sanakishan" -> "Sana Kishan"
        "skKohabara" -> "SK Kohabara"
        "skPatigaun" -> "SK Patigaun"
        "skKhajurachhi" -> "SK Khajurachhi"
        "skKhudunabari" -> "SK Khudunabari"
        "skJhurkiya" -> "SK Jhurkiya"
        "skShankharpur" -> "SK Shankharpur"
        "amana" -> "Amana"
        "skDhankuta" -> "SK Dhankuta"
        "shreeKanchan" -> "Shree Kanchan"
        "shreekrishna" -> "Shreekrishna"
        "jayshreenavadurga" -> "Jayshree Navadurga"
        "myagde" -> "Myagde"
        "mirmire" -> "Mirmire"
        "shreesapana" -> "Shreesapana"
        "agrasar" -> "Agrasar"
        "khullabajar" -> "Khulla Bajar"
        "lifeVision" -> "Life Vision"
        "aayam" -> "Aayam"
        "kaldhara" -> "Kaldhara"
        "sakar" -> "Sakar"
        "upayogi" -> "Upayogi"
        "omshreeom" -> "Om Shree Om"
        "chetana" -> "Chetana"
        "chandani" -> "Chandani"
        "drabya" -> "Drabya"
        "shubhashreeMulti" -> "Shubhashree Multi"
        "belchautara" -> "Belchautara"
        "shreeNawadeep" -> "Shree Nawadeep"
        "shubhaShree" -> "Shubha Shree"
        "yugbani" -> "Yugbani"
        "mangalpur" -> "Mangalpur"
        "bouddhamode" -> "Bouddhamode"
        "sparkling" -> "Sparkling"
        "samutthan" -> "Samutthan"
        "pacific" -> "Pacific"
        "graminAarthik" -> "Gramin Aarthik"
        "shreeGanesh" -> "Shree Ganesh"
        "shreeSiddhiGanesh" -> "Shree Siddhi Ganesh"
        "abhibadan" -> "Abhibadan"
        "samyukta" -> "Samyukta"
        "globalMulti" -> "Global Multi"
        "tarkariphalafool" -> "Tarkari Phalafool"
        "sklakhanpur" -> "SK Lakhanpur"
        "shakambhari" -> "Shakambhari"
        "hamroDahachok" -> "Hamro Dahachok"
        "skBhawanipur" -> "SK Bhawanipur"
        "pratham" -> "Pratham"
        "aatmabal" -> "Aatmabal"
        "ilum" -> "Ilum"
        "aagraj" -> "Aagraj"
        "babylon" -> "Babylon"
        "adarsha" -> "Adarsha"
        "abhinna" -> "Abhinna"
        "karmashil" -> "Karmashil"
        "dhanaprapti" -> "Dhanaprapti"
        "nagarik" -> "Nagarik"
        "sunadevi" -> "Sunadevi"
        "sunakothi" -> "Sunakothi"
        "thechomahila" -> "Thecho Mahila"
        "sabhyasamaj" -> "Sabhyasamaj"
        "gairigaun" -> "Gairigaun"
        "sunischit" -> "Sunischit"
        "asthaKrishi" -> "Astha Krishi"
        "united" -> "United"
        "samabeshi" -> "Samabeshi"
        "shishuwa" -> "Shishuwa"
        "shreebadhai" -> "Shree Badhai"
        "sayapatri" -> "Sayapatri"
        "megaplus" -> "Mega Plus"
        "skglobal" -> "SK Global"
        "sadasyaSewa" -> "Sadasya Sewa"
        "aagan" -> "Aagan"
        "jyotidaya" -> "Jyotidaya"
        "prime" -> "Prime"
        "krishnaGandaki" -> "Krishna Gandaki"
        "jamune" -> "Jamune"
        "khotangJaleshwori" -> "Khotang Jaleshwori"
        "mithila" -> "Mithila"
        "asaan" -> "Asaan"
        "aarati" -> "Aarati"
        "bishalMulti" -> "Bishal Multi"
        "camellia" -> "Camellia"
        "vaidhik" -> "Vaidhik"
        "shreeShubhakamana" -> "Shree Shubhakamana"
        "bishnudol" -> "Bishnudol"
        "annapurna" -> "Annapurna"
        "rithepani" -> "Rithepani"
        "royal" -> "Royal"
        "immanuel" -> "Immanuel"
        "nayan" -> "Nayan"
        "supreme" -> "Supreme"
        "janasewa" -> "Janasewa"
        "golden" -> "Golden"
        "thankotmahila" -> "Thankot Mahila"
        "buddha" -> "Buddha"
        "hamisabaikokrishi" -> "Hamisabaiko Krishi"
        "matribhumi" -> "Matribhumi"
        "davisfall" -> "Davis Fall"
        "sagarmatha" -> "Sagarmatha"
        "punja" -> "Punja"
        "nilgiri" -> "Nilgiri"
        "nepalbachat" -> "Nepal Bachat"
        "machhapuchhre" -> "Machhapuchhre"
        "machhapuchhreS" -> "Machhapuchhre S"
        "rumjatar" -> "Rumjatar"
        "batika" -> "Batika"
        "sanchar" -> "Sanchar"
        "bhugol" -> "Bhugol"
        "sajiloSaving" -> "Sajilo Saving"
        "sarbahit" -> "Sarbahit"
        "arjunchaupari" -> "Arjun Chaupari"
        "skChisapani" -> "SK Chisapani"
        "sardikhola" -> "Sardikhola"
        "citySaving" -> "City Saving"
        "parishrami" -> "Parishrami"
        "sahara" -> "Sahara"
        "fewa" -> "Fewa"
        "gandakibesi" -> "Gandaki Besi"
        "skDeuri" -> "SK Deuri"
        "bhanjyang" -> "Bhanjyang"
        "kripalu" -> "Kripalu"
        "nawajosh" -> "Nawajosh"
        "bishal" -> "Bishal"
        "manank" -> "Manank"
        "alankar" -> "Alankar"
        "shuvkarya" -> "Shuvkarya"
        "janadhara" -> "Janadhara"
        "sahakarya" -> "Sahakarya"
        "aviyan" -> "Aviyan"
        "kamana" -> "Kamana"
        "uttarganga" -> "Uttarganga"
        "ekata" -> "Ekata"
        "shreegodawari" -> "Shree Godawari"
        "suryadev" -> "Suryadev"
        "navaprabhat" -> "Navaprabhat"
        "vyas" -> "Vyas"
        "janamukhi" -> "Janamukhi"
        "newdhaulagiri" -> "New Dhaulagiri"
        "uddhamsil" -> "Uddhamsil"
        "gomaGanesh" -> "Goma Ganesh"
        "kipoo" -> "Kipoo"
        "shreeAaju" -> "Shree Aaju"
        "shreeMitra" -> "Shree Mitra"
        "devShree" -> "Dev Shree"
        "uddhyamshilata" -> "Uddhyamshilata"
        "gaunle" -> "Gaunle"
        "taksar" -> "Taksar"
        "skWaling" -> "SK Waling"
        "kendradip" -> "Kendradip"
        "kabil" -> "Kabil"
        "siddhibinayak" -> "Siddhibinayak"
        "kendrabindu" -> "Kendrabindu"
        "queen" -> "Queen"
        "babira" -> "Babira"
        "shreejanamukhi" -> "Shree Janamukhi"
        "hetauda" -> "Hetauda"
        "greenhouse" -> "Greenhouse"
        "navadurga" -> "Navadurga"
        "lamosanghu" -> "Lamosanghu"
        "puspanjali" -> "Puspanjali"
        "shreeMiteree" -> "Shree Miteri"
        "eastWest" -> "East West"
        "pragatishil" -> "Pragatishil"
        "sunganga" -> "Sunganga"
        "udhamshilKrishi" -> "Udhamshil Krishi"
        "shreeDigopan" -> "Shree Digopan"
        "ektaMulti" -> "Ekta Multi"
        "nayaKiran" -> "Naya Kiran"
        "janata" -> "Janata"
        "narayani" -> "Narayani"
        "shreechandani" -> "Shree Chandani"
        "sarbahitDang" -> "Sarbahit Dang"
        "smartUdhamshil" -> "Smart Udhamshil"
        "dhanalaxmi" -> "Dhanalaxmi"
        "shwetBhairab" -> "Shwet Bhairab"
        "shreeEkata" -> "Shree Ekata"
        "shreeJanaEkikrit" -> "Shree Jana Ekikrit"
        "karmath" -> "Karmath"
        "shreeMahilaTarkari" -> "Shree Mahila Tarkari"
        "stage" -> "Stage"
        "dev" -> "Dev"
        "sampada" -> "Sampada"
        "shreeFulbari" -> "Shree Fulbari"
        "samriddha" -> "Samriddha"
        "siddhartha" -> "Siddhartha"
        "indrawati" -> "Indrawati"
        "kohinoor" -> "Kohinoor"
        "shubhashreebalkumari" -> "Shubhashree Balkumari"
        "paurakhi" -> "Paurakhi"
        "bhargo" -> "Bhargo"
        "nilpashan" -> "Nilpashan"
        "jhigu" -> "Jhigu"
        "godawari" -> "Godawari"
        "shreePaurakhi" -> "Shree Paurakhi"
        "sarba" -> "Sarba"
        "kshstrashakti" -> "Kshstrashakti"
        "tokha" -> "Tokha"
        "mahalaxmi" -> "Mahalaxmi"
        "aggrim" -> "Aggrim"
        "shreemalunga" -> "Shreemalunga"
        "peoples" -> "Peoples"
        "subarnapur" -> "Subarnapur"
        "narayaniMulti" -> "Narayani Multi"
        "samriddhaNepal" -> "Samriddha Nepal"
        "shreeTriganga" -> "Shree Triganga"
        "sanjeewani" -> "Sanjeewani Saving Coop"
        "shreeKalidevi" -> "Shree Kalidevi"
        "aakash" -> "Aakash"
        "shubhdipawali" -> "Shubhdipawali"
        "atharwa" -> "Atharwa"
        "aichchhik" -> "Aichchhik"
        "kishanKalyan" -> "Kishan Kalyan"
        "utkrishta" -> "Utkrishta"
        "jmc" -> "JMC"
        "sambriddhi" -> "Sambriddhi"
        "kamdhenu" -> "Kamdhenu"
        "dhanrasi" -> "Dhanrasi"
        "shreeSubhakamana" -> "Shree Subhakamana"
        "jayamahalaxmi" -> "Jaya Mahalaxmi"
        "manipur" -> "Manipur"
        "shreePhulbari" -> "Shree Phulbari"
        "shreeSiddhiSankalpa" -> "Shree Siddhi Sankalpa"
        "ashish" -> "Ashish"
        "gauthali" -> "Gauthali"
        "shreephulbari" -> "Shree Phulbari"
        "bhimad" -> "Bhimad"
        "newGeneration" -> "New Generation"
        "shreeBakhan" -> "Shree Bakhan"
        "nayapuime" -> "Nayapuime"
        "sandus" -> "Sandus"
        "bihani" -> "Bihani"
        "shreeChahana" -> "Shree Chahana"
        "sfaclAstam" -> "SFACL Astam" 
        "sfacltetariya" -> "SFACL Tetariya"
        "sfacldibyanagar" -> "SFACL Dibyanagar"
        "universe" -> "Universe"
        "maaLaxmi" -> "Maa Laxmi"
        "infinity" -> "Infinity"
        "moneyPlant" -> "Money Plant"
        "skastam" -> "SK Astam"
        "mahagauri" -> "Mahagauri"
        "kundahar" -> "Kundahar"
        "begnas" -> "Begnas"
        "nagdhunga" -> "Nagdhunga"
        "rorang" -> "Rorang"
        "janakalyanlamjung" -> "Jana Kalyan Lamjung"
        "shreeNawajyoti" -> "Shree Nawajyoti"
        "premier" -> "Premier"
        "besiShahar" -> "Besi Shahar"
        "lamjung" -> "Lamjung"
        "swarnim" -> "Swarnim"
        "hamroNewa" -> "Hamro Newa"
        "janakalyanmulti" -> "Jana Kalyan Multi"
        "baglungmulti" -> "Baglung Multi"
        "developmentcoop" -> "Development Coop"
        "sahasradhara" -> "Sahasradhara"
        "aadhunikjana" -> "Aadhunik Jana"
        "youthvision" -> "Youth Vision"
        "niyaman" -> "Niyaman"
        "naturalmulti" -> "Natural Multi"
        "maruti" -> "Maruti"
        "shreemandan" -> "Shree Mandan"
        "sahayatricoop" -> "Sahayatri Coop"
        "janak" -> "Janak"
        "lapha" -> "Lapha"
        "adhikosh" -> "Adhikosh"
        "janasewamulti" -> "Janasewa Multi"
        "kanchanCoop" -> "Kanchan Coop"
        "nawayuba" -> "Nawa Yuba"
        "janapremi" -> "Jana Premi"
        "abhyudaya" -> "Abhyudaya"
        "artharaksha" -> "Artha Raksha"
        "shreejanshil" -> "Shree Janshil"
        "upasanawomen" -> "Upasana Women"
        "janataagri" -> "Janata Agri"
        "mitra" -> "Mitra"
        "taudaha" -> "Taudaha"
        "kasturi" -> "Kasturi"
        "kunphen" -> "Kunphen"
        "janasambriddhi" -> "Janasambriddhi"
        "aanbukhaireni" -> "Aanbu Khaireni"
        "ainchoPaincho" -> "Aincho Paincho"
        "laxmiDeep" -> "Laxmi Deep"
        "hamro" -> "Hamro"
        "unitedhands" -> "United Hands"
        "santaneshwornaudhara" -> "Santaneshwor Naudhara"
        "patan" -> "Patan"
        "pariwortan" -> "Pariwortan"
        "sahayatriSaving" -> "Sahayatri Saving"
        "shreegorakhkali" -> "Shree Gorakhkali"
        "nhugupala" -> "Nhugu Pala"
        "sahayatripokhara" -> "Sahayatri Pokhara"
        "samajkalyan" -> "Samaj Kalyan"
        "kunchhal" -> "Kunchhal"
        "neela" -> "Neela"
        "paryatan" -> "Paryatan"
        "arunjyoti" -> "Arunjyoti"
        "gaja" -> "Gaja"
        "hamroSaving" -> "Hamro Saving"
        "janachetana" -> "Jana Chetana"
        "janakalyanbahumukhi" -> "Jana Kalyan Bahumukhi"
        "setogurans" -> "Seto Gurans"
        "asaMulti" -> "Asa Multi"
        "ujyalo" -> "Ujyalo"
        "satyeta" -> "Satyeta"
        "join" -> "Join"
        "sahayogi" -> "Sahayogi"
        "akkaladevi" -> "Akkaladevi"
        "goldstar" -> "Goldstar"
        else -> {
            val parts = flavorName.replace(Regex("(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])"), " ")
                                  .split(" ")
            return parts.joinToString(" ") { it.replaceFirstChar { if (it.isLowerCase()) it.titlecase(Locale.ROOT) else it.toString() } }
        }
    }
}

android {
    namespace = "com.example.ismart"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
    }

    defaultConfig {
        applicationId = "com.devanasoft.ismart"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    packaging {
        jniLibs {
            useLegacyPackaging = false
        }
    }

    flavorDimensions += "app"
     
    productFlavors {
        create("prod") {
            dimension = "app"
            applicationId = "com.devanasoft.ismart"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("youthVoice") {
            dimension = "app"
            applicationId = "com.devanasoft.youthVoice"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeShital") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeShital"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shikshakHeet") {
            dimension = "app"
            applicationId = "com.devanasoft.shikshakHeet"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shubhsiris") {
            dimension = "app"
            applicationId = "com.devanasoft.shubhsiris"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sarbajyoti") {
            dimension = "app"
            applicationId = "com.devanasoft.sarbajyoti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("argha") {
            dimension = "app"
            applicationId = "com.devanasoft.argha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("pame") {
            dimension = "app"
            applicationId = "com.devanasoft.pame"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("chirayu") {
            dimension = "app"
            applicationId = "com.devanasoft.chirayu"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("automobilies") {
            dimension = "app"
            applicationId = "com.devanasoft.automobilies"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("prerana") {
            dimension = "app"
            applicationId = "com.devanasoft.prerana"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreepathibhara") {
            dimension = "app"
            applicationId = "com.devanasoft.shreepathibhara"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("mission") {
            dimension = "app"
            applicationId = "com.devanasoft.mission"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("aabhash") {
            dimension = "app"
            applicationId = "com.devanasoft.aabhash"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("maryadit") {
            dimension = "app"
            applicationId = "com.devanasoft.maryadit"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("supya") {
            dimension = "app"
            applicationId = "com.devanasoft.supya"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("arthikBikash") {
            dimension = "app"
            applicationId = "com.devanasoft.arthikBikash"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janakalyan") {
            dimension = "app"
            applicationId = "com.devanasoft.janakalyan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("samudayik") {
            dimension = "app"
            applicationId = "com.devanasoft.samudayik"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("tapobhumi") {
            dimension = "app"
            applicationId = "com.devanasoft.tapobhumi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("noor") {
            dimension = "app"
            applicationId = "com.devanasoft.noor"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janani") {
            dimension = "app"
            applicationId = "com.devanasoft.janani"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("arthaGanesh") {
            dimension = "app"
            applicationId = "com.devanasoft.arthaGanesh"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shubhechha") {
            dimension = "app"
            applicationId = "com.devanasoft.shubhechha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("jharana") {
            dimension = "app"
            applicationId = "com.devanasoft.jharana"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sudarshan") {
            dimension = "app"
            applicationId = "com.devanasoft.sudarshan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sarbashaktiKtm") {
            dimension = "app"
            applicationId = "com.devanasoft.sarbashaktiKtm"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kanchanjungha") {
            dimension = "app"
            applicationId = "com.devanasoft.kanchanjungha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("ssbalkumari") {
            dimension = "app"
            applicationId = "com.devanasoft.ssbalkumari"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("pathibhara") {
            dimension = "app"
            applicationId = "com.devanasoft.pathibhara"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("garima") {
            dimension = "app"
            applicationId = "com.devanasoft.garima"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("agrajMahila") {
            dimension = "app"
            applicationId = "com.devanasoft.agrajMahilas"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("nirika") {
            dimension = "app"
            applicationId = "com.devanasoft.nirika"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("ekikrit") {
            dimension = "app"
            applicationId = "com.devanasoft.ekikrit"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeKalika") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeKalika"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("metrang") {
            dimension = "app"
            applicationId = "com.devanasoft.metrang"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("indreni") {
            dimension = "app"
            applicationId = "com.devanasoft.indreni"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("rastrautthan") {
            dimension = "app"
            applicationId = "com.devanasoft.rastrautthan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("chaughada") {
            dimension = "app"
            applicationId = "com.devanasoft.chaughada"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("hathausa") {
            dimension = "app"
            applicationId = "com.devanasoft.hathausa"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("paschimanchal") {
            dimension = "app"
            applicationId = "com.devanasoft.paschimanchal"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shubhodaya") {
            dimension = "app"
            applicationId = "com.devanasoft.shubhodaya"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("avatar") {
            dimension = "app"
            applicationId = "com.devanasoft.avatar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("gagankalika") {
            dimension = "app"
            applicationId = "com.devanasoft.gagankalika"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeArunodaya") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeArunodaya"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("exotic") {
            dimension = "app"
            applicationId = "com.devanasoft.exotic"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("subhaSandesh") {
            dimension = "app"
            applicationId = "com.devanasoft.subhaSandesh"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("triyuga") {
            dimension = "app"
            applicationId = "com.devanasoft.triyuga"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("saptakaushika") {
            dimension = "app"
            applicationId = "com.devanasoft.saptakaushika"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("ajambari") {
            dimension = "app"
            applicationId = "com.devanasoft.ajambari"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("mahilaAbhiyan") {
            dimension = "app"
            applicationId = "com.devanasoft.mahilaAbhiyan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("mahabir") {
            dimension = "app"
            applicationId = "com.devanasoft.mahabir"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sundarbagmati") {
            dimension = "app"
            applicationId = "com.devanasoft.sundarbagmati"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("samadhan") {
            dimension = "app"
            applicationId = "com.devanasoft.samadhan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("upadesh") {
            dimension = "app"
            applicationId = "com.devanasoft.upadesh"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("tikeshwar") {
            dimension = "app"
            applicationId = "com.devanasoft.tikeshwar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("jayarupatal") {
            dimension = "app"
            applicationId = "com.devanasoft.jayarupatal"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sunshineLaxmi") {
            dimension = "app"
            applicationId = "com.devanasoft.sunshineLaxmi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skOdraha") {
            dimension = "app"
            applicationId = "com.devanasoft.skOdraha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("unnati") {
            dimension = "app"
            applicationId = "com.devanasoft.unnati"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skDharan") {
            dimension = "app"
            applicationId = "com.devanasoft.skDharan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("abhiyankrishi") {
            dimension = "app"
            applicationId = "com.devanasoft.abhiyankrishi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sunshine") {
            dimension = "app"
            applicationId = "com.devanasoft.sunshine"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("manokanksha") {
            dimension = "app"
            applicationId = "com.devanasoft.manokanksha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("aastha") {
            dimension = "app"
            applicationId = "com.devanasoft.aastha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("dupcheshwor") {
            dimension = "app"
            applicationId = "com.devanasoft.dupcheshwor"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("aakashBani") {
            dimension = "app"
            applicationId = "com.devanasoft.aakashBani"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("arthabag") {
            dimension = "app"
            applicationId = "com.devanasoft.arthabag"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeHemja") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeHemja"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("uttarbahini") {
            dimension = "app"
            applicationId = "com.devanasoft.uttarbahini"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeSansari") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeSansari"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("chaulani") {
            dimension = "app"
            applicationId = "com.devanasoft.chaulani"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("upakar") {
            dimension = "app"
            applicationId = "com.devanasoft.upakar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("starlight") {
            dimension = "app"
            applicationId = "com.devanasoft.starlight"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("amrapali") {
            dimension = "app"
            applicationId = "com.devanasoft.amrapali"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("wonderful") {
            dimension = "app"
            applicationId = "com.devanasoft.wonderful"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("bhudev") {
            dimension = "app"
            applicationId = "com.devanasoft.bhudev"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("autoBikash") {
            dimension = "app"
            applicationId = "com.devanasoft.autoBikash"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("safal") {
            dimension = "app"
            applicationId = "com.devanasoft.safal"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("bhaktapur") {
            dimension = "app"
            applicationId = "com.devanasoft.bhaktapur"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("nilgiree") {
            dimension = "app"
            applicationId = "com.devanasoft.nilgiree"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("bishwakarma") {
            dimension = "app"
            applicationId = "com.devanasoft.bishwakarma"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("race") {
            dimension = "app"
            applicationId = "com.devanasoft.race"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("digoBikash") {
            dimension = "app"
            applicationId = "com.devanasoft.digoBikash"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sajha") {
            dimension = "app"
            applicationId = "com.devanasoft.sajha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sarbashakti") {
            dimension = "app"
            applicationId = "com.devanasoft.sarbashakti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("chamber") {
            dimension = "app"
            applicationId = "com.devanasoft.chamber"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("marsyangdi") {
            dimension = "app"
            applicationId = "com.devanasoft.marsyangdi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("tanahunKalika") {
            dimension = "app"
            applicationId = "com.devanasoft.tanahunKalika"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("digitalCoop") {
            dimension = "app"
            applicationId = "com.devanasoft.digitalCoop"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("tarapunja") {
            dimension = "app"
            applicationId = "com.devanasoft.tarapunja"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sanakishan") {
            dimension = "app"
            applicationId = "com.devanasoft.sanakishan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skKohabara") {
            dimension = "app"
            applicationId = "com.devanasoft.skKohabara"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skPatigaun") {
            dimension = "app"
            applicationId = "com.devanasoft.skPatigaun"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skKhajurachhi") {
            dimension = "app"
            applicationId = "com.devanasoft.skKhajurachhi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skKhudunabari") {
            dimension = "app"
            applicationId = "com.devanasoft.skKhudunabari"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skJhurkiya") {
            dimension = "app"
            applicationId = "com.devanasoft.skJhurkiya"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skShankharpur") {
            dimension = "app"
            applicationId = "com.devanasoft.skShankharpur"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("amana") {
            dimension = "app"
            applicationId = "com.devanasoft.amana"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skDhankuta") {
            dimension = "app"
            applicationId = "com.devanasoft.skDhankuta"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeKanchan") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeKanchan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreekrishna") {
            dimension = "app"
            applicationId = "com.devanasoft.shreekrishna"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("jayshreenavadurga") {
            dimension = "app"
            applicationId = "com.devanasoft.jayshreenavadurga"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("myagde") {
            dimension = "app"
            applicationId = "com.devanasoft.myagde"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("mirmire") {
            dimension = "app"
            applicationId = "com.devanasoft.mirmire"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreesapana") {
            dimension = "app"
            applicationId = "com.devanasoft.shreesapana"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("agrasar") {
            dimension = "app"
            applicationId = "com.devanasoft.agrasar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("khullabajar") {
            dimension = "app"
            applicationId = "com.devanasoft.khullabajar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("lifeVision") {
            dimension = "app"
            applicationId = "com.devanasoft.lifeVision"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("aayam") {
            dimension = "app"
            applicationId = "com.devanasoft.aayam"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kaldhara") {
            dimension = "app"
            applicationId = "com.devanasoft.kaldhara"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sakar") {
            dimension = "app"
            applicationId = "com.devanasoft.sakar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("upayogi") {
            dimension = "app"
            applicationId = "com.devanasoft.upayogi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("omshreeom") {
            dimension = "app"
            applicationId = "com.devanasoft.omshreeom"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("chetana") {
            dimension = "app"
            applicationId = "com.devanasoft.chetana"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("chandani") {
            dimension = "app"
            applicationId = "com.devanasoft.chandani"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("drabya") {
            dimension = "app"
            applicationId = "com.devanasoft.drabya"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shubhashreeMulti") {
            dimension = "app"
            applicationId = "com.devanasoft.shubhashreeMulti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("belchautara") {
            dimension = "app"
            applicationId = "com.devanasoft.belchautara"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeNawadeep") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeNawadeep"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shubhaShree") {
            dimension = "app"
            applicationId = "com.devanasoft.shubhaShree"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("yugbani") {
            dimension = "app"
            applicationId = "com.devanasoft.yugbani"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("mangalpur") {
            dimension = "app"
            applicationId = "com.devanasoft.mangalpur"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("bouddhamode") {
            dimension = "app"
            applicationId = "com.devanasoft.bouddhamode"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sparkling") {
            dimension = "app"
            applicationId = "com.devanasoft.sparkling"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("samutthan") {
            dimension = "app"
            applicationId = "com.devanasoft.samutthan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("pacific") {
            dimension = "app"
            applicationId = "com.devanasoft.pacific"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("graminAarthik") {
            dimension = "app"
            applicationId = "com.devanasoft.graminAarthik"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeGanesh") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeGanesh"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeSiddhiGanesh") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeSiddhiGanesh"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("abhibadan") {
            dimension = "app"
            applicationId = "com.devanasoft.abhibadan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("samyukta") {
            dimension = "app"
            applicationId = "com.devanasoft.samyukta"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("globalMulti") {
            dimension = "app"
            applicationId = "com.devanasoft.globalMulti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("tarkariphalafool") {
            dimension = "app"
            applicationId = "com.devanasoft.tarkariphalafool"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sklakhanpur") {
            dimension = "app"
            applicationId = "com.devanasoft.sklakhanpur"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shakambhari") {
            dimension = "app"
            applicationId = "com.devanasoft.shakambhari"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("hamroDahachok") {
            dimension = "app"
            applicationId = "com.devanasoft.hamroDahachok"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skBhawanipur") {
            dimension = "app"
            applicationId = "com.devanasoft.skBhawanipur"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("pratham") {
            dimension = "app"
            applicationId = "com.devanasoft.pratham"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("aatmabal") {
            dimension = "app"
            applicationId = "com.devanasoft.aatmabal"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("ilum") {
            dimension = "app"
            applicationId = "com.devanasoft.ilum"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("aagraj") {
            dimension = "app"
            applicationId = "com.devanasoft.aagraj"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("babylon") {
            dimension = "app"
            applicationId = "com.devanasoft.babylon"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("adarsha") {
            dimension = "app"
            applicationId = "com.devanasoft.adarsha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("abhinna") {
            dimension = "app"
            applicationId = "com.devanasoft.abhinna"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("karmashil") {
            dimension = "app"
            applicationId = "com.devanasoft.karmashil"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("dhanaprapti") {
            dimension = "app"
            applicationId = "com.devanasoft.dhanaprapti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("nagarik") {
            dimension = "app"
            applicationId = "com.devanasoft.nagarik"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sunadevi") {
            dimension = "app"
            applicationId = "com.devanasoft.sunadevi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sunakothi") {
            dimension = "app"
            applicationId = "com.devanasoft.sunakothi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("thechomahila") {
            dimension = "app"
            applicationId = "com.devanasoft.thechomahila"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sabhyasamaj") {
            dimension = "app"
            applicationId = "com.devanasoft.sabhyasamaj"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("gairigaun") {
            dimension = "app"
            applicationId = "com.devanasoft.gairigaun"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sunischit") {
            dimension = "app"
            applicationId = "com.devanasoft.sunischit"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("asthaKrishi") {
            dimension = "app"
            applicationId = "com.devanasoft.asthaKrishi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("united") {
            dimension = "app"
            applicationId = "com.devanasoft.united"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("samabeshi") {
            dimension = "app"
            applicationId = "com.devanasoft.samabeshi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shishuwa") {
            dimension = "app"
            applicationId = "com.devanasoft.shishuwa"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreebadhai") {
            dimension = "app"
            applicationId = "com.devanasoft.shreebadhai"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sayapatri") {
            dimension = "app"
            applicationId = "com.devanasoft.sayapatri"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("megaplus") {
            dimension = "app"
            applicationId = "com.devanasoft.megaplus"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skglobal") {
            dimension = "app"
            applicationId = "com.devanasoft.skglobal"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sadasyaSewa") {
            dimension = "app"
            applicationId = "com.devanasoft.sadasyaSewa"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("aagan") {
            dimension = "app"
            applicationId = "com.devanasoft.aagan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("jyotidaya") {
            dimension = "app"
            applicationId = "com.devanasoft.jyotidaya"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("prime") {
            dimension = "app"
            applicationId = "com.devanasoft.prime"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("krishnaGandaki") {
            dimension = "app"
            applicationId = "com.devanasoft.krishnaGandaki"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("jamune") {
            dimension = "app"
            applicationId = "com.devanasoft.jamune"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("khotangJaleshwori") {
            dimension = "app"
            applicationId = "com.devanasoft.khotangJaleshwori"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("mithila") {
            dimension = "app"
            applicationId = "com.devanasoft.mithila"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("asaan") {
            dimension = "app"
            applicationId = "com.devanasoft.asaan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("aarati") {
            dimension = "app"
            applicationId = "com.devanasoft.aarati"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("bishalMulti") {
            dimension = "app"
            applicationId = "com.devanasoft.bishalMulti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("camellia") {
            dimension = "app"
            applicationId = "com.devanasoft.camellia"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("vaidhik") {
            dimension = "app"
            applicationId = "com.devanasoft.vaidhik"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeShubhakamana") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeShubhakamana"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("bishnudol") {
            dimension = "app"
            applicationId = "com.devanasoft.bishnudol"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("annapurna") {
            dimension = "app"
            applicationId = "com.devanasoft.annapurna"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("rithepani") {
            dimension = "app"
            applicationId = "com.devanasoft.rithepani"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("royal") {
            dimension = "app"
            applicationId = "com.devanasoft.royal"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("immanuel") {
            dimension = "app"
            applicationId = "com.devanasoft.immanuel"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("nayan") {
            dimension = "app"
            applicationId = "com.devanasoft.nayan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("supreme") {
            dimension = "app"
            applicationId = "com.devanasoft.supreme"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janasewa") {
            dimension = "app"
            applicationId = "com.devanasoft.janasewa"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("golden") {
            dimension = "app"
            applicationId = "com.devanasoft.golden"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("thankotmahila") {
            dimension = "app"
            applicationId = "com.devanasoft.thankotmahila"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("buddha") {
            dimension = "app"
            applicationId = "com.devanasoft.buddha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("hamisabaikokrishi") {
            dimension = "app"
            applicationId = "com.devanasoft.hamisabaikokrishi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("matribhumi") {
            dimension = "app"
            applicationId = "com.devanasoft.matribhumi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("davisfall") {
            dimension = "app"
            applicationId = "com.devanasoft.davisfall"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sagarmatha") {
            dimension = "app"
            applicationId = "com.devanasoft.sagarmatha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("punja") {
            dimension = "app"
            applicationId = "com.devanasoft.punja"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("nilgiri") {
            dimension = "app"
            applicationId = "com.devanasoft.nilgiri"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("nepalbachat") { //for nepal saving
            dimension = "app"
            applicationId = "com.devanasoft.nepalbachat"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("machhapuchhre") {    //for finact
            dimension = "app"
            applicationId = "com.devanasoft.machhapuchhre"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("machhapuchhreS") { // for systematic
            dimension = "app"
            applicationId = "com.devanasoft.machhapuchhreS"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("rumjatar") {
            dimension = "app"
            applicationId = "com.devanasoft.rumjatar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("batika") {
            dimension = "app"
            applicationId = "com.devanasoft.batika"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sanchar") {
            dimension = "app"
            applicationId = "com.devanasoft.sanchar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("bhugol") {
            dimension = "app"
            applicationId = "com.devanasoft.bhugol"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sajiloSaving") {
            dimension = "app"
            applicationId = "com.devanasoft.sajiloSaving"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sarbahit") {
            dimension = "app"
            applicationId = "com.devanasoft.sarbahit"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("arjunchaupari") {
            dimension = "app"
            applicationId = "com.devanasoft.arjunchaupari"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skChisapani") {
            dimension = "app"
            applicationId = "com.devanasoft.skChisapani"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sardikhola") {
            dimension = "app"
            applicationId = "com.devanasoft.sardikhola"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("citySaving") {
            dimension = "app"
            applicationId = "com.devanasoft.citySaving"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("parishrami") {
            dimension = "app"
            applicationId = "com.devanasoft.parishrami"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sahara") {
            dimension = "app"
            applicationId = "com.devanasoft.sahara"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("fewa") {
            dimension = "app"
            applicationId = "com.devanasoft.fewa"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("gandakibesi") {
            dimension = "app"
            applicationId = "com.devanasoft.gandakibesi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skDeuri") {
            dimension = "app"
            applicationId = "com.devanasoft.skDeuri"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("bhanjyang") {
            dimension = "app"
            applicationId = "com.devanasoft.bhanjyang"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kripalu") {
            dimension = "app"
            applicationId = "com.devanasoft.kripalu"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("nawajosh") {
            dimension = "app"
            applicationId = "com.devanasoft.nawajosh"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("bishal") {
            dimension = "app"
            applicationId = "com.devanasoft.bishal"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("manank") {
            dimension = "app"
            applicationId = "com.devanasoft.manank"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("alankar") {
            dimension = "app"
            applicationId = "com.devanasoft.alankar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shuvkarya") {
            dimension = "app"
            applicationId = "com.devanasoft.shuvkarya"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janadhara") {
            dimension = "app"
            applicationId = "com.devanasoft.janadhara"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sahakarya") {
            dimension = "app"
            applicationId = "com.devanasoft.sahakarya"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("aviyan") {
            dimension = "app"
            applicationId = "com.devanasoft.aviyan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kamana") {
            dimension = "app"
            applicationId = "com.devanasoft.kamana"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("uttarganga") {
            dimension = "app"
            applicationId = "com.devanasoft.uttarganga"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("ekata") {
            dimension = "app"
            applicationId = "com.devanasoft.ekata"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreegodawari") {
            dimension = "app"
            applicationId = "com.devanasoft.shreegodawari"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("suryadev") {
            dimension = "app"
            applicationId = "com.devanasoft.suryadev"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("navaprabhat") {
            dimension = "app"
            applicationId = "com.devanasoft.navaprabhat"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("vyas") {
            dimension = "app"
            applicationId = "com.devanasoft.vyas"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janamukhi") {
            dimension = "app"
            applicationId = "com.devanasoft.janamukhi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("newdhaulagiri") {
            dimension = "app"
            applicationId = "com.devanasoft.newdhaulagiri"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("uddhamsil") {
            dimension = "app"
            applicationId = "com.devanasoft.uddhamsil"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("gomaGanesh") {
            dimension = "app"
            applicationId = "com.devanasoft.gomaGanesh"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kipoo") {
            dimension = "app"
            applicationId = "com.devanasoft.kipoo"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeAaju") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeAaju"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeMitra") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeMitra"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("devShree") {
            dimension = "app"
            applicationId = "com.devanasoft.devShree"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("uddhyamshilata") {
            dimension = "app"
            applicationId = "com.devanasoft.uddhyamshilata"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("gaunle") {
            dimension = "app"
            applicationId = "com.devanasoft.gaunle"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("taksar") {
            dimension = "app"
            applicationId = "com.devanasoft.taksar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skWaling") {
            dimension = "app"
            applicationId = "com.devanasoft.skWaling"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kendradip") {
            dimension = "app"
            applicationId = "com.devanasoft.kendradip"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kabil") {
            dimension = "app"
            applicationId = "com.devanasoft.kabil"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("siddhibinayak") {
            dimension = "app"
            applicationId = "com.devanasoft.siddhibinayak"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kendrabindu") {
            dimension = "app"
            applicationId = "com.devanasoft.kendrabindu"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("queen") {
            dimension = "app"
            applicationId = "com.devanasoft.queen"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("babira") {
            dimension = "app"
            applicationId = "com.devanasoft.babira"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreejanamukhi") {
            dimension = "app"
            applicationId = "com.devanasoft.shreejanamukhi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("hetauda") {
            dimension = "app"
            applicationId = "com.devanasoft.hetauda"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("greenhouse") {
            dimension = "app"
            applicationId = "com.devanasoft.greenhouse"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("navadurga") {
            dimension = "app"
            applicationId = "com.devanasoft.navadurga"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("lamosanghu") {
            dimension = "app"
            applicationId = "com.devanasoft.lamosanghu"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("puspanjali") {
            dimension = "app"
            applicationId = "com.devanasoft.puspanjali"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeMiteree") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeMiteri"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("eastWest") {
            dimension = "app"
            applicationId = "com.devanasoft.eastWest"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("pragatishil") {
            dimension = "app"
            applicationId = "com.devanasoft.pragatishil"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sunganga") {
            dimension = "app"
            applicationId = "com.devanasoft.sunganga"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("udhamshilKrishi") {
            dimension = "app"
            applicationId = "com.devanasoft.uddhamshilKrishi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeDigopan") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeDigopan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("ektaMulti") {
            dimension = "app"
            applicationId = "com.devanasoft.ekataMulti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("nayaKiran") {
            dimension = "app"
            applicationId = "com.devanasoft.nayaKiran"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janata") {
            dimension = "app"
            applicationId = "com.devanasoft.janata"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("narayani") {
            dimension = "app"
            applicationId = "com.devanasoft.narayani"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreechandani") {
            dimension = "app"
            applicationId = "com.devanasoft.shreechandani"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sarbahitDang") {
            dimension = "app"
            applicationId = "com.devanasoft.sarbahitDang"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("smartUdhamshil") {
            dimension = "app"
            applicationId = "com.devanasoft.smartUdhamshil"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("dhanalaxmi") {
            dimension = "app"
            applicationId = "com.devanasoft.dhanalaxmi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shwetBhairab") {
            dimension = "app"
            applicationId = "com.devanasoft.shwetBhairab"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeEkata") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeEkata"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeJanaEkikrit") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeJanaEkikrit"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("karmath") {
            dimension = "app"
            applicationId = "com.devanasoft.karmath"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeMahilaTarkari") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeMahilaTarkari"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("stage") {
            dimension = "app"
            applicationId = "com.devanasoft.ismart.dev"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("dev") {
            dimension = "app"
            applicationId = "com.devanasoft.ismart.dev"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sampada") {
            dimension = "app"
            applicationId = "com.devanasoft.sampada"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeFulbari") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeFulbari"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("samriddha") {
            dimension = "app"
            applicationId = "com.devanasoft.samriddha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("siddhartha") {
            dimension = "app"
            applicationId = "com.devanasoft.siddhartha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("indrawati") {
            dimension = "app"
            applicationId = "com.devanasoft.indrawati"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kohinoor") {
            dimension = "app"
            applicationId = "com.devanasoft.kohinoor"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shubhashreebalkumari") {
            dimension = "app"
            applicationId = "com.devanasoft.ssbalkumari"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("paurakhi") {
            dimension = "app"
            applicationId = "com.devanasoft.paurakhi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("bhargo") {
            dimension = "app"
            applicationId = "com.devanasoft.bhargo"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("nilpashan") {
            dimension = "app"
            applicationId = "com.devanasoft.nilpashan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("jhigu") {
            dimension = "app"
            applicationId = "com.devanasoft.jhigu"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("godawari") {
            dimension = "app"
            applicationId = "com.devanasoft.godawari"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreePaurakhi") {
            dimension = "app"
            applicationId = "com.devanasoft.shreePaurakhi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sarba") {
            dimension = "app"
            applicationId = "com.devanasoft.sarba"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kshstrashakti") {
            dimension = "app"
            applicationId = "com.devanasoft.kshstrashakti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("tokha") {
            dimension = "app"
            applicationId = "com.devanasoft.tokha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("mahalaxmi") {
            dimension = "app"
            applicationId = "com.devanasoft.mahalaxmi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("aggrim") {
            dimension = "app"
            applicationId = "com.devanasoft.aggrim"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreemalunga") {
            dimension = "app"
            applicationId = "com.devanasoft.shreemalunga"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("peoples") {
            dimension = "app"
            applicationId = "com.devanasoft.peoples"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("subarnapur") {
            dimension = "app"
            applicationId = "com.devanasoft.subarnapur"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("narayaniMulti") {
            dimension = "app"
            applicationId = "com.devanasoft.narayaniMulti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("samriddhaNepal") {
            dimension = "app"
            applicationId = "com.devanasoft.samriddhaNepal"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeTriganga") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeTriganga"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sanjeewani") {
            dimension = "app"
            applicationId = "com.devanasoft.sanjeewaniSavingcoop"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeKalidevi") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeKalidevi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("aakash") {
            dimension = "app"
            applicationId = "com.devanasoft.aakash"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shubhdipawali") {
            dimension = "app"
            applicationId = "com.devanasoft.shubhdipawali"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("atharwa") {
            dimension = "app"
            applicationId = "com.devanasoft.atharwa"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("aichchhik") {
            dimension = "app"
            applicationId = "com.devanasoft.aichchhik"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kishanKalyan") {
            dimension = "app"
            applicationId = "com.devanasoft.kishanKalyan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("utkrishta") {
            dimension = "app"
            applicationId = "com.devanasoft.utkrishta"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("jmc") {
            dimension = "app"
            applicationId = "com.devanasoft.jmc"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sambriddhi") {
            dimension = "app"
            applicationId = "com.devanasoft.sambriddhi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kamdhenu") {
            dimension = "app"
            applicationId = "com.devanasoft.kamdhenu"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("dhanrasi") {
            dimension = "app"
            applicationId = "com.devanasoft.dhanrasi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeSubhakamana") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeShubhakamana"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("jayamahalaxmi") {
            dimension = "app"
            applicationId = "com.devanasoft.jayamahalaxmi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("manipur") {
            dimension = "app"
            applicationId = "com.devanasoft.manipur"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreePhulbari") {
            dimension = "app"
            applicationId = "com.devanasoft.shreePhulbari"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeSiddhiSankalpa") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeSiddhiSankalpa"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("ashish") {
            dimension = "app"
            applicationId = "com.devanasoft.ashish"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("gauthali") {
            dimension = "app"
            applicationId = "com.devanasoft.gauthali"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreephulbari") {
            dimension = "app"
            applicationId = "com.devanasoft.shreephulbari"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("bhimad") {
            dimension = "app"
            applicationId = "com.devanasoft.bhimad"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("newGeneration") {
            dimension = "app"
            applicationId = "com.devanasoft.newGeneration"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeBakhan") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeBakhan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("nayapuime") {
            dimension = "app"
            applicationId = "com.devanasoft.nayapuime"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sandus") {
            dimension = "app"
            applicationId = "com.devanasoft.sandus"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("bihani") {
            dimension = "app"
            applicationId = "com.devanasoft.bihani"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeChahana") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeChahana"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sfaclAstam") {
            dimension = "app"
            applicationId = "com.devanasoft.sfaclAstam"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sfacltetariya") {
            dimension = "app"
            applicationId = "com.devanasoft.sfacltetariya"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sfacldibyanagar") {
            dimension = "app"
            applicationId = "com.devanasoft.sfacldibyanagar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("universe") {
            dimension = "app"
            applicationId = "com.devanasoft.universe"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("maaLaxmi") {
            dimension = "app"
            applicationId = "com.devanasoft.maaLaxmi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("infinity") {
            dimension = "app"
            applicationId = "com.devanasoft.infinity"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("moneyPlant") {
            dimension = "app"
            applicationId = "com.devanasoft.moneyPlant"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("skastam") {
            dimension = "app"
            applicationId = "com.devanasoft.skastam"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("mahagauri") {
            dimension = "app"
            applicationId = "com.devanasoft.mahagauri"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kundahar") {
            dimension = "app"
            applicationId = "com.devanasoft.kundahar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("begnas") {
            dimension = "app"
            applicationId = "com.devanasoft.begnas"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("nagdhunga") {
            dimension = "app"
            applicationId = "com.devanasoft.nagdhunga"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("rorang") {
            dimension = "app"
            applicationId = "com.devanasoft.rorang"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janakalyanlamjung") {
            dimension = "app"
            applicationId = "com.devanasoft.janakalyanlamjung"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreeNawajyoti") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeNawajyoti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("premier") {
            dimension = "app"
            applicationId = "com.devanasoft.premier"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("besiShahar") {
            dimension = "app"
            applicationId = "com.devanasoft.besiShahar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("lamjung") {
            dimension = "app"
            applicationId = "com.devanasoft.lamjung"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("swarnim") {
            dimension = "app"
            applicationId = "com.devanasoft.swarnim"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("hamroNewa") {
            dimension = "app"
            applicationId = "com.devanasoft.hamroNewa"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janakalyanmulti") {
            dimension = "app"
            applicationId = "com.devanasoft.janakalyanmulti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("baglungmulti") {
            dimension = "app"
            applicationId = "com.devanasoft.baglungmulti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("developmentcoop") {
            dimension = "app"
            applicationId = "com.devanasoft.developmentCoop"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sahasradhara") {
            dimension = "app"
            applicationId = "com.devanasoft.sahasradhara"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("aadhunikjana") {
            dimension = "app"
            applicationId = "com.devanasoft.aadhunikjana"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("youthvision") {
            dimension = "app"
            applicationId = "com.devanasoft.youthvision"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("niyaman") {
            dimension = "app"
            applicationId = "com.devanasoft.niyaman"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("naturalmulti") {
            dimension = "app"
            applicationId = "com.devanasoft.naturalmulti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("maruti") {
            dimension = "app"
            applicationId = "com.devanasoft.maruti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreemandan") {
            dimension = "app"
            applicationId = "com.devanasoft.shreemandan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sahayatricoop") {
            dimension = "app"
            applicationId = "com.devanasoft.sahayatricoop"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janak") {
            dimension = "app"
            applicationId = "com.devanasoft.janak"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("lapha") {
            dimension = "app"
            applicationId = "com.devanasoft.lapha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("adhikosh") {
            dimension = "app"
            applicationId = "com.devanasoft.adhikosh"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janasewamulti") {
            dimension = "app"
            applicationId = "com.devanasoft.janasewamulti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kanchanCoop") {
            dimension = "app"
            applicationId = "com.devanasoft.kanchanCoop"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("nawayuba") {
            dimension = "app"
            applicationId = "com.devanasoft.nawayuba"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janapremi") {
            dimension = "app"
            applicationId = "com.devanasoft.janapremi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("abhyudaya") {
            dimension = "app"
            applicationId = "com.devanasoft.abhyudaya"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("artharaksha") {
            dimension = "app"
            applicationId = "com.devanasoft.artharaksha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreejanshil") {
            dimension = "app"
            applicationId = "com.devanasoft.shreejanshil"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("upasanawomen") {
            dimension = "app"
            applicationId = "com.devanasoft.upasanawomen"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janataagri") {
            dimension = "app"
            applicationId = "com.devanasoft.janataagri"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("mitra") {
            dimension = "app"
            applicationId = "com.devanasoft.mitra"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("taudaha") {
            dimension = "app"
            applicationId = "com.devanasoft.taudaha"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kasturi") {
            dimension = "app"
            applicationId = "com.devanasoft.kasturi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kunphen") {
            dimension = "app"
            applicationId = "com.devanasoft.kunphen"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janasambriddhi") {
            dimension = "app"
            applicationId = "com.devanasoft.janasambriddhi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("aanbukhaireni") {
            dimension = "app"
            applicationId = "com.devanasoft.aanbukhaireni"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("ainchoPaincho") {
            dimension = "app"
            applicationId = "com.devanasoft.ainchoPaincho"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("laxmiDeep") {
            dimension = "app"
            applicationId = "com.devanasoft.laxmiDeep"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("hamro") {
            dimension = "app"
            applicationId = "com.devanasoft.hamro"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("unitedhands") {
            dimension = "app"
            applicationId = "com.devanasoft.unitedhands"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("santaneshwornaudhara") {
            dimension = "app"
            applicationId = "com.devanasoft.santaneshwornaudhara"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("patan") {
            dimension = "app"
            applicationId = "com.devanasoft.patan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("pariwortan") {
            dimension = "app"
            applicationId = "com.devanasoft.pariwortan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sahayatriSaving") {
            dimension = "app"
            applicationId = "com.devanasoft.sahayatriSaving"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("shreegorakhkali") {
            dimension = "app"
            applicationId = "com.devanasoft.shreegorakhkali"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("nhugupala") {
            dimension = "app"
            applicationId = "com.devanasoft.nhugupala"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sahayatripokhara") {
            dimension = "app"
            applicationId = "com.devanasoft.sahayatripokhara"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("samajkalyan") {
            dimension = "app"
            applicationId = "com.devanasoft.samajkalyan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("kunchhal") {
            dimension = "app"
            applicationId = "com.devanasoft.kunchhal"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("neela") {
            dimension = "app"
            applicationId = "com.devanasoft.neela"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("paryatan") {
            dimension = "app"
            applicationId = "com.devanasoft.paryatan"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("arunjyoti") {
            dimension = "app"
            applicationId = "com.devanasoft.arunjyoti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("gaja") {
            dimension = "app"
            applicationId = "com.devanasoft.gaja"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("hamroSaving") {
            dimension = "app"
            applicationId = "com.devanasoft.hamroSaving"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janachetana") {
            dimension = "app"
            applicationId = "com.devanasoft.janachetana"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("janakalyanbahumukhi") {
            dimension = "app"
            applicationId = "com.devanasoft.janakalyanbahumukhi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("setogurans") {
            dimension = "app"
            applicationId = "com.devanasoft.setogurans"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("asaMulti") {
            dimension = "app"
            applicationId = "com.devanasoft.asaMulti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("ujyalo") {
            dimension = "app"
            applicationId = "com.devanasoft.ujyalo"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("satyeta") {
            dimension = "app"
            applicationId = "com.devanasoft.satyeta"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("join") {
            dimension = "app"
            applicationId = "com.devanasoft.join"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("sahayogi") {
            dimension = "app"
            applicationId = "com.devanasoft.sahayogi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("akkaladevi") {
            dimension = "app"
            applicationId = "com.devanasoft.akkaladevi"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", formatFlavorName(name))
        }
        create("goldstar") {
            dimension = "app"
            applicationId = "com.devanasoft.goldstar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", "goldstar")
        }
        create("shreeMallaj") {
            dimension = "app"
            applicationId = "com.devanasoft.shreeMallaj"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", "shreeMallaj")
        }
        create("karobar") {
            dimension = "app"
            applicationId = "com.devanasoft.karobar"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", "karobar")
        }
         create("arthanjali") {
            dimension = "app"
            applicationId = "com.devanasoft.arthanjali"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", "arthanjali")
        }
        create("samargra") {
            dimension = "app"
            applicationId = "com.devanasoft.samargra"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", "samargra")
        }
        create("mahilapariwaratn") {
            dimension = "app"
            applicationId = "com.devanasoft.mahilapariwaratn"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", "mahilapariwaratn")
        }
        create("arnikomajdur") {
            dimension = "app"
            applicationId = "com.devanasoft.arnikomajdur"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", "arnikomajdur")
        }
        create("sajhedari") {
            dimension = "app"
            applicationId = "com.devanasoft.sajhedari"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", "sajhedari")
        }
        create("namaste") {
            dimension = "app"
            applicationId = "com.devanasoft.namaste"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", "namaste")
        }
        create("madiMulti") {
            dimension = "app"
            applicationId = "com.devanasoft.madiMulti"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", "madiMulti")
        }
        create("bajrangabali") {
            dimension = "app"
            applicationId = "com.devanasoft.bajrangabali"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", "bajrangabali")
        }
        create("model") {
            dimension = "app"
            applicationId = "com.devanasoft.model"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", "model")
        }
        create("luniva") {
            dimension = "app"
            applicationId = "com.devanasoft.luniva"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", "luniva")
        }
          create("mangaldeep") {
            dimension = "app"
            applicationId = "com.devanasoft.mangaldeep"
            versionCode = flutterVersionCode.toInt()
            versionName = flutterVersionName
            resValue("string", "app_name", "mangaldeep")
        }
    }

    signingConfigs {
        create("release") {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
            if (keystorePropertiesFile.exists()) {
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
            }
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.9.23")
    implementation("com.squareup.okhttp3:okhttp:4.10.0") // ✅ Add here
}