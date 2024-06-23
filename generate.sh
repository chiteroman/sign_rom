KEY=/home/marcos/chiteroman.pem

SUBJECT='/C=ES/ST=Asturias/L=Oviedo/O=chiteroman/OU=chiteroman/CN=chiteroman/emailAddress=querveros999@gmail.com'

if [ ! -f $KEY ]; then
    openssl genrsa -f4 -out $KEY 4096
fi

mkdir ~/.android-certs

for cert in bluetooth cyngn-app media networkstack nfc platform releasekey sdk_sandbox shared testcert testkey verity; do
    openssl req -new -x509 -sha256 -key $KEY -out ~/.android-certs/$cert.x509.pem -days 10000 -subj "$SUBJECT"
    openssl pkcs8 -in $KEY -topk8 -outform DER -out ~/.android-certs/$cert.pk8 -nocrypt
done

for apex in com.android.adbd com.android.adservices com.android.adservices.api com.android.appsearch com.android.art com.android.bluetooth com.android.btservices com.android.cellbroadcast com.android.compos com.android.configinfrastructure com.android.connectivity.resources com.android.conscrypt com.android.devicelock com.android.extservices com.android.graphics.pdf com.android.hardware.biometrics.face.virtual com.android.hardware.biometrics.fingerprint.virtual com.android.hardware.boot com.android.hardware.cas com.android.hardware.wifi com.android.healthfitness com.android.hotspot2.osulogin com.android.i18n com.android.ipsec com.android.media com.android.media.swcodec com.android.mediaprovider com.android.nearby.halfsheet com.android.networkstack.tethering com.android.neuralnetworks com.android.ondevicepersonalization com.android.os.statsd com.android.permission com.android.resolv com.android.rkpd com.android.runtime com.android.safetycenter.resources com.android.scheduling com.android.sdkext com.android.support.apexer com.android.telephony com.android.telephonymodules com.android.tethering com.android.tzdata com.android.uwb com.android.uwb.resources com.android.virt com.android.vndk.current com.android.vndk.current.on_vendor com.android.wifi com.android.wifi.dialog com.android.wifi.resources com.google.pixel.camera.hal com.google.pixel.vibrator.hal com.qorvo.uwb; do
    SUBJECT='/C=ES/ST=Asturias/L=Oviedo/O=chiteroman/OU=chiteroman/CN='$apex'/emailAddress=querveros999@gmail.com'
    openssl req -new -x509 -sha256 -key $KEY -out ~/.android-certs/$apex.x509.pem -days 10000 -subj "$SUBJECT"
    openssl pkcs8 -in $KEY -topk8 -outform DER -out ~/.android-certs/$apex.pk8 -nocrypt
    openssl pkcs8 -in ~/.android-certs/$apex.pk8 -inform DER -nocrypt -out ~/.android-certs/$apex.pem
done
