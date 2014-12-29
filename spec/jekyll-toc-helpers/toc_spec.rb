require 'spec_helper'

describe('TOC') do
  let(:index)        { destination_file('source/index.html') }

  it 'writes the TOC out when asked' do
    toc = <<-eos
<ul>
  <li><a href="one-file">One File</a></li>
  <li><a href="two-file">Two File</a>
    <ul>
      <li><a href="one-subfile">One Subfile</a></li>
      <li><a href="two-subfile">Two Subfile</a></li>
    </ul>
  </li>
  <li><a href="three-file">Three File</a></li>
</ul>
eos

    expect(index).to match(toc)
  end
end
