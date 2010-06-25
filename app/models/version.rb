class Version < ActiveRecord::Base
  belongs_to :note
  belongs_to :user
  belongs_to :notes
  has_many :citations

  def highlighted
    b = body
    
    ranges.each do |r|
      puts r.inspect
      
      range_end = r[:end].nil? ? -1 : r[:end]
      range_start = r[:start]
      b.insert range_end, '</span>'
      b.insert range_start, "<span class='citation' data-citations='#{r[:attributes].join(' ')}' >"
    end
    b
  end

  private

  def ranges
    sorted_ranges = {}
    open_ranges = []
    ranges = []
    ranges.push Version.define_range(0, nil, open_ranges)
    
    citations.each do |citation|
      sorted_ranges[citation.range_begin] ||= {:begin => [], :end => []}
      sorted_ranges[citation.range_begin][:begin].push citation.id
      sorted_ranges[citation.range_end] ||= {:begin => [], :end => []}
      sorted_ranges[citation.range_end][:end].push citation.id
    end
    
    sorted_ranges.sort.each do |index, hash|
      ranges.last[:end] = index
      open_ranges += hash[:begin]
      open_ranges -= hash[:end]
      ranges.push Version.define_range(index, nil, open_ranges)
    end
    ranges.reverse
  end
  
  def self.define_range start_index, end_index=nil, attributes=[]
    {
      :start => start_index,
      :end => end_index,
      :attributes => attributes
    }
  end
  
end


