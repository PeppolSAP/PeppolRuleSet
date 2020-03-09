git checkout -b fetchAll

# clone simpler invocing repository
git clone https://github.com/SimplerInvoicing/validation.git ./temp/si
rm -rf ./simpler-invoicing/*
mv ./temp/si/schematron ./simpler-invoicing/
mv ./temp/si/xsl ./simpler-invoicing/
rm -rf ./temp/si


# clone xRechnung
rm -rf ./xRechnung/*
git clone https://github.com/itplr-kosit/xrechnung-schematron.git ./temp/xRechnung
mv ./temp/xRechnung/validation/schematron/* ./xRechnung
rm -rf ./temp/xRechnung


# clone peppol-bis
git clone https://github.com/OpenPEPPOL/peppol-bis-invoice-3.git ./temp/peppolBis3
rm -rf ./PeppolBIS3/*
mv ./temp/peppolBis3/rules/sch ./PeppolBIS3/
rm -rf ./temp/peppolBis3


# clone Zugferd
git clone https://github.com/ZUGFeRD/ZUV.git ./temp/Zugferd
rm -rf ./Zugferd/*
mv ./temp/Zugferd/src/main/resources/xslt ./Zugferd
rm -rf ./temp/Zugferd

git add .
git commit -m "Initilial Commit"


git diff  --quiet HEAD master -- ./xRechnung
xrFlag=$?

git diff  --quiet HEAD master -- ./simpler-invoicing
siFlag=$?

git diff --quiet HEAD master -- ./PeppolBIS3
pBis3Flag=$?

git diff --quiet HEAD master -- ./Zugferd
zuvFlag=$?

if [ $siFlag -eq 1 ]; then
  echo "SimplerInvoicing Updated --> https://github.com/SimplerInvoicing/validation.git"
fi

if [ $xrFlag -eq 1 ]; then
  echo "xRechnung Updated --> https://github.com/itplr-kosit/xrechnung-schematron.git"
fi

if [ $pBis3Flag -eq 1 ]; then
  echo "Peppol BIS 3 Updated --> https://github.com/OpenPEPPOL/peppol-bis-invoice-3.git"
fi

if [ $zuvFlag -eq 1 ]; then
  echo "Zugferd Updated --> https://github.com/ZUGFeRD/ZUV.git"
fi