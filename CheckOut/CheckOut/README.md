#  JSON Application Builder

## Description

This framework is intended to allow a developer to create generic views using json

### Components

`HeaderTextCell` - Header text
`InputCell` - Text Input
`SingleActionButtonCell` - Single Action Button button
`BodyTextCell` - Body text
`PaddingCell` - Padding between components
`SeparatorCell` - Adds a separator aith 16 px leading and trailing padding


### Example of usage

This is a basic, and typical example of creating a screen / program
```
{
    "screens": [
        {
        "id": "checkout",
        "title": "Experiences Checkout",
        "type": "table",
        "header_image": "",
        "header_text": "header",
        "footer_image": "",
        "footer_text": "footer",
        "top_content_inset" : "none",
        "bottom_content_inset" : "medium",
        "has_seperators": false,
        "sections" : [
        {
            "rows": [
                {
                    "type": "padding_cell",
                    "height": "medium"
                },
                {
                    "type": "header_text_cell",
                    "content": "Experiences Checkout",
                    "alignment": "center",
                    "header_type": "large_header"
                },
                {
                    "type": "padding_cell",
                    "height": "large"
                },
                {
                    "type": "separator_cell"
                }
            ]
        },
        {
            "rows": [
                {
                    "type": "header_text_cell",
                    "content": "User info",
                    "alignment": "left",
                    "header_type": "large_header"
                },
                {
                    "type": "padding_cell",
                    "height": "large"
                },
                {
                    "type": "header_text_cell",
                    "content": "First name",
                    "header_type": "normal_header"
                },
                {
                    "type": "padding_cell",
                    "height": "medium"
                },
                {
                    "type": "input_cell",
                    "input_key": "first_name",
                    "title": "Enter first name",
                    "error_title": "Enter a valid email",
                    "content": "Enter info",
                    "cell_input_type": "name",
                    "is_required": true
                },
                {
                    "type": "padding_cell",
                    "height": "medium"
                }
            ]
        }
    ]
}
```

### Components with examples

`HeaderTextCell` 
```
{
    "type": "header_text_cell",
    "content": "Experiences Checkout",
    "alignment": "center",
    "header_type": "large_header"
}
```
Variables for header types:

```
sub_header
normal_header
large_header
```

Variables for alignment:

```
center
left
right
```

`InputCell` 
```
{
    "type": "input_cell",
    "input_key": "first_name",
    "title": "Enter first name",
    "error_title": "Enter a valid email",
    "content": "Enter info",
    "cell_input_type": "name",
    "is_required": true
}
```

Explanations for Variables
`
input_key - The key used to generate JSON data i.e. "name": "john smith"
title - The title above the input field
error_title - The title beneath the input field for example "required field"
content - Currently used for placeholder
cell_input_type - Sets keyboard and data types e.g. email keyboard
is_required - Stops operations until this input field is filled
`

Variables for cellInputType:
```
normal
name
secure
```

`BodyTextCell`
```
{
    "type": "BodyTextCell",
    "content": "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    "is_bordered": true
}
```

Variables
```
is_bordered = Creates a yellow border around texts and adds 8 points of insets all around the text
```

`PaddingCell` 
```
{
    "type": "PaddingCell",
    "height": "medium"
}
```
Variables for height:
```
small
medium
large
xlarge
```
