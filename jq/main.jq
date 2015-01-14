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
	| ($sumOfLengthsInArray + (($inputLength - 1) * $jointsLength)) as $combinedInputLength
	| ($combinedInputLength - $outputLength) as $difference
	| if $difference != 0 then
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

def fixJoinInput:
	map(
		if Stress::isEmpty then
			fixJoinInputReallyLongString
		else
			.
		end
	);

def fixJoinOutput:
	Stress::remove(fixJoinInputReallyLongString);

def attemptFixJoin($joints):
	. as $input
	| fixJoinInput
	| join($joints)
	| fixJoinOutput
	| . as $output
	| ($input | debugJoin($joints; $output))
	| $output;

