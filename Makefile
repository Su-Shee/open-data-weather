tageswerte-1948-2012.csv: weatherdata.txt
	@tr -d '\r' < $< > $@
	@sed -i 's/,eor//g' $@
	@sed -i 's/[[:space:]]\+//g' $@
	@sed -i 's/\([a-z]\+\)/\U\1/g' $@
	@sed -i 's/\([0-9]\{4\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)/\1-\2-\3/' $@
	@rm -f $<

weatherdata.txt: produkt_klima_Tageswerte_19480101_20121231_00433.txt
	@mv $< $@

produkt_klima_Tageswerte_19480101_20121231_00433.txt: weather-historic-tempelhof.zip
	@unzip $<
	@rm -f Beschreibung*.html
	@rm -f Protokoll*.txt
	@rm -f Stationsmetadaten*.txt

weather-historic-tempelhof.zip:
	@wget http://www.dwd.de/bvbw/generator/DWDWWW/Content/Oeffentlichkeit/KU/KU2/KU21/klimadaten/german/download/tageswerte/kl__10384__hist__txt,templateId=raw,property=publicationFile.zip/kl_10384_hist_txt.zip \
        -O weather-historic-tempelhof.zip 2>/dev/null || true
clean:
	rm -f *tempelhof.zip
	rm -f *.txt
	rm -f Beschreibung*.html
	rm -f tageswerte-1948-2012.csv
