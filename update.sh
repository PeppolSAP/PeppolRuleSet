#!/usr/bin/env sh
git stash
git fetch -a
git checkout origin/info -b info
git branch -D fetchAll
rm -rf temp/*
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
mv ./temp/xRechnung/validation/schematron/ ./xRechnung
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


git diff  --quiet HEAD info -- ./xRechnung
xrFlag=$?

git diff  --quiet HEAD info -- ./simpler-invoicing
siFlag=$?

git diff --quiet HEAD info -- ./PeppolBIS3
pBis3Flag=$?

git diff --quiet HEAD info -- ./Zugferd
zuvFlag=$?

commitTitle='Peppol Rules Update Summary:'
commitSi=''
commitXr=''
commitPBis3=''
commitZuv=''

if [ $siFlag -eq 1 ]; then
  commitSi="SimplerInvoicing Updated --> https://github.com/SimplerInvoicing/validation.git"
fi

if [ $xrFlag -eq 1 ]; then
  commitXr="xRechnung Updated --> https://github.com/itplr-kosit/xrechnung-schematron.git"
fi

if [ $pBis3Flag -eq 1 ]; then
  commitPBis3="Peppol BIS 3 Updated --> https://github.com/OpenPEPPOL/peppol-bis-invoice-3.git"
fi

if [ $zuvFlag -eq 1 ]; then
  commitZuv="Zugferd Updated --> https://github.com/ZUGFeRD/ZUV.git"
fi

git commit --amend -m "${commitTitle}" -m "${commitSi}" -m "${commitXr}" -m "${commitPBis3}" -m "${commitZuv}"
