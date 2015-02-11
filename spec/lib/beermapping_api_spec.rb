require 'rails_helper'

describe BeermappingApi do
  describe "in case of cache miss" do
    it "When HTTP GEt returns one entry, it is parsed and returned" do
      canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>12411</id><name>Gallows Bird</name><status>Brewery</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12411</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=12411&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=12411&amp;d=1&amp;type=norm</blogmap><street>Merituulentie 30</street><city>Espoo</city><state></state><zip>02200</zip><country>Finland</country><phone>+358 9 412 3253</phone><overall>91.66665</overall><imagecount>0</imagecount></location></bmp_locations>
      END_OF_STRING

      stub_request(:get, /.*espoo/,).to_return(body: canned_answer, headers: {'Content-Type' => "text/xml"})
      places = BeermappingApi.places_in("espoo")
      expect(places.size).to eq(1)
      place = places.first
      expect(place.name).to eq("Gallows Bird")
      expect(place.street).to eq("Merituulentie 30")
    end

    it "When HTTP GET returns empty entry, it is an empty array" do
      canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id></id><name></name><status></status><reviewlink></reviewlink><proxylink></proxylink><blogmap></blogmap><street></street><city></city><state></state><zip></zip><country></country><phone></phone><overall></overall><imagecount></imagecount></location></bmp_locations>
      END_OF_STRING

      stub_request(:get, /.*/,).to_return(body: canned_answer, headers: {'Content-Type' => "text/xml"})
      places = BeermappingApi.places_in("ebin")
      expect(places.size).to eq(0)
    end

    it "HTTP GET returns many entries" do
      canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>10003</id><name>Holsten-Brauerei AG</name><status>Brewery</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=10003</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=10003&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=10003&amp;d=1&amp;type=norm</blogmap><street>Holstenstr. 224</street><city>Hamburg</city><state></state><zip>22765</zip><country>Germany</country><phone>040 38101-0</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>10778</id><name>Groeninger</name><status>Brewpub</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=10778</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=10778&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=10778&amp;d=1&amp;type=norm</blogmap><street>Willy-Brandt-Str. 47</street><city>Hamburg</city><state></state><zip>20457</zip><country>Germany</country><phone>+49/40/331381</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>13106</id><name>Consumers Beverages - Hamburg</name><status>Beer Store</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13106</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13106&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13106&amp;d=1&amp;type=norm</blogmap><street>5755 Maelou Drive</street><city>Hamburg</city><state>NY</state><zip>14075</zip><country>United States</country><phone>(716) 648-1355</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>14662</id><name>Bierland Hamburg</name><status>Beer Store</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=14662</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=14662&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=14662&amp;d=1&amp;type=norm</blogmap><street>Seumestraße 10</street><city>Hamburg</city><state></state><zip>22089</zip><country>Germany</country><phone>49-40-208971</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>14722</id><name>Pappenheimer Wirtschaft</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=14722</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=14722&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=14722&amp;d=1&amp;type=norm</blogmap><street>Papenhuder Str. 26</street><city>Hamburg</city><state></state><zip>22087</zip><country>Germany</country><phone>+49-40-386331</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>14724</id><name>Brauhaus Joh. Albrecht</name><status>Brewpub</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=14724</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=14724&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=14724&amp;d=1&amp;type=norm</blogmap><street>Adolphsbrücke 7</street><city>Hamburg</city><state></state><zip>20457</zip><country>Germany</country><phone>+49-40 - 36 77 40</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>15431</id><name>Zum Sudhaus</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=15431</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=15431&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=15431&amp;d=1&amp;type=norm</blogmap><street>Spielbudenplatz 13</street><city>Hamburg</city><state></state><zip>20359</zip><country>Germany</country><phone>040 3192922</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>15432</id><name>Hardy's</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=15432</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=15432&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=15432&amp;d=1&amp;type=norm</blogmap><street>Tresckowstr. 14</street><city>Hamburg</city><state></state><zip>20257</zip><country>Germany</country><phone>040 494600</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
      END_OF_STRING

      stub_request(:get, /.*hamburg/,).to_return(body: canned_answer, headers: {'Content-Type' => "text/xml"})
      places = BeermappingApi.places_in("hamburg")
      expect(places.size).to eq(8)
      expect(places.first.name).to eq("Holsten-Brauerei AG")
      expect(places.last.name).to eq("Hardy's")
    end
  end

  describe "in case of cache miss" do
    it "When one entry in cache, it is returned" do
      canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>13307</id><name>O'Connell's Irish Bar</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13307</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13307&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13307&amp;d=1&amp;type=norm</blogmap><street>Rautatienkatu 24</street><city>Tampere</city><state></state><zip>33100</zip><country>Finland</country><phone>35832227032</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
      END_OF_STRING

      stub_request(:get, /.*tampere/).to_return(body: canned_answer, headers: {'Content-Type' => "text/xml"})
      BeermappingApi.places_in("tampere")
      places = BeermappingApi.places_in("tampere")
      expect(places.size).to eq(1)
      place = places.first
      expect(place.name).to eq("O'Connell's Irish Bar")
      expect(place.street).to eq("Rautatienkatu 24")
    end
  end

end