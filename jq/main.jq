import "joelpurra/jq-stress" as Stress;


def sumOfLengthsInArray:
	map(length)
	| add // 0;



############### split

def debugSplitOutput($splitter; $output):
	. as $input
	| length as $inputLength
	| ($splitter | length) as $splitterLength
	| $output
	| length as $outputLength
	| sumOfLengthsInArray as $sumOfLengthsInArray
	| ($sumOfLengthsInArray + (($outputLength - 1) * $splitterLength)) as $combinedOutputLength
	| ($combinedOutputLength - $inputLength) as $difference
	# List all detectable inconsistency indicators here.
	| if ($splitter | Stress::isEmpty) and $outputLength == 2 then
		{
			input: $input,
			inputLength: $inputLength,
			splitter: $splitter,
			splitterLength: $splitterLength,
			output: $output,
			outputLength: $outputLength,
			sumOfLengthsInArray: $sumOfLengthsInArray,
			combinedOutputLength: $combinedOutputLength,
			difference: $difference
		}
	else
		null
	end;

def debugSplit($splitter; $output):
	debugSplitOutput($splitter; $output)
	| if type != "null" then
		debug
	else
		.
	end
	| null;

def warningSplit($splitter):
	. as $input
	| split($splitter)
	| . as $output
	| ($input | debugSplit($splitter; $output)) as $debugged
	| $output;

def fixSplitOutput($debugged):
	. as $originalOutput
	# One if-case per fix.
	| if ($debugged.splitter | Stress::isEmpty) and $debugged.outputLength == 2 then
		$originalOutput[0:1]
	else
		$originalOutput
	end;

def attemptFixSplit($splitter):
	. as $input
	| split($splitter)
	| . as $originalOutput
	| ($input | debugSplitOutput($splitter; $originalOutput)) as $originalDebugged
	| fixSplitOutput($originalDebugged)
	| . as $output
	| ($input | debugSplit($splitter; $output)) as $debugged
	| $output;



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

