# Markdown Syntax — Kitchen Sink

## HEADINGS

### ATX Style

# Heading #1

## Heading #2

### Heading #3

#### Heading #4

##### Heading #5

###### Heading #6

### SETEXT STYLE

Heading #1
==========

Heading #2
----------

## Lists

- Red
- Green
- Blue
- This
- That
  1. First
  2. Second
  3. Third
- Moar
  - Again
    - Open
    - Close

## Blockquote & Nested elements
> Blockquote: Code is poetry.
> ## This is a header
>
> 1. This is the first list item.
> 2. This is the second list item.
>
> Here's some example code:
>
>     Markdown.generate();

## Emphasis & Italics

This is **bold** and this is just *italic*.

## Diff Styles

```diff
Retained line
+ Added line
- Removed line
--- Comment
```

## Links

| `TYPE`                         |                                                                                                                     `SYNTAX` |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------------------: |
| **LINK**: Regular              |                                                                                              [Link](https://bitsandchips.me) |
| **LINK**: Alternate            |                                                                                                            [Alternate][link] |
| **IMAGE**: Regular             |                            ![Alt](https://github.com/trallard/pitaya_smoothie/blob/master/images/logos/wording.png?raw=true) |
| **IMAGE**: Regular + Title     |    ![Alt](https://github.com/trallard/pitaya_smoothie/blob/master/images/logos/wording.png?raw=true "Shades of Purple icon") |
| **IMAGE**: With Link           | [![Alt](https://github.com/trallard/pitaya_smoothie/blob/master/images/logos/wording.png?raw=true)](https://bitsandchips.me) |
| **IMAGE**: With alternate Link |                    [![Alt](https://github.com/trallard/pitaya_smoothie/blob/master/images/logos/wording.png?raw=true)][link] |

- [Link](https://bitsandchips.me)
- [Alternate][link]
- ![Alt](https://github.com/trallard/pitaya_smoothie/blob/master/images/logos/wording.png?raw=true)
- ![Alt](https://github.com/trallard/pitaya_smoothie/blob/master/images/logos/wording.png?raw=true "Shades of Purple icon")
- [![Alt](https://github.com/trallard/pitaya_smoothie/blob/master/images/logos/wording.png?raw=true)](https://bitsandchips.me)
- [![Alt](https://github.com/trallard/pitaya_smoothie/blob/master/images/logos/wording.png?raw=true)][link]

[link]: https://bitsandchips.me

[I'm an inline-style link](https://www.google.com)

[I'm an inline-style link with title](https://www.google.com "Google's Homepage")

[I'm a reference-style link][Arbitrary case-insensitive reference text]

[I'm a relative reference to a repository file](./python.py)

[You can use numbers for reference-style link definitions][1]

Or leave it empty and use the [link text itself].

Some text to show that the reference links can follow later.

[arbitrary case-insensitive reference text]: https://bitsandchips.me
[1]: https://bitsandchips.me
[link text itself]: https://bitsandchips.me
