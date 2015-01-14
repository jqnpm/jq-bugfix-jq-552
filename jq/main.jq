import "joelpurra/jq-stress" as Stress;


def sumOfLengthsInArray:
	map(length)
	| add // 0;



############### join

def fixJoinInputReallyLongString:
	"This string will be removed from the actual output.";

def debugJoinOutput($joints; $output):
	. as $input
	| length as $inputLength
	| sumOfLengthsInArray as $sumOfLengthsInArray
	| ($joints | length) as $jointsLength
	| $output
	| length as $outputLength
	| ($sumOfLengthsInArray + (([0, $inputLength - 1] | max) * $jointsLength)) as $combinedInputLength
	| ($combinedInputLength - $outputLength) as $difference
	| if $input == [] and ($output | type) == "null" then
		{
			input: $input,
			inputLength: $inputLength,
			joints: $joints,
			jointsLength: $jointsLength,
			output: $output,
			outputLength: $outputLength,
			sumOfLengthsInArray: $sumOfLengthsInArray,
			combinedInputLength: $combinedInputLength,
			difference: $difference
		}
	else
		null
	end;

def debugJoin($joints; $output):
	debugJoinOutput($joints; $output)
	| if type != "null" then
		debug
	else
		.
	end
	| null;

def warningJoin($joints):
	. as $input
	| join($joints)
	| . as $output
	| ($input | debugJoin($joints; $output))
	| $output;

def fixJoinOutput($input; $joints):
	if $input == [] and type == "null" then
		""
	else
		.
	end;

def attemptFixJoin($joints):
	. as $input
	| join($joints)
	| fixJoinOutput($input; $joints)
	| . as $output
	| ($input | debugJoin($joints; $output))
	| $output;

