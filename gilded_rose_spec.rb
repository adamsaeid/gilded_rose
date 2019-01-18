require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "lowers values for quality and sell_in by 1" do
      items = [Item.new("High Wire", 5, 10)]
      GildedRose.new(items).update_quality()
      item = items[0]
      expect(item.sell_in).to eq 4
      expect(item.quality).to eq 9
    end

    it "lowers quality by 2 if sell by date passed" do
      items = [Item.new("High Wire", 0, 10)]
      GildedRose.new(items).update_quality()
      item = items[0]
      expect(item.quality).to eq 8
    end

    it "does not lower quality to a negative value" do
      items = [Item.new("High Wire", 5, 0)]
      GildedRose.new(items).update_quality()
      item = items[0]
      expect(item.quality).to eq 0
    end

    context 'Aged Brie' do
      it 'increases quality by 1' do
        items = [Item.new("Aged Brie", 5, 10)]
        GildedRose.new(items).update_quality()
        item = items[0]
        expect(item.quality).to eq 11
      end

      it 'does not increase quality to > 50' do
        items = [Item.new("Aged Brie", 0, 50)]
        GildedRose.new(items).update_quality()
        item = items[0]
        expect(item.quality).to eq 50
      end
    end

    context 'Sulfuras, Hand of Ragnaros' do
      it 'does not decrease quality' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 80)]
        GildedRose.new(items).update_quality()
        item = items[0]
        expect(item.quality).to eq 80
      end
    end

    context 'Backstage passes to a TAFKAL80ETC concert' do
      it 'increases quality by 1 when > 10 days left' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 30)]
        GildedRose.new(items).update_quality()
        item = items[0]
        expect(item.quality).to eq 31
      end

      it 'increases quality by 2 when <= 10 days left' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 30)]
        GildedRose.new(items).update_quality()
        item = items[0]
        expect(item.quality).to eq 32
      end

      it 'increases quality by 2 when <= 5 days left' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 30)]
        GildedRose.new(items).update_quality()
        item = items[0]
        expect(item.quality).to eq 33
      end

      it 'sets quality to 0 when 0 days left' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 30)]
        GildedRose.new(items).update_quality()
        item = items[0]
        expect(item.quality).to eq 0
      end
    end
  end

end
