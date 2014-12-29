jekyll-toc-variables
=======================

This gem lets adds two Liquid tags you can use in your Jekyll templates and files.

Both tags assume you have a single YAML file in your data folder that defines some kind of hierarchy for your pages. For the examples in this README, we'll be using the following YAML file:

``` yaml
- One File
- Two File:
  - One Subfile
  - Two Subfile
  - Three File

```

## The `toc` tag

The TOC tag dumps out a flat listing of the YAML file, rendered as a Markdown list.

For the example file above, using the `toc` tag like this:

``` liquid
{% toc site.data.toc %}
```

results in some HTML that looks like this:

``` html
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
```

## The `next_prev` tag

If you want to generate `Previous` and `Next` links, you can use the `next_prev` tag. It'll bring back a flat listing of the YAML file.

For the example file above, using the `next_prev` tag like this:

``` liquid
{% capture flat_links %}{% next_prev site.data.toc %}{% endcapture %}
{% assign flat_links = flat_links | split: '|' %}
<div class="pager">
  <ul>
  {% for title in flat_links %}
    {% if title == page.title %}
    {% unless forloop.first %}
      <li class="left"><a href="source/{{ prev | slugify }}">&lt; Previous</a></li>
    {% endunless %}

    {% unless forloop.last %}
      <li class="right"><a href="source/{{ flat_links[forloop.index] | slugify }}">Next &gt;</a></li>
    {% endunless %}

    {% break %}
    {% endif %}
    {% assign prev = title %}
  {% endfor %}
  </ul>
</div>
```

results in HTML that understands where the current page is, and what the next/previous links should look like. This includes nested subsections as the YAML file shows.
