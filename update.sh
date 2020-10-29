#!/usr/bin/env sh
git stash
git fetch -a
rm -rf temp/*
git checkout -b fetchAll

# clone simpler invocing repository
git clone https://github.com/SimplerInvoicing/validation.git ./temp/si
rm -rf ./simpler-invoicing
mkdir ./simpler-invoicing
mv ./temp/si/schematron ./simpler-invoicing/
mv ./temp/si/xsl ./simpler-invoicing/
rm -rf ./temp/si


# clone xRechnung
rm -rf ./xRechnung
mkdir xRechnung
git clone https://github.com/itplr-kosit/xrechnung-schematron.git ./temp/xRechnung
mv ./temp/xRechnung/validation/schematron ./xRechnung
rm -rf ./temp/xRechnung


# clone peppol-bis
git clone https://github.com/OpenPEPPOL/peppol-bis-invoice-3.git ./temp/peppolBis3
rm -rf ./PeppolBIS3
mkdir PeppolBIS3
mv ./temp/peppolBis3/rules/sch ./PeppolBIS3/
rm -rf ./temp/peppolBis3

# clone Zugferd
git clone https://github.com/ZUGFeRD/ZUV.git ./temp/Zugferd
rm -rf ./Zugferd
mkdir Zugferd
mv ./temp/Zugferd/src/main/resources/xslt ./Zugferd
rm -rf ./temp/Zugferd

# clone SG
git clone https://github.com/SG-PEPPOL/SG-PEPPOL-Specifications.git ./temp/SG
rm -rf ./SG
mkdir SG
mv ./temp/SG/"SG PEPPOL BIS Billing 3"/"Presentation Stylesheet" ./SG
mv ./temp/SG/"SG PEPPOL BIS Billing 3"/Schematron ./SG
rm -rf ./temp/SG

# clone test sets
git clone https://github.com/LeiSun-1101/PeppolTestRuleSet.git ./temp/test
rm -rf ./TestSets
mkdir TestSets
mv ./temp/test/sch ./TestSets/
rm -rf ./temp/test

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

git diff --quiet HEAD info -- ./SG
sgFlag=$?

git diff --quiet HEAD info -- ./TestSets
testFlag=$?

commitTitle='Peppol Rulesets for schematron have been changed:'
commitSi=''
commitXr=''
commitPBis3=''
commitZuv=''
flag=0

if [ $siFlag -eq 1 ]; then
  commitSi="SimplerInvoicing Updated --> https://github.com/SimplerInvoicing/validation.git"
  flag=1
fi

if [ $xrFlag -eq 1 ]; then
  commitXr="xRechnung Updated --> https://github.com/itplr-kosit/xrechnung-schematron.git"
  flag=1
fi

if [ $pBis3Flag -eq 1 ]; then
  commitPBis3="Peppol BIS 3 Updated --> https://github.com/OpenPEPPOL/peppol-bis-invoice-3.git"
  flag=1
fi

if [ $zuvFlag -eq 1 ]; then
  commitZuv="Zugferd Updated --> https://github.com/ZUGFeRD/ZUV.git"
  flag=1
fi

if [ $sgFlag -eq 1 ]; then
  commitSG="Singapore Schematron Updated --> https://github.com/LeiSun-1101/PeppolTestRuleSet.git"
  flag=1
fi

if [ $testFlag -eq 1 ]; then
  commitTest="Test Sets Updated --> https://github.com/LeiSun-1101/PeppolTestRuleSet.git"
  flag=1
fi

if [ $flag -eq 1 ]; then
    git commit --amend -m "${commitTitle}" -m "${commitSi}" -m "${commitXr}" -m "${commitPBis3}" -m "${commitZuv}" -m "${commitSG}" -m "${commitTest}"
fi
