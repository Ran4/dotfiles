#base sourceschemebase.res
Scheme {
	Fonts {
		"DefaultSmall"	// server browser
		{
			"1"
			{
				"name"		"Tahoma" [!$POSIX]
				"name"		"Verdana" [$POSIX]
				"tall"		"18" [!$POSIX]	// default 12
				"tall"		"19" [$POSIX]	// default 13
				"weight"	"0"
			}
		}
		"ConsoleText"	// console
		{
			"1"
			{
				"name"		 "Lucida Console" [$WINDOWS]
				"name"		 "Lucida Console" [$X360]
				"name"		 "Verdana" [$POSIX]
				"tall"		"15" [$OSX] 	// default 11
				"tall"		"16" [$LINUX] 	// default 14
				"tall"		"12" 			// default 10
				"weight"	"500"
			}
		}
	}
}
