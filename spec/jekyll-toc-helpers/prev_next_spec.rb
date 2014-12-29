require 'spec_helper'
require 'nokogiri'

describe('PrevNext') do
  let(:file1)        { destination_file('source/file1.html') }
  let(:file2)        { destination_file('source/file2.html') }
  let(:subfile1)     { destination_file('source/subfile1.html') }
  let(:subfile2)     { destination_file('source/subfile2.html') }
  let(:file3)        { destination_file('source/file3.html') }

  it 'writes the default frontmatter using a variable' do
    file1_doc = Nokogiri::HTML(file1)
    expect(0).to equal(file1_doc.css('.left').size)
    expect(1).to equal(file1_doc.css('.right').size)
    expect('source/two-file').to eq(file1_doc.css('.right a').attr('href').text)

    file2_doc = Nokogiri::HTML(file2)
    expect(1).to equal(file2_doc.css('.left').size)
    expect(1).to equal(file2_doc.css('.right').size)
    expect('source/one-file').to eq(file2_doc.css('.left a').attr('href').text)
    expect('source/one-subfile').to eq(file2_doc.css('.right a').attr('href').text)

    file3_doc = Nokogiri::HTML(file3)
    expect(1).to equal(file3_doc.css('.left').size)
    expect(0).to equal(file3_doc.css('.right').size)
    expect('source/two-subfile').to eq(file3_doc.css('.left a').attr('href').text)
  end
end
