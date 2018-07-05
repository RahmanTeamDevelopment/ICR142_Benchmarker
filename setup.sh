#!/bin/bash

echo ""
echo "Installing ICR142_Benchmarker ..."
echo ""

[ -w ".Rprofile" ] && rm .Rprofile

Rscript sessionInfo.R --bootstrap-packrat > setup.log 2>&1

cp packrat/packrat_source/.Rprofile ./

echo ""
echo "Installation of ICR142_Benchmarker has finished ..."
echo ""
