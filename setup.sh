#!/bin/bash

echo ""
echo "Installing ICR142_Benchmarking ..."
echo ""

[ -w ".Rprofile" ] && rm .Rprofile

Rscript sessionInfo.R --bootstrap-packrat > setup.log 2>&1

cp packrat/packrat_source/.Rprofile ./

echo ""
echo "Installation of ICR142_Benchmarking has finished ..."
echo ""
