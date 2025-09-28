#!/bin/sh
set -e
set -u
set -o pipefail

function on_error {
  echo "$(realpath -mq "${0}"):$1: error: Unexpected failure"
}
trap 'on_error $LINENO' ERR

if [ -z ${UNLOCALIZED_RESOURCES_FOLDER_PATH+x} ]; then
  # If UNLOCALIZED_RESOURCES_FOLDER_PATH is not set, then there's nowhere for us to copy
  # resources to, so exit 0 (signalling the script phase was successful).
  exit 0
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

# This protects against multiple targets copying the same framework dependency at the same time. The solution
# was originally proposed here: https://lists.samba.org/archive/rsync/2008-February/020158.html
RSYNC_PROTECT_TMP_FILES=(--filter "P .*.??????")

case "${TARGETED_DEVICE_FAMILY:-}" in
  1,2)
    TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
    ;;
  1)
    TARGET_DEVICE_ARGS="--target-device iphone"
    ;;
  2)
    TARGET_DEVICE_ARGS="--target-device ipad"
    ;;
  3)
    TARGET_DEVICE_ARGS="--target-device tv"
    ;;
  4)
    TARGET_DEVICE_ARGS="--target-device watch"
    ;;
  *)
    TARGET_DEVICE_ARGS="--target-device mac"
    ;;
esac

install_resource()
{
  if [[ "$1" = /* ]] ; then
    RESOURCE_PATH="$1"
  else
    RESOURCE_PATH="${PODS_ROOT}/$1"
  fi
  if [[ ! -e "$RESOURCE_PATH" ]] ; then
    cat << EOM
error: Resource "$RESOURCE_PATH" not found. Run 'pod install' to update the copy resources script.
EOM
    exit 1
  fi
  case $RESOURCE_PATH in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.framework)
      echo "mkdir -p ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      mkdir -p "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" $RESOURCE_PATH ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH"`.mom\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm\"" || true
      xcrun mapc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE="$RESOURCE_PATH"
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    *)
      echo "$RESOURCE_PATH" || true
      echo "$RESOURCE_PATH" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-kabil" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-kabil copy" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-uddhamsil" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-nepalbachat" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-nilgiri" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-bhanjyang" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-sarbahit" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-aviyan" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-ekata" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-kripalu" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-janamukhi" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-dhaulagiri" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-nawaprabhat" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-vyas" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-kamana" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-sahakarya" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-manank" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-alankar" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-kipoo" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-sparkling" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-shreemitra" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-gomaganesh" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-janadhara" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-arthabag" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Debug-uttarganga" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-kabil" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sandus" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sarbashakti" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-arunjyoti" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-paryatan" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sandus copy" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-manakamana" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shikhar" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-patan" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-jayamahalaxmi" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-siddhartha" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-bihani" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-kshstrashakti" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-narayaniMulti" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-jmc" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-samriddhaNepal" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-indrawati" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-swarnim" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-peoples" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-upasanawomen" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-nhugupala" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-samajKalyan" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-neela" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sahayogi" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-arthikBikash" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-mahalaxmi" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-janakalyanbahumukhi" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-janakalyan" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-join" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-satyeta" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-ujyalo" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-asaMulti" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-setogurans" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-gaja" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sanjeewani" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shreejanakalyan" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-hamroSaving" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-bhargo" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-digoBikash" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-lapha" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-baglungmulti" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-belchautara" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-devanasoft" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sampadaCoop" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-utkrishta" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-kunchhal" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-babylon" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-rorang" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-kendradip" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-kabil copy" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-chetana" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-aadhunikjana" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-nepalCoop" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-narayani" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-tgway" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-aabhash" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-devshree" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-exotic" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sunischit" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-race" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-jayShreeMataNavadurga" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-uttargangaNew" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-kamanaNew" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-nirika" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shreekrishna" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-dupcheshwor" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shreeKrishna" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-omshreeom" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-ajambari" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-tarkariphalafool" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-upayogiSaccos" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shreeMiteree" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shubhaShreeSaving" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-united" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-wonderful" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sparkling" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sarbajyoti" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-globalMulti" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-hetauda" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shwetBhairab" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shubhashreeMulti" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-kjiSmart" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sadasyaSewa" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-abhibadan" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-myagdeDugdha" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-parishrami" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-mangalpur" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shreeKalika" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-ektaMulti" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-babira" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-metrang" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sarbahitDang" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-upayogi" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-khotangJaleshwori" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-puspanjali" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-jamune" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-bhaktapur" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shubhaSandesh" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shreeSiddhiGanesh" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-kaldhara" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-aakashbani" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-subhodaya" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-lifeVision" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shreeEkata" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-aarati" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-queen" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-eastWest" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sanchar" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-noor" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-avatar" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sunshine" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-paschimanchal" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sudarshan" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shreeHemja" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-uttarbahini" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-upakar" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-digitalCoop" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-kanchanjungha" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-aastha" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-myagde" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-bhugol" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-vaidhik" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sanakishan" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-bishnudol" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-batika" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-nayan" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-janasewa" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-bishalMulti" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-rithepani" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-annapurnaHealth" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-supreme" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-immanuel" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-golden" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-thankotmahila" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-buddha" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-punja" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sagarmatha" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-hamisabaikokrishi" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-rumjatar" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sardikhola" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shreejanamukhi" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shreeaaju" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-machhapuchhre" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-bishal" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-fewa" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-davisfall" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-nawajosh" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-matribhumi" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-uddhamsil" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-nepalbachat" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-nilgiri" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-bhanjyang" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sarbahit" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-kripalu" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-aviyan" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-ekata" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-janamukhi" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-dhaulagiri" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-nawaprabhat" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-vyas" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-kamana" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-sahakarya" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-alankar" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-gomaganesh" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-janadhara" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-manank" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-arthabag" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-kipoo" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-shreemitra" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Release-uttarganga" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-kabil" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-uddhamsil" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-nepalbachat" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-nilgiri" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-bhanjyang" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-sarbahit" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-kripalu" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-aviyan" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-ekata" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-janamukhi" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-dhaulagiri" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-kamana" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-sahakarya" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-alankar" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-kipoo" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-shreemitra" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-manank" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-nawaprabhat" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-vyas" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-gomaganesh" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-janadhara" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-arthabag" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile-uttarganga" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi
if [[ "$CONFIGURATION" == "Profile" ]]; then
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/permission_handler_apple/permission_handler_apple_privacy.bundle"
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]] && [[ "${SKIP_INSTALL}" == "NO" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "${XCASSET_FILES:-}" ]
then
  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find -L "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "${PODS_ROOT}*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  if [ -z ${ASSETCATALOG_COMPILER_APPICON_NAME+x} ]; then
    printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  else
    printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" --app-icon "${ASSETCATALOG_COMPILER_APPICON_NAME}" --output-partial-info-plist "${TARGET_TEMP_DIR}/assetcatalog_generated_info_cocoapods.plist"
  fi
fi
