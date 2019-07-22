# Code challenge for Live Mentor

## Create an extensible project that converts a json into a csv with nested headers

### This project uses three main patterns: Converters, Parsers and the Conversion object.

# Converters

The converter objects are the main object in charge of making the conversion and writing back to the output file. The converter takes ruby objects supplied by the parser and converts them into the :to format.

# Parsers

Parsers are a well known concept in CS, in this case I extracted parsing logic on a per data format basis, so that any additional logic per parsing format can be handled in seperate objects. The parses must always return ruby objects back to the caller.

# Conversion

The conversion object executes checks on the requested conversion to see if the converter exists and if the supplied input and output files exist. After validations it calls the correct parser object and passes its result to the converter.

# Extensions

In this folder the extension of existing classes is handled, some of them have methods added to assist the conversion, only add methods here specifically that can be reused outside of the conversion context. If they are truely conversion specific, the method belongs in a converter or converter assisting object.


# Adding new conversions

To add a new conversion, you need to create a new converter: The convention is: FromToTOConverter
for instance: JSONToCSVConverter.

The converter object a hash as an argument with the values needed for your conversion, the ruby objects supplied by the parser and the output file path.
If a parser is not yet present for your data format, add the parser in the parser folder that follows the correct convention: DATAFORMATParser, e.g.: JSONParser

 It should have a class method 'parse' which returns the ruby objects needed for the conversion.

