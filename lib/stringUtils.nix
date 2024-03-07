lib:

{
  upperCaseFirstLetter = value: (lib.toUpper (lib.substring 0 1 value)) + (lib.substring 1 (-1) value);
}
