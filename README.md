# Classic.sh
A library of helper files for simplifying every-day tasks in shell scripts. Each file is focused on categories of common tasks, and can be included as needed.

## File List
Classes found in Classic.php include:

* platform_processes.sh -- Provides platform-focused tasks, such as seeing if the user can sudo, or determining which GNU/Linux OS is being run.

## How to Use These Functions
All functions can be called as normal using their name: `function_name`. Functions that have parameters must be passed those parameters, like so: `function_name $argument_for_parameter_1`. Functions that have a return parameter (a parameter for getting, or returning, a value back out of the function) must be passed the name of an undefined or empty variable, so that the function can define it, like so:
```
empty_variable='';

function_name empty_variable
```
or
```
function_name new_undefined_variable
```


## Improvements
If you have any suggestions for new functionality which could reduce code duplication across many different kinds of projects, please create a new issue.