Function Find-WinGetPackage
{
	[CmdletBinding(
		SupportsShouldProcess=$True,
		ConfirmImpact="Low"
	)]
    Param
    (
        [String]$Id,
        [String]$Name,
        [String]$Moniker,
        [String]$Tag,
        [String]$Version,
        [Switch]$Versions,
        [Switch]$Exact,
        [Switch]$Details
    )

    Begin
    {
        If ($PSBoundParameters['Debug']) { $DebugPreference = 'Continue' }
    }

    Process
    {
        if($Versions -or $Version -or $Details)
        {
            $Command = "winget show --accept-source-agreements"
            if($Versions) { $Command += " --versions" }
            if($Version) { $Command += " --version $Version"}
        } else {
            $Command = "winget search --accept-source-agreements"
        }

        if($Id) { $Command += " --id $Id" }
        if($Name) { $Command += " --name $Name" }
        if($Moniker) { $Command += " --moniker $Moniker" }
        if($Tag) { $Command += " --tag $Tag" }
        if($Exact) { $Command += " --exact" }

        Write-Verbose $Command
        $Result = Invoke-Expression -Command $Command | Where-Object { $_ }
        $Result | ForEach-Object { Write-Debug $_ }

        if($Result)
        {
            Return Convert-WinGetOutput -Output $Result
        } else {
            Write-Warning "Missing result."
        }
    }

    End {}
}
# SIG # Begin signature block
# MIIuRgYJKoZIhvcNAQcCoIIuNzCCLjMCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBTKoZbNDQqv8cu
# oE300o2e5H9mCOnic+NNMlz2WZfRVaCCJngwggXJMIIEsaADAgECAhAbtY8lKt8j
# AEkoya49fu0nMA0GCSqGSIb3DQEBDAUAMH4xCzAJBgNVBAYTAlBMMSIwIAYDVQQK
# ExlVbml6ZXRvIFRlY2hub2xvZ2llcyBTLkEuMScwJQYDVQQLEx5DZXJ0dW0gQ2Vy
# dGlmaWNhdGlvbiBBdXRob3JpdHkxIjAgBgNVBAMTGUNlcnR1bSBUcnVzdGVkIE5l
# dHdvcmsgQ0EwHhcNMjEwNTMxMDY0MzA2WhcNMjkwOTE3MDY0MzA2WjCBgDELMAkG
# A1UEBhMCUEwxIjAgBgNVBAoTGVVuaXpldG8gVGVjaG5vbG9naWVzIFMuQS4xJzAl
# BgNVBAsTHkNlcnR1bSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEkMCIGA1UEAxMb
# Q2VydHVtIFRydXN0ZWQgTmV0d29yayBDQSAyMIICIjANBgkqhkiG9w0BAQEFAAOC
# Ag8AMIICCgKCAgEAvfl4+ObVgAxknYYblmRnPyI6HnUBfe/7XGeMycxca6mR5rlC
# 5SBLm9qbe7mZXdmbgEvXhEArJ9PoujC7Pgkap0mV7ytAJMKXx6fumyXvqAoAl4Va
# qp3cKcniNQfrcE1K1sGzVrihQTib0fsxf4/gX+GxPw+OFklg1waNGPmqJhCrKtPQ
# 0WeNG0a+RzDVLnLRxWPa52N5RH5LYySJhi40PylMUosqp8DikSiJucBb+R3Z5yet
# /5oCl8HGUJKbAiy9qbk0WQq/hEr/3/6zn+vZnuCYI+yma3cWKtvMrTscpIfcRnNe
# GWJoRVfkkIJCu0LW8GHgwaM9ZqNd9BjuiMmNF0UpmTJ1AjHuKSbIawLmtWJFfzcV
# WiNoidQ+3k4nsPBADLxNF8tNorMe0AZa3faTz1d1mfX6hhpneLO/lv403L3nUlbl
# s+V1e9dBkQXcXWnjlQ1DufyDljmVe2yAWk8TcsbXfSl6RLpSpCrVQUYJIP4ioLZb
# MI28iQzV13D4h1L92u+sUS4Hs07+0AnacO+Y+lbmbdu1V0vc5SwlFcieLnhO+Nqc
# noYsylfzGuXIkosagpZ6w7xQEmnYDlpGizrrJvojybawgb5CAKT41v4wLsfSRvbl
# jnX98sy50IdbzAYQYLuDNbdeZ95H7JlI8aShFf6tjGKOOVVPORa5sWOd/7cCAwEA
# AaOCAT4wggE6MA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFLahVDkCw6A/joq8
# +tT4HKbROg79MB8GA1UdIwQYMBaAFAh2zcsH/yT2xc3tu5C84oQ3RnX3MA4GA1Ud
# DwEB/wQEAwIBBjAvBgNVHR8EKDAmMCSgIqAghh5odHRwOi8vY3JsLmNlcnR1bS5w
# bC9jdG5jYS5jcmwwawYIKwYBBQUHAQEEXzBdMCgGCCsGAQUFBzABhhxodHRwOi8v
# c3ViY2Eub2NzcC1jZXJ0dW0uY29tMDEGCCsGAQUFBzAChiVodHRwOi8vcmVwb3Np
# dG9yeS5jZXJ0dW0ucGwvY3RuY2EuY2VyMDkGA1UdIAQyMDAwLgYEVR0gADAmMCQG
# CCsGAQUFBwIBFhhodHRwOi8vd3d3LmNlcnR1bS5wbC9DUFMwDQYJKoZIhvcNAQEM
# BQADggEBAFHCoVgWIhCL/IYx1MIy01z4S6Ivaj5N+KsIHu3V6PrnCA3st8YeDrJ1
# BXqxC/rXdGoABh+kzqrya33YEcARCNQOTWHFOqj6seHjmOriY/1B9ZN9DbxdkjuR
# mmW60F9MvkyNaAMQFtXx0ASKhTP5N+dbLiZpQjy6zbzUeulNndrnQ/tjUoCFBMQl
# lVXwfqefAcVbKPjgzoZwpic7Ofs4LphTZSJ1Ldf23SIikZbr3WjtP6MZl9M7JYjs
# NhI9qX7OAo0FmpKnJ25FspxihjcNpDOO16hO0EoXQ0zF8ads0h5YbBRRfopUofbv
# n3l6XYGaFpAP4bvxSgD5+d2+7arszgowggXSMIIDuqADAgECAhAh1tBKTyUPyTI3
# /KpeEo3pMA0GCSqGSIb3DQEBDQUAMIGAMQswCQYDVQQGEwJQTDEiMCAGA1UEChMZ
# VW5pemV0byBUZWNobm9sb2dpZXMgUy5BLjEnMCUGA1UECxMeQ2VydHVtIENlcnRp
# ZmljYXRpb24gQXV0aG9yaXR5MSQwIgYDVQQDExtDZXJ0dW0gVHJ1c3RlZCBOZXR3
# b3JrIENBIDIwIhgPMjAxMTEwMDYwODM5NTZaGA8yMDQ2MTAwNjA4Mzk1NlowgYAx
# CzAJBgNVBAYTAlBMMSIwIAYDVQQKExlVbml6ZXRvIFRlY2hub2xvZ2llcyBTLkEu
# MScwJQYDVQQLEx5DZXJ0dW0gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxJDAiBgNV
# BAMTG0NlcnR1bSBUcnVzdGVkIE5ldHdvcmsgQ0EgMjCCAiIwDQYJKoZIhvcNAQEB
# BQADggIPADCCAgoCggIBAL35ePjm1YAMZJ2GG5ZkZz8iOh51AX3v+1xnjMnMXGup
# kea5QuUgS5vam3u5mV3Zm4BL14RAKyfT6Lowuz4JGqdJle8rQCTCl8en7psl76gK
# AJeFWqqd3CnJ4jUH63BNStbBs1a4oUE4m9H7MX+P4F/hsT8PjhZJYNcGjRj5qiYQ
# qyrT0NFnjRtGvkcw1S5y0cVj2udjeUR+S2MkiYYuND8pTFKLKqfA4pEoibnAW/kd
# 2ecnrf+aApfBxlCSmwIsvam5NFkKv4RK/9/+s5/r2Z7gmCPspmt3FirbzK07HKSH
# 3EZzXhliaEVX5JCCQrtC1vBh4MGjPWajXfQY7ojJjRdFKZkydQIx7ikmyGsC5rVi
# RX83FVojaInUPt5OJ7DwQAy8TRfLTaKzHtAGWt32k89XdZn1+oYaZ3izv5b+NNy9
# 51JW5bPldXvXQZEF3F1p45UNQ7n8g5Y5lXtsgFpPE3LG130pekS6UqQq1UFGCSD+
# IqC2WzCNvIkM1ddw+IdS/drvrFEuB7NO/tAJ2nDvmPpW5m3btVdL3OUsJRXIni54
# TvjanJ6GLMpX8xrlyJKLGoKWesO8UBJp2A5aRos66yb6I8m2sIG+QgCk+Nb+MC7H
# 0kb25Y51/fLMudCHW8wGEGC7gzW3XmfeR+yZSPGkoRX+rYxijjlVTzkWubFjnf+3
# AgMBAAGjQjBAMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFLahVDkCw6A/joq8
# +tT4HKbROg79MA4GA1UdDwEB/wQEAwIBBjANBgkqhkiG9w0BAQ0FAAOCAgEAcaUO
# zuTpvz841YlaxAJh+0zFFBcti09TaxAX/GWExxBJkN7bxyaTiCZvcNYCXjmg94+r
# lrWlE1yBFG0OgYIRG4pOxk+l3WIeRN8JWfRbdws36YsgxvgKTi5YHOsz0M+GYMna
# +4AvnkxghHg9IWTW+0EfGA/nyXVxvb1c3jSHPkGwDva51j8JE5YUL96aHVq5Vs41
# OrBfcE1e4ynxIyhyWbarwoxmJhx3LCZ2NYsop2mg+Tv1I92FEHTJkANWkeevukfU
# EpcRIuOiSZRs57eUS7otpNozi0ymRP9aPMYdZNi1MeSmPHqoVwvb7WEay/HOc3dj
# pIdvTFE41uRfx5+2gSrkhUh5WF47+NsCgmfBOdvDdEs9Nh75KZOIaFuoRBkh8Kfo
# gQ0s6JM2tDeyyrAbJnqaJR+amoCeSyo/+6Oa/nMyccKexnLhimgn8eQPtMRMpWGT
# +JcQByowJam5yHG472jMLX714H4Pgqhvtrpsg0N3zYqSF6GeW3gWPUXiM3Ld4WbK
# mdPJxSb9DWgERq622ZuMvhm+scbyGeNcAsos2G9KB9nJNdpAdfLEpxlvnkIQmHXm
# lYtgvO3FEteKztWYXFaWA8XudwY1/8/k7j8TYe7b2i2F8M2unbIYCUXDkqFyF/xH
# tqALLPHE3kNoCGpfO/B2Y/vMBiymxuIOtbm+JI8wggaVMIIEfaADAgECAhEA8WQl
# jAm24nviDjJgjkv0qDANBgkqhkiG9w0BAQwFADBWMQswCQYDVQQGEwJQTDEhMB8G
# A1UEChMYQXNzZWNvIERhdGEgU3lzdGVtcyBTLkEuMSQwIgYDVQQDExtDZXJ0dW0g
# VGltZXN0YW1waW5nIDIwMjEgQ0EwHhcNMjEwNTE5MDU0MjQ2WhcNMzIwNTE4MDU0
# MjQ2WjBQMQswCQYDVQQGEwJQTDEhMB8GA1UECgwYQXNzZWNvIERhdGEgU3lzdGVt
# cyBTLkEuMR4wHAYDVQQDDBVDZXJ0dW0gVGltZXN0YW1wIDIwMjEwggIiMA0GCSqG
# SIb3DQEBAQUAA4ICDwAwggIKAoICAQDVYb6AAL3dhGPuEmWYHXhUi0b6xpEWGro9
# Hny+NBj26L94gmI8kONVYdu2Cz9Bftkiyvk4+3MFDrkovZZQ8WDcmGXltX4xAwPA
# cjXEbXgEZ0exEP5Ae2bkwKlTiyUXCaq0D9JEaK5t4Kq7rH7rndKd5kX7KARcMFWE
# N+ikV1cgGlKgqmJSTk0Bvbgbc67oolIhtohcEktZZFut5VJxTJ1OKsRR3FUmN+4Q
# rAk0RIv4dw2Z4sWilqbdBaBS/5hqLt58sptiORkxnijr33VnviLP2+wbWyQM5k/A
# grKj8lk6A5C8V/dShj6l/TqqRMykGAKOmi6CcvGbUDibPKkjlxlALd4mHLFujWoE
# 91GicKUKfVkLsFqplb/dPPXQjw2TCmZbAegDQlsAppndi9UUZxHvPcryyy0Eyh1y
# 4Gn7Xv1vEwnwBisZjB72My8kzUQ0gjxP26vhBkvF2Cic16nVAHxyGOPm0Y0v7lFm
# cSyYVWg1J56YZb+QAJZCL7BJ9CBSJpAXNGxcNURN0baABlZTHn3bbBPOBhOSY9vb
# GwL34nOmTFpRG5mP6HQVXc/EO9cj856a9aueDGyz2hclMIZijGEa5rwacGtPw1Hz
# WpgNAOI24ChDBRQ8YmD23IN1rmLlzCMsRZ9wFYIvNDtMJVMSQgC0+XQBFPOe69kP
# wxgPNN4CCwIDAQABo4IBYjCCAV4wDAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQUxUcS
# TnJXtkQUa4hxGhSsMbk/uggwHwYDVR0jBBgwFoAUvlQCL79AbHNDzqwJJU6eQ0Qa
# 7uAwDgYDVR0PAQH/BAQDAgeAMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMDMGA1Ud
# HwQsMCowKKAmoCSGImh0dHA6Ly9jcmwuY2VydHVtLnBsL2N0c2NhMjAyMS5jcmww
# bwYIKwYBBQUHAQEEYzBhMCgGCCsGAQUFBzABhhxodHRwOi8vc3ViY2Eub2NzcC1j
# ZXJ0dW0uY29tMDUGCCsGAQUFBzAChilodHRwOi8vcmVwb3NpdG9yeS5jZXJ0dW0u
# cGwvY3RzY2EyMDIxLmNlcjBABgNVHSAEOTA3MDUGCyqEaAGG9ncCBQELMCYwJAYI
# KwYBBQUHAgEWGGh0dHA6Ly93d3cuY2VydHVtLnBsL0NQUzANBgkqhkiG9w0BAQwF
# AAOCAgEAN3PMMLfCX4nmqnSsHU2rZhE/dkqrdSYLvI3U9i49hxs+i+9oo5mJl4ur
# PLZJ0xIz6B7CHFBNW9dFwgahnFMXiT7QnPuZ5CAwfL/9CfsAL3XdnS0AWll+7ISo
# mRo8d51bfpHHt3P3jx9C6Imh1A73JSp90Cq0NqPqnEflrVxYX+sYa2SO9vGsRMYs
# hU7uzE1V5cYWWoFUMaDHpwQuH4DNXiZO6D7f8QGWnXNHXu6S3SlaYDG4Yox7SIW1
# tQv0jskmF1vdNfoxVAymQGRdNLsGzAXn6OPAUiw1xQ6M1qpjK4UnKTUiFJfvgDXb
# T1cvrYsJrybB/41so+DsAt0yjKxbpS5iP7SpxyHsnch0VcI54sIf0K66f4LJGocB
# pDTKbU1AOq3OvHbVqI7Vwqs+TGCu7TKqrTL2NQTRDAxHkso7FtH841R2A2lvYSFD
# fGx87B1NvPWYU3mY/GRsmQx+RgA8Pl/7Nvp7ZAY+AU8mDVr2KXrFP4unpswVBQlH
# xtIOxz6jeyfdLIG2oFJll3ipcASHav/obYEt/F1GRlJ+mFIQtKDadxUBmfhRlgIg
# YvEEtuJGERHuxfMD26jLmixu8STPGRRco+R5Bdgu+qFbnymKfuXO4sR96JYqaOOx
# ilcN/xr7ms13iS7wqANpd2txKZjPy3wdWniVQcuL7yCXD2uEc20wgga5MIIEoaAD
# AgECAhEAmaOACiZVO2Wr3G6EprPqOTANBgkqhkiG9w0BAQwFADCBgDELMAkGA1UE
# BhMCUEwxIjAgBgNVBAoTGVVuaXpldG8gVGVjaG5vbG9naWVzIFMuQS4xJzAlBgNV
# BAsTHkNlcnR1bSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEkMCIGA1UEAxMbQ2Vy
# dHVtIFRydXN0ZWQgTmV0d29yayBDQSAyMB4XDTIxMDUxOTA1MzIxOFoXDTM2MDUx
# ODA1MzIxOFowVjELMAkGA1UEBhMCUEwxITAfBgNVBAoTGEFzc2VjbyBEYXRhIFN5
# c3RlbXMgUy5BLjEkMCIGA1UEAxMbQ2VydHVtIENvZGUgU2lnbmluZyAyMDIxIENB
# MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAnSPPBDAjO8FGLOczcz5j
# XXp1ur5cTbq96y34vuTmflN4mSAfgLKTvggv24/rWiVGzGxT9YEASVMw1Aj8ewTS
# 4IndU8s7VS5+djSoMcbvIKck6+hI1shsylP4JyLvmxwLHtSworV9wmjhNd627h27
# a8RdrT1PH9ud0IF+njvMk2xqbNTIPsnWtw3E7DmDoUmDQiYi/ucJ42fcHqBkbbxY
# DB7SYOouu9Tj1yHIohzuC8KNqfcYf7Z4/iZgkBJ+UFNDcc6zokZ2uJIxWgPWXMEm
# hu1gMXgv8aGUsRdaCtVD2bSlbfsq7BiqljjaCun+RJgTgFRCtsuAEw0pG9+FA+yQ
# N9n/kZtMLK+Wo837Q4QOZgYqVWQ4x6cM7/G0yswg1ElLlJj6NYKLw9EcBXE7TF3H
# ybZtYvj9lDV2nT8mFSkcSkAExzd4prHwYjUXTeZIlVXqj+eaYqoMTpMrfh5MCAOI
# G5knN4Q/JHuurfTI5XDYO962WZayx7ACFf5ydJpoEowSP07YaBiQ8nXpDkNrUA9g
# 7qf/rCkKbWpQ5boufUnq1UiYPIAHlezf4muJqxqIns/kqld6JVX8cixbd6PzkDpw
# Zo4SlADaCi2JSplKShBSND36E/ENVv8urPS0yOnpG4tIoBGxVCARPCg1BnyMJ4rB
# JAcOSnAWd18Jx5n858JSqPECAwEAAaOCAVUwggFRMA8GA1UdEwEB/wQFMAMBAf8w
# HQYDVR0OBBYEFN10XUwA23ufoHTKsW73PMAywHDNMB8GA1UdIwQYMBaAFLahVDkC
# w6A/joq8+tT4HKbROg79MA4GA1UdDwEB/wQEAwIBBjATBgNVHSUEDDAKBggrBgEF
# BQcDAzAwBgNVHR8EKTAnMCWgI6Ahhh9odHRwOi8vY3JsLmNlcnR1bS5wbC9jdG5j
# YTIuY3JsMGwGCCsGAQUFBwEBBGAwXjAoBggrBgEFBQcwAYYcaHR0cDovL3N1YmNh
# Lm9jc3AtY2VydHVtLmNvbTAyBggrBgEFBQcwAoYmaHR0cDovL3JlcG9zaXRvcnku
# Y2VydHVtLnBsL2N0bmNhMi5jZXIwOQYDVR0gBDIwMDAuBgRVHSAAMCYwJAYIKwYB
# BQUHAgEWGGh0dHA6Ly93d3cuY2VydHVtLnBsL0NQUzANBgkqhkiG9w0BAQwFAAOC
# AgEAdYhYD+WPUCiaU58Q7EP89DttyZqGYn2XRDhJkL6P+/T0IPZyxfxiXumYlARM
# gwRzLRUStJl490L94C9LGF3vjzzH8Jq3iR74BRlkO18J3zIdmCKQa5LyZ48IfICJ
# TZVJeChDUyuQy6rGDxLUUAsO0eqeLNhLVsgw6/zOfImNlARKn1FP7o0fTbj8ipNG
# xHBIutiRsWrhWM2f8pXdd3x2mbJCKKtl2s42g9KUJHEIiLni9ByoqIUul4GblLQi
# gO0ugh7bWRLDm0CdY9rNLqyA3ahe8WlxVWkxyrQLjH8ItI17RdySaYayX3PhRSC4
# Am1/7mATwZWwSD+B7eMcZNhpn8zJ+6MTyE6YoEBSRVrs0zFFIHUR08Wk0ikSf+lI
# e5Iv6RY3/bFAEloMU+vUBfSouCReZwSLo8WdrDlPXtR0gicDnytO7eZ5827NS2x7
# gCBibESYkOh1/w1tVxTpV2Na3PR7nxYVlPu1JPoRZCbH86gc96UTvuWiOruWmyOE
# MLOGGniR+x+zPF/2DaGgK2W1eEJfo2qyrBNPvF7wuAyQfiFXLwvWHamoYtPZo0LH
# uH8X3n9C+xN4YaNjt2ywzOr+tKyEVAotnyU9vyEVOaIYMk3IeBrmFnn0gbKeTTyY
# eEEUz/Qwt4HOUBCrW602NCmvO1nm+/80nLy5r0AZvCQxaQ4wgga5MIIEoaADAgEC
# AhEA5/9pxzs1zkuRJth0fGilhzANBgkqhkiG9w0BAQwFADCBgDELMAkGA1UEBhMC
# UEwxIjAgBgNVBAoTGVVuaXpldG8gVGVjaG5vbG9naWVzIFMuQS4xJzAlBgNVBAsT
# HkNlcnR1bSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEkMCIGA1UEAxMbQ2VydHVt
# IFRydXN0ZWQgTmV0d29yayBDQSAyMB4XDTIxMDUxOTA1MzIwN1oXDTM2MDUxODA1
# MzIwN1owVjELMAkGA1UEBhMCUEwxITAfBgNVBAoTGEFzc2VjbyBEYXRhIFN5c3Rl
# bXMgUy5BLjEkMCIGA1UEAxMbQ2VydHVtIFRpbWVzdGFtcGluZyAyMDIxIENBMIIC
# IjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA6RIfBDXtuV16xaaVQb6KZX9O
# d9FtJXXTZo7b+GEof3+3g0ChWiKnO7R4+6MfrvLyLCWZa6GpFHjEt4t0/GiUQvnk
# LOBRdBqr5DOvlmTvJJs2X8ZmWgWJjC7PBZLYBWAs8sJl3kNXxBMX5XntjqWx1ZOu
# uXl0R4x+zGGSMzZ45dpvB8vLpQfZkfMC/1tL9KYyjU+htLH68dZJPtzhqLBVG+8l
# jZ1ZFilOKksS79epCeqFSeAUm2eMTGpOiS3gfLM6yvb8Bg6bxg5yglDGC9zbr4sB
# 9ceIGRtCQF1N8dqTgM/dSViiUgJkcv5dLNJeWxGCqJYPgzKlYZTgDXfGIeZpEFmj
# BLwURP5ABsyKoFocMzdjrCiFbTvJn+bD1kq78qZUgAQGGtd6zGJ88H4NPJ5Y2R4I
# argiWAmv8RyvWnHr/VA+2PrrK9eXe5q7M88YRdSTq9TKbqdnITUgZcjjm4ZUjteq
# 8K331a4P0s2in0p3UubMEYa/G5w6jSWPUzchGLwWKYBfeSu6dIOC4LkeAPvmdZxS
# B1lWOb9HzVWZoM8Q/blaP4LWt6JxjkI9yQsYGMdCqwl7uMnPUIlcExS1mzXRxUow
# Qref/EPaS7kYVaHHQrp4XB7nTEtQhkP0Z9Puz/n8zIFnUSnxDof4Yy650PAXSYmK
# 2TcbyDoTNmmt8xAxzcMCAwEAAaOCAVUwggFRMA8GA1UdEwEB/wQFMAMBAf8wHQYD
# VR0OBBYEFL5UAi+/QGxzQ86sCSVOnkNEGu7gMB8GA1UdIwQYMBaAFLahVDkCw6A/
# joq8+tT4HKbROg79MA4GA1UdDwEB/wQEAwIBBjATBgNVHSUEDDAKBggrBgEFBQcD
# CDAwBgNVHR8EKTAnMCWgI6Ahhh9odHRwOi8vY3JsLmNlcnR1bS5wbC9jdG5jYTIu
# Y3JsMGwGCCsGAQUFBwEBBGAwXjAoBggrBgEFBQcwAYYcaHR0cDovL3N1YmNhLm9j
# c3AtY2VydHVtLmNvbTAyBggrBgEFBQcwAoYmaHR0cDovL3JlcG9zaXRvcnkuY2Vy
# dHVtLnBsL2N0bmNhMi5jZXIwOQYDVR0gBDIwMDAuBgRVHSAAMCYwJAYIKwYBBQUH
# AgEWGGh0dHA6Ly93d3cuY2VydHVtLnBsL0NQUzANBgkqhkiG9w0BAQwFAAOCAgEA
# uJNZd8lMFf2UBwigp3qgLPBBk58BFCS3Q6aJDf3TISoytK0eal/JyCB88aUEd0wM
# NiEcNVMbK9j5Yht2whaknUE1G32k6uld7wcxHmw67vUBY6pSp8QhdodY4SzRRaZW
# zyYlviUpyU4dXyhKhHSncYJfa1U75cXxCe3sTp9uTBm3f8Bj8LkpjMUSVTtMJ6oE
# u5JqCYzRfc6nnoRUgwz/GVZFoOBGdrSEtDN7mZgcka/tS5MI47fALVvN5lZ2U8k7
# Dm/hTX8CWOw0uBZloZEW4HB0Xra3qE4qzzq/6M8gyoU/DE0k3+i7bYOrOk/7tPJg
# 1sOhytOGUQ30PbG++0FfJioDuOFhj99b151SqFlSaRQYz74y/P2XJP+cF19oqozm
# i0rRTkfyEJIvhIZ+M5XIFZttmVQgTxfpfJwMFFEoQrSrklOxpmSygppsUDJEoliC
# 05vBLVQ+gMZyYaKvBJ4YxBMlKH5ZHkRdloRYlUDplk8GUa+OCMVhpDSQurU6K1ua
# 5dmZftnvSSz2H96UrQDzA6DyiI1V3ejVtvn2azVAXg6NnjmuRZ+wa7Pxy0H3+V4K
# 4rOTHlG3VYA6xfLsTunCz72T6Ot4+tkrDYOeaU1pPX1CBfYj6EW2+ELq46GP8KCN
# UQDirWLU4nOmgCat7vN0SD6RlwUiSsMeCiQDmZwgwrUwgga+MIIEpqADAgECAhA5
# piUJ4k/JmjlFQcc2aEk4MA0GCSqGSIb3DQEBCwUAMFYxCzAJBgNVBAYTAlBMMSEw
# HwYDVQQKExhBc3NlY28gRGF0YSBTeXN0ZW1zIFMuQS4xJDAiBgNVBAMTG0NlcnR1
# bSBDb2RlIFNpZ25pbmcgMjAyMSBDQTAeFw0yMTEwMjUxMTMzMzZaFw0yMjEwMjUx
# MTMzMzVaMGQxCzAJBgNVBAYTAlBMMREwDwYDVQQHDAhSemVzesOzdzEgMB4GA1UE
# CgwXQXNzZWNvIENsb3VkIFNwLiB6IG8uby4xIDAeBgNVBAMMF0Fzc2VjbyBDbG91
# ZCBTcC4geiBvLm8uMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA4uKc
# jNbpLrP17wEEbPxxhLKWJclQQrCWDXOik2o7bThRLnxqNgiAH9+G/zC6IAlABOUR
# 0LbfXeF+dUupsHqIGaX3yLgiWN42wHw4TSe8wQNOOUmd+S08AMfsIaVj9g1O7sz1
# kuYEnaejvzC//LZ1KFMaZmNbi32tXkfGrc/loJXMyCCtLJUoZTz4ufzYTDYqfAdd
# OkB+A6rE1sdnuz7FfJhEKMNYh3m1vauH++pr8FZjnZoMP40oS98euZkW1WMWFc8A
# gs3DbrUvuEcnrSWMnnqcPn0Cm660JIeyquJFsG1VAxI2YS2xwRkJWedrs9gXBfi7
# Al5ql9Z87nOe9UHSEcRDLkNbMhO7IIzI7G0E7mwrh+CUPH9Pm1wLjnFJf0hmo5Pq
# vsbMBD7VH5eyt17T+oeA2Th6gvP02Pzh+nlo72Oc2fiSzR1q0lJBRdhZaPzFoe9T
# gHCP5yhkgiwc1vLEAHjxbzSMZ4B6i4KmxaUh4/rXXzM5mvPcWJybjLe8U2uyxNZr
# jFy+JRiAcrwOtFtw/p3OOBkeNPD1T7rGVl+oJkpK7caACMkDYzj7qjS7wVKFVjql
# qgUyH855cWnFmhtLPK9OsN/5F7/2XbAb0W8X0ti8Z+eedFIr+olWrHOYEnN6ObH/
# 0NZy4D3ynb0wYskn9F6I3hR+lxJ+1tUCgM0Bka0CAwEAAaOCAXgwggF0MAwGA1Ud
# EwEB/wQCMAAwPQYDVR0fBDYwNDAyoDCgLoYsaHR0cDovL2Njc2NhMjAyMS5jcmwu
# Y2VydHVtLnBsL2Njc2NhMjAyMS5jcmwwcwYIKwYBBQUHAQEEZzBlMCwGCCsGAQUF
# BzABhiBodHRwOi8vY2NzY2EyMDIxLm9jc3AtY2VydHVtLmNvbTA1BggrBgEFBQcw
# AoYpaHR0cDovL3JlcG9zaXRvcnkuY2VydHVtLnBsL2Njc2NhMjAyMS5jZXIwHwYD
# VR0jBBgwFoAU3XRdTADbe5+gdMqxbvc8wDLAcM0wHQYDVR0OBBYEFBmXjaWjwiob
# PqZ4e8YyJAnf5CFcMEsGA1UdIAREMEIwCAYGZ4EMAQQBMDYGCyqEaAGG9ncCBQEE
# MCcwJQYIKwYBBQUHAgEWGWh0dHBzOi8vd3d3LmNlcnR1bS5wbC9DUFMwEwYDVR0l
# BAwwCgYIKwYBBQUHAwMwDgYDVR0PAQH/BAQDAgeAMA0GCSqGSIb3DQEBCwUAA4IC
# AQAwjG28WPmv78mxh8qa6U2MfrnAa70g9I5VPSmbtZl41zmX7IIaWm6gzG2Iy82D
# D4KRuKrxed1vI7LcKZutPtoheX/zZiBRCxKUTlxMXj8ySoG1pXkrAzj6+LjVR0og
# /pdFD3A6b+N78asvDRwCwCBwN5uYXhvdC52nmnD/brl4NOZcZ34XVctGXSxcoJfa
# DTpWM9DqIM2nuM7xhvt5p+qtfApUbFXHxbt6cMna6g4H+Ckp5AFVhbrroFyCr4+e
# 6p6Dap3/9ldbr2DbqLgoiLw/4l6UzHk4JEa7j/TpPA2ke0BtOfpIz77lECVaLTyW
# 4cDR0+HG0aVEuWpfAUOdUMXds7MYBz5MkjnBxvZf/LidOTEHikgyBHF0ScX6Zkjw
# zRK1sYQTMZHutZrjzq2rCLfDYYzlPbCzoiQSKWIizM75tQm9APr2aX6HIhES7RWR
# UXV+Si4ye92lZRF003TsNfvxcPv2VXhjdyuC15E8AD4ngh+iwp35tv1VDQnwkQs8
# /NdfYLS1a8q/pOCs7oJ/nNGq/FM6XGKbg7VQrU6/Lz+JNBGR0TdTmolUCwjTusbZ
# +G3L4+iL8DyFMlpUv7TzsiVjRcyl+2jRegfgGeHuWS5m7Zl6UHw6yjio+/BLHbeS
# bVle31B3SuGZ7JeKNL7wiGFSa02EnAfeJwlyQ6L6T6BvxTGCByQwggcgAgEBMGow
# VjELMAkGA1UEBhMCUEwxITAfBgNVBAoTGEFzc2VjbyBEYXRhIFN5c3RlbXMgUy5B
# LjEkMCIGA1UEAxMbQ2VydHVtIENvZGUgU2lnbmluZyAyMDIxIENBAhA5piUJ4k/J
# mjlFQcc2aEk4MA0GCWCGSAFlAwQCAQUAoIGEMBgGCisGAQQBgjcCAQwxCjAIoAKA
# AKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIFh4xpNKxykUeNiB16KeJCcL
# wHBdS2hZiwKVHn/O9FJjMA0GCSqGSIb3DQEBAQUABIICABOOc4Ys5tgPO3pqkOy3
# ntvCnb6vKYUjfYCm08SMY4FZYGSWPzaMGyYfLcedBq9pcCxwqBstLW+pnia9/JIn
# +dnF+lRaEp4bwGQyvWrCZ4QwAET++DMwVR4ZfUX7knHjY+0CP7ZbAAbmhHuMrn9O
# bclE4VNgDOoaKhEEvj2k1khL6lH5V6HdAyrotXPLdldczyEJva6pXGYLtgHVtL5p
# BG8174Ew16TXys6xQh1Csfc99hkfLIRa4l9u0TxB+XYjVQafyFua5iFk49ggWOSC
# MFju5CXq0cVKuaa9PULgvMBXPSlCjRnxq7pGCRw0Oz6nqq7Fm8Did7GvnnWTTZnY
# kPHyFy1QE4yIHbjM/4C4GKKCjF08emJg3bMd4o4xJ11DJDD2exEhuPCS7Yy/t8e2
# pXdbj5rq320tr9iR/MrppZiWV+l6nhkeV8YnenPpAcrJBpo/ginO/MFEPfDDL0yR
# +4XOkkOlBmU8W+jWzDSN0vghLXDlM9Ekg3dFe3xsk+s3ibvYTseF6jSQYjB9czVT
# MuQfyqtdh0J3AmtzujCK7RTmW3zv2qz7pgojAUeRlnTGjSnopCge1BTert33C+Dz
# glfBVg3ny2F+cL2cH9WH1/bkawTi7ASVUCOx0Yxs/hOkpPCy/zFiPJKDtXUP81te
# RBED9oRzc6Hpqp+k9PzgakN+oYIEBDCCBAAGCSqGSIb3DQEJBjGCA/EwggPtAgEB
# MGswVjELMAkGA1UEBhMCUEwxITAfBgNVBAoTGEFzc2VjbyBEYXRhIFN5c3RlbXMg
# Uy5BLjEkMCIGA1UEAxMbQ2VydHVtIFRpbWVzdGFtcGluZyAyMDIxIENBAhEA8WQl
# jAm24nviDjJgjkv0qDANBglghkgBZQMEAgIFAKCCAVcwGgYJKoZIhvcNAQkDMQ0G
# CyqGSIb3DQEJEAEEMBwGCSqGSIb3DQEJBTEPFw0yMjA3MjEwOTQ3NTZaMDcGCyqG
# SIb3DQEJEAIvMSgwJjAkMCIEIBtZv+jldyus9kO7eay0joFYeE8hxVSuE0dtOho+
# BcXTMD8GCSqGSIb3DQEJBDEyBDByy4q5i+9ivVpJLffbGsWrNoFo3tlrGG+qOC0s
# KanzsChpF5rAoHr8o8VXEKwqhggwgaAGCyqGSIb3DQEJEAIMMYGQMIGNMIGKMIGH
# BBTTEcaVMRuM5z/VtVMYrN9ZiuGbEzBvMFqkWDBWMQswCQYDVQQGEwJQTDEhMB8G
# A1UEChMYQXNzZWNvIERhdGEgU3lzdGVtcyBTLkEuMSQwIgYDVQQDExtDZXJ0dW0g
# VGltZXN0YW1waW5nIDIwMjEgQ0ECEQDxZCWMCbbie+IOMmCOS/SoMA0GCSqGSIb3
# DQEBAQUABIICACUYO0+3AfE8jBwZbpUpyacl2S1gNpkQTSrj/Rf41vWTtQn9PyuT
# 5FHOE8qkzR95Twgn3mJpZ16xbQPBah/+lVpb6FjBbcErmN1zFhXMiJldidRFqAYA
# qYx9qGLl4SveJGV9iNAdHLg7XyIK+mVkCH/O5XFtrbms52Bq4q9eXq8EflHlkorp
# JxCkjfdOlj1T2cbf3W8XUBBVdXdZ6UDgPSdTbQSo74s0tf2rM+uO7ZoYlagv5NDZ
# W165hiebWlqXx+5MVn4M07esaPMxFpz6pRFyJIJhi2yFIEggSPx2hJqR58ZgBEHp
# Xv6LeAbSdDVZtj1R1USKGm/kgQK6kXla/w5q/OmN7hS59ibRpIl1lGRp8XKfw/jX
# yXnEyYaEKU7ggvtVHzuyZ7LEHqowPKczFHb5i/YBbLhTXuebrezMlhDTLvgLxNE1
# q2ZAFtHMKBmfR+NQkUj3GWNgx0dkg7OrexJOBdSmq2qCUircjjINByIoFiEgRiZm
# AKx6PEwd79T3zvldyVXzSlvrqrX+IGH6EIiWe04HrVx1b2y5/OSTH+g2nGJ/MfE5
# lv0mRH3OIqzx7+z7JOBA4A4myjJh7gJPbmp9j3LgK+jASzKR5p99Nk1T1B89brh7
# Tk7lG4UmwTeI96FrtoM7sJTXkrynax6yv8D6s/8mmjEOopUO0f8cyw0t
# SIG # End signature block
