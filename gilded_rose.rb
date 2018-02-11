def update_quality(items)
  items.each do |item|

  case item.name
    when'Aged Brie'
      update_aged_brie_quality(item)
    when 'Backstage passes to a TAFKAL80ETC concert'
      update_backstage_pass_quality(item)
    when 'Conjured Mana Cake'
      update_conjured_item_quality(item)
    when 'Sulfuras, Hand of Ragnaros'
      update_sulfuras_item_quality(item)
    else update_common_item_quality(item)

    end
  end
end

def decrease_sell_in(item)
  item.sell_in -= 1
end

def increase_quality(item)
  item.quality +=1 if item.quality < 50
end

def decrease_quality(item)
  item.quality -= 1 if item.quality > 0
end

def expired(item)
  item.sell_in < 0
end

def update_common_item_quality(item)
    decrease_sell_in(item)
    decrease_quality(item)
    # this is the standard procedure. one day and one quality tick go down.
    if expired(item)
      decrease_quality(item)
    # if the item is on or past sell by, it goes down two quality ticks total
    end
  end

def update_aged_brie_quality(item)
  decrease_sell_in(item)
  increase_quality(item)

  if expired(item)
    increase_quality(item)
  end
end

def update_sulfuras_item_quality(item)
  item.quality = item.quality
end

def update_backstage_pass_quality(item)
  decrease_sell_in(item)
  increase_quality(item)

  if item.sell_in < 10
    increase_quality(item)
    if item.sell_in < 5
      increase_quality(item)
      if expired(item)
        item.quality = 0
      end
    end
  end
end

def update_conjured_item_quality(item)
  decrease_sell_in(item)
  item.quality -= 2 if item.quality > 0 && !expired(item)
  item.quality -= 4 if item.quality > 0 && expired(item)
end


# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]
