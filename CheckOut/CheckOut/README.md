#  JSON View configuration

## Description

This framework is intended to allow a developer to create generic views using json

### Components

`HeaderCell` - Header text
`SubheaderCell` - Sub header text
`InputCell` - Text Input
`SingleActionButtonCell` - Single Action Button button
`BodyTextCell` - Body text
`PaddingCell` - Padding between components


### Example of usage

This is a basic, and typical example of creating a component
```
{
    "content": "Experiences Checkout",
    "header": "header",
    "footer": "footer",
    "items" : [
        {
            "type": "PaddingCell",
            "height": "medium"
        },
        {
            "type": "HeaderTextCell",
            "content": "Experiences Checkout",
            "alignment": "center"
        },
        {
            "type": "PaddingCell",
            "height": "medium"
        }
    ]
}
```

### Components with examples

`HeaderCell` 
```
{
    "type": "HeaderTextCell",
    "content": "Experiences Checkout",
    "alignment": "center"
}
```
Variables for alignment:

```
center
left
right
```

`SubheaderCell` 
```
{
    "type": "SubHeaderTextCell",
    "content": "First name"
}
```
`InputCell` 
```
{
    "type": "InputCell",
    "cellInputType": "normal",
    "content": "Enter info"
}
```

Variables for cellInputType:
```
normal
secure
```

`BodyTextCell`
```
{
    "type": "BodyTextCell",
    "content": "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
}
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
