# yaml-schema

A library for validating YAML documents against a schema.

## Overview

`yaml-schema` is a schema validation library that allows you to enforce type safety and structural constraints on YAML files. It works directly with an AST (which can be obtained from Psych) representation to provide strict validation without implicit type coercion.

## Usage

### Basic Validation

```ruby
require "yaml-schema"

schema = {
  "type" => "object",
  "properties" => {
    "name" => { "type" => "string" },
    "age" => { "type" => "integer" },
    "active" => { "type" => "boolean" }
  }
}

yaml_string = <<~YAML
  name: "John Doe"
  age: 30
  active: true
YAML

node = Psych.parse(yaml_string)
YAMLSchema::Validator.validate(schema, node.children.first)
```

### Supported Types

- **string** - Scalar string values
- **integer** - Numeric integers
- **boolean** - Boolean values (true/false)
- **null** - Null values
- **array** - Sequences with optional constraints
  - `items` - Schema for all array elements
  - `prefixItems` - Fixed-position tuple validation
  - `maxItems` - Maximum array length
- **object** - Mappings with properties
  - `properties` - Named properties with schemas
  - `items` - Schema for arbitrary key-value pairs
  - `tag` - Optional YAML tag requirement

### Type Unions

Specify multiple valid types for a field:

```ruby
schema = {
  "type" => "object",
  "properties" => {
    "value" => { "type" => ["null", "string"] }
  }
}
```

### Nested Objects and Arrays

```ruby
schema = {
  "type" => "object",
  "properties" => {
    "users" => {
      "type" => "array",
      "items" => {
        "type" => "object",
        "properties" => {
          "name" => { "type" => "string" },
          "tags" => {
            "type" => "array",
            "items" => { "type" => "string" }
          }
        }
      }
    }
  }
}
```

## Error Handling

Validation errors include detailed path information:

```ruby
begin
  YAMLSchema::Validator.validate(schema, node)
rescue YAMLSchema::Validator::UnexpectedType => e
  puts e.message  # e.g., "Expected integer at root -> age"
end
```

### Error Types

- `UnexpectedType` - Node doesn't match expected type
- `UnexpectedProperty` - Object has unexpected properties
- `UnexpectedTag` - YAML tag doesn't match schema
- `UnexpectedValue` - Value doesn't match constraints
- `InvalidSchema` - Schema definition is invalid
