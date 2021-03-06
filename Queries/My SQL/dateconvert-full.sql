/****** Object:  StoredProcedure [dbo].[PDateConvert_Christian2Hebrew]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Christian2Hebrew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Christian2Hebrew]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Hebrew2Christian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Hebrew2Christian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Hebrew2Christian]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Hebrew2Islamic]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Hebrew2Islamic]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Hebrew2Islamic]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Hebrew2Julian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Hebrew2Julian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Hebrew2Julian]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Hebrew2Persian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Hebrew2Persian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Hebrew2Persian]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Islamic2Hebrew]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Islamic2Hebrew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Islamic2Hebrew]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Julian2Hebrew]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Julian2Hebrew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Julian2Hebrew]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Persian2Hebrew]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Persian2Hebrew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Persian2Hebrew]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Hebrew2Christian]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Hebrew2Christian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Hebrew2Christian]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Hebrew2Islamic]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Hebrew2Islamic]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Hebrew2Islamic]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Hebrew2Julian]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Hebrew2Julian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Hebrew2Julian]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Hebrew2Persian]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Hebrew2Persian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Hebrew2Persian]
GO
/****** Object:  StoredProcedure [dbo].[persian_hebrew]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[persian_hebrew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[persian_hebrew]
GO
/****** Object:  StoredProcedure [dbo].[civil_hebrew]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_hebrew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[civil_hebrew]
GO
/****** Object:  StoredProcedure [dbo].[hebrew_civil]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hebrew_civil]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[hebrew_civil]
GO
/****** Object:  StoredProcedure [dbo].[hebrew_islamic]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hebrew_islamic]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[hebrew_islamic]
GO
/****** Object:  StoredProcedure [dbo].[hebrew_julian]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hebrew_julian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[hebrew_julian]
GO
/****** Object:  StoredProcedure [dbo].[hebrew_persian]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hebrew_persian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[hebrew_persian]
GO
/****** Object:  StoredProcedure [dbo].[islamic_hebrew]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[islamic_hebrew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[islamic_hebrew]
GO
/****** Object:  StoredProcedure [dbo].[julian_hebrew]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[julian_hebrew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[julian_hebrew]
GO
/****** Object:  StoredProcedure [dbo].[jdn_hebrew]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[jdn_hebrew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[jdn_hebrew]
GO
/****** Object:  UserDefinedFunction [dbo].[hebrew_jdn]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hebrew_jdn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[hebrew_jdn]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Christian2Islamic]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Christian2Islamic]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Christian2Islamic]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Christian2Hebrew]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Christian2Hebrew]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Christian2Hebrew]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Islamic2Hebrew]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Islamic2Hebrew]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Islamic2Hebrew]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Julian2Hebrew]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Julian2Hebrew]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Julian2Hebrew]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Persian2Islamic]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Persian2Islamic]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Persian2Islamic]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Julian2Islamic]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Julian2Islamic]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Julian2Islamic]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Persian2Hebrew]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Persian2Hebrew]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Persian2Hebrew]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Julian2Persian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Julian2Persian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Julian2Persian]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Persian2Christian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Persian2Christian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Persian2Christian]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Islamic2Julian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Islamic2Julian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Islamic2Julian]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Islamic2Persian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Islamic2Persian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Islamic2Persian]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Julian2Christian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Julian2Christian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Julian2Christian]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Christian2Julian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Christian2Julian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Christian2Julian]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Christian2Persian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Christian2Persian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Christian2Persian]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Islamic2Christian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Islamic2Christian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Islamic2Christian]
GO
/****** Object:  StoredProcedure [dbo].[persian_islamic]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[persian_islamic]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[persian_islamic]
GO
/****** Object:  StoredProcedure [dbo].[civil_islamic]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_islamic]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[civil_islamic]
GO
/****** Object:  StoredProcedure [dbo].[julian_islamic]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[julian_islamic]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[julian_islamic]
GO
/****** Object:  UserDefinedFunction [dbo].[Hebrew_LastDayOfMonth]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hebrew_LastDayOfMonth]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Hebrew_LastDayOfMonth]
GO
/****** Object:  UserDefinedFunction [dbo].[Hebrew_ShortKislev]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hebrew_ShortKislev]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Hebrew_ShortKislev]
GO
/****** Object:  StoredProcedure [dbo].[islamic_civil]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[islamic_civil]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[islamic_civil]
GO
/****** Object:  UserDefinedFunction [dbo].[Hebrew_LongHeshvan]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hebrew_LongHeshvan]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Hebrew_LongHeshvan]
GO
/****** Object:  StoredProcedure [dbo].[islamic_julian]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[islamic_julian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[islamic_julian]
GO
/****** Object:  StoredProcedure [dbo].[islamic_persian]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[islamic_persian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[islamic_persian]
GO
/****** Object:  StoredProcedure [dbo].[jdn_islamic]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[jdn_islamic]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[jdn_islamic]
GO
/****** Object:  StoredProcedure [dbo].[civil_julian]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_julian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[civil_julian]
GO
/****** Object:  StoredProcedure [dbo].[civil_normDate]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_normDate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[civil_normDate]
GO
/****** Object:  StoredProcedure [dbo].[civil_persian]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_persian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[civil_persian]
GO
/****** Object:  UserDefinedFunction [dbo].[civil_weekNumber]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_weekNumber]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[civil_weekNumber]
GO
/****** Object:  StoredProcedure [dbo].[julian_persian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[julian_persian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[julian_persian]
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Persian2Julian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Persian2Julian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PDateConvert_Persian2Julian]
GO
/****** Object:  StoredProcedure [dbo].[persian_civil]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[persian_civil]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[persian_civil]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Islamic2Julian]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Islamic2Julian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Islamic2Julian]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Islamic2Persian]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Islamic2Persian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Islamic2Persian]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Christian2Islamic]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Christian2Islamic]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Christian2Islamic]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Christian2Julian]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Christian2Julian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Christian2Julian]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Christian2Persian]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Christian2Persian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Christian2Persian]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Islamic2Christian]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Islamic2Christian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Islamic2Christian]
GO
/****** Object:  StoredProcedure [dbo].[julian_civil]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[julian_civil]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[julian_civil]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Persian2Islamic]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Persian2Islamic]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Persian2Islamic]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Persian2Julian]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Persian2Julian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Persian2Julian]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Julian2Christian]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Julian2Christian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Julian2Christian]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Julian2Islamic]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Julian2Islamic]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Julian2Islamic]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Julian2Persian]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Julian2Persian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Julian2Persian]
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Persian2Christian]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Persian2Christian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UDateConvert_Persian2Christian]
GO
/****** Object:  StoredProcedure [dbo].[persian_julian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[persian_julian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[persian_julian]
GO
/****** Object:  StoredProcedure [dbo].[jdn_persian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[jdn_persian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[jdn_persian]
GO
/****** Object:  UserDefinedFunction [dbo].[civil_jdn]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_jdn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[civil_jdn]
GO
/****** Object:  UserDefinedFunction [dbo].[Hebrew_DaysInYear]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hebrew_DaysInYear]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Hebrew_DaysInYear]
GO
/****** Object:  StoredProcedure [dbo].[jdn_civil]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[jdn_civil]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[jdn_civil]
GO
/****** Object:  UserDefinedFunction [dbo].[civil_daysInMonth]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_daysInMonth]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[civil_daysInMonth]
GO
/****** Object:  UserDefinedFunction [dbo].[islamic_jdn]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[islamic_jdn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[islamic_jdn]
GO
/****** Object:  UserDefinedFunction [dbo].[islamic_daysInMonth]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[islamic_daysInMonth]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[islamic_daysInMonth]
GO
/****** Object:  UserDefinedFunction [dbo].[julian_jdn]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[julian_jdn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[julian_jdn]
GO
/****** Object:  StoredProcedure [dbo].[jdn_julian]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[jdn_julian]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[jdn_julian]
GO
/****** Object:  UserDefinedFunction [dbo].[Hebrew_ElapsedCalendarDays]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hebrew_ElapsedCalendarDays]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Hebrew_ElapsedCalendarDays]
GO
/****** Object:  UserDefinedFunction [dbo].[civil_leapyear]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_leapyear]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[civil_leapyear]
GO
/****** Object:  UserDefinedFunction [dbo].[persian_jdn]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[persian_jdn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[persian_jdn]
GO
/****** Object:  UserDefinedFunction [dbo].[visibility]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[visibility]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[visibility]
GO
/****** Object:  UserDefinedFunction [dbo].[Xor]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Xor]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Xor]
GO
/****** Object:  UserDefinedFunction [dbo].[leap_islamic]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[leap_islamic]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[leap_islamic]
GO
/****** Object:  UserDefinedFunction [dbo].[leap_persian]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[leap_persian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[leap_persian]
GO
/****** Object:  UserDefinedFunction [dbo].[tmoonphase]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmoonphase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[tmoonphase]
GO
/****** Object:  UserDefinedFunction [dbo].[Ceil]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ceil]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Ceil]
GO
/****** Object:  StoredProcedure [dbo].[DateConvert_readDate]    Script Date: 08/16/2010 21:15:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateConvert_readDate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DateConvert_readDate]
GO
/****** Object:  UserDefinedFunction [dbo].[dayOfWeek]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dayOfWeek]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[dayOfWeek]
GO
/****** Object:  UserDefinedFunction [dbo].[Fix]    Script Date: 08/16/2010 21:15:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Fix]
GO
/****** Object:  UserDefinedFunction [dbo].[Hebrew_LeapYear]    Script Date: 08/16/2010 21:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hebrew_LeapYear]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Hebrew_LeapYear]
GO
/****** Object:  UserDefinedFunction [dbo].[Hebrew_LeapYear]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hebrew_LeapYear]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[Hebrew_LeapYear](@Year INT) RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT
	
	SET @Result = 0
	
    If ((((7 * @Year) + 1) % 19) < 7)
       SET @Result = 1
    
    RETURN @Result
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[Fix]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fix]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[Fix](@x FLOAT(53))
RETURNS BIGINT
AS
BEGIN
	DECLARE @Result BIGINT

	IF @x >= 0
		SET @Result = FLOOR(@x)
	ELSE
		SET @Result = CEILING(@x)
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[dayOfWeek]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dayOfWeek]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[dayOfWeek](@jdn AS INT,@Style AS INT = -1) RETURNS INT
AS
BEGIN
	DECLARE @ISO_8601 AS TINYINT
	SET @ISO_8601 = 1
	
	IF @Style = -1
		SET @Style = @ISO_8601
	
    RETURN ((@jdn + @Style - 1) % 7) + 1
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[DateConvert_readDate]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateConvert_readDate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[DateConvert_readDate](@Date VARCHAR(10),@Year INT OUT,@Month INT OUT,@Day INT OUT,@Separator CHAR(1) = ''/'') AS
BEGIN
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @Year = CAST(@temp AS INT)
		ELSE
			SET @Year = 0
	END
	ELSE
		SET @Year = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @Month = CAST(@temp AS INT)
		ELSE
			SET @Month = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @Day = CAST(@temp AS INT)
			ELSE
				SET @Day = 0
		END
		ELSE
			SET @Day = 0
		
		IF @Month <= 0 SET @Month = 1
		IF @Month > 12 SET @Month = 12
		
		IF @Day <= 0 SET @Day = 1
		IF @Day > 31 SET @Day = 31
	END
	ELSE
	BEGIN
		SET @Month = 0
		SET @Day = 0
	END
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[Ceil]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ceil]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[Ceil](@x FLOAT(53))
RETURNS BIGINT
AS
BEGIN
	DECLARE @Result BIGINT

	IF @x >= 0
		SET @Result = CEILING(@x)
	ELSE
		SET @Result = FLOOR(@x)
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[tmoonphase]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmoonphase]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[tmoonphase](@n AS INT,@nph AS INT) RETURNS FLOAT(53)
AS
BEGIN
	DECLARE @RPD FLOAT(53)
	DECLARE @Result FLOAT(53)
    SET @RPD = (1.74532925199433E-02) -- radians per degree (pi/180)

    DECLARE @jd AS FLOAT(53)
    DECLARE @t AS FLOAT(53)
    DECLARE @t2 AS FLOAT(53)
    DECLARE @t3 AS FLOAT(53)
    DECLARE @k AS FLOAT(53)
    DECLARE @ma AS FLOAT(53)
    DECLARE @sa AS FLOAT(53)
    DECLARE @tf AS FLOAT(53)
    DECLARE @xtra AS FLOAT(53)

    SET @k = @n + @nph / CAST(4 AS FLOAT(53))
    SET @t = @k / CAST(1236.85 AS FLOAT(53))
    SET @t2 = @t * @t
    SET @t3 = @t2 * @t
    SET @jd = 2415020.75933 + 29.53058868 * @k - 0.0001178 * @t2
        - 0.000000155 * @t3 
        + 0.00033 * SIN(@RPD * (166.56 + 132.87 * @t - 0.009173 * @t2))
--
--   Sun--s mean anomaly
    SET @sa = @RPD * (359.2242 + 29.10535608 * @k - 0.0000333 * @t2 - 0.00000347 * @t3)
--
--   Moon--s mean anomaly
    SET @ma = @RPD * (306.0253 + 385.81691806 * @k + 0.0107306 * @t2 + 0.00001236 * @t3)
    
--
--   Moon--s argument of latitude
    SET @tf = @RPD * CAST(2 AS FLOAT(53)) * (21.2964 + 390.67050646 * @k - 0.0016528 * @t2 
              - 0.00000239 * @t3)
--
--   should reduce to interval 0-1.0 before calculating further
    IF @nph IN (0,2)
        SET @xtra = (0.1734 - 0.000393 * @t) * SIN(@sa) 
              + 0.0021 * SIN(@sa * 2) 
              - 0.4068 * SIN(@ma) + 0.0161 * SIN(2 * @ma) - 0.0004 * SIN(3 * @ma) 
              + 0.0104 * SIN(@tf) 
              - 0.0051 * SIN(@sa + @ma) - 0.0074 * SIN(@sa - @ma) 
              + 0.0004 * SIN(@tf + @sa) - 0.0004 * SIN(@tf - @sa) 
              - 0.0006 * SIN(@tf + @ma) + 0.001 * SIN(@tf - @ma) 
              + 0.0005 * SIN(@sa + 2 * @ma)
	ELSE
	IF @nph IN(1, 3)
	BEGIN
        SET @xtra = (0.1721 - 0.0004 * @t) * SIN(@sa) 
              + 0.0021 * SIN(@sa * 2) 
              - 0.628 * SIN(@ma) + 0.0089 * SIN(2 * @ma) - 0.0004 * SIN(3 * @ma) 
              + 0.0079 * SIN(@tf) 
              - 0.0119 * SIN(@sa + @ma) - 0.0047 * SIN(@sa - @ma) 
              + 0.0003 * SIN(@tf + @sa) - 0.0004 * SIN(@tf - @sa) 
              - 0.0006 * SIN(@tf + @ma) + 0.0021 * SIN(@tf - @ma) 
              + 0.0003 * SIN(@sa + 2 * @ma) + 0.0004 * SIN(@sa - 2 * @ma) 
              - 0.0003 * SIN(2 * @sa + @ma)
        IF (@nph = 1)
            SET @xtra = @xtra + 0.0028 - 0.0004 * COS(@sa) + 0.0003 * COS(@ma)
        ELSE
            SET @xtra = @xtra - 0.0028 + 0.0004 * COS(@sa) - 0.0003 * COS(@ma)
    END
    ELSE
    BEGIN
        SET @Result = 0
        RETURN @Result
    END
--   convert from Ephemeris Time (ET) to (approximate)Universal Time (UT)
    SET @Result = @jd + @xtra - (0.41 + 1.2053 * @t + 0.4992 * @t2) / CAST(1440 AS FLOAT(53))
    
    RETURN @Result
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[leap_persian]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[leap_persian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[leap_persian](@Year AS INT) RETURNS BIT AS
BEGIN
	DECLARE @Result BIT
	
	SET @Result = 0
	IF @Year > 0
	BEGIN
		IF (((((@Year - 474) % 2820) + 512) * 682) % 2816) - 682 < 0
			SET @result =  1
	END
    ELSE
		IF (((((@Year - 473) % 2820) + 512) * 682) % 2816) - 682 < 0
			SET @result = 1
	
	RETURN @Result
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[leap_islamic]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[leap_islamic]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[leap_islamic](@Year As INT) RETURNS BIT
AS
BEGIN
    DECLARE @result AS BIT
    DECLARE @YearMod30 INT
    
    SET @YearMod30 = @Year % 30
    IF @YearMod30 IN (2, 5, 7, 10, 13, 16, 18, 21, 24, 26, 29)
		SET @result = 1
	ELSE
		SET @result = 0
    
    RETURN @result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[Xor]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Xor]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[Xor](@A BIT,@B BIT) RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT

	IF @A = 0 AND @B = 0 SET @Result = 0
	ELSE
	IF @A = 1 AND @B = 0 SET @Result = 1
	ELSE
	IF @A = 0 AND @B = 1 SET @Result = 1
	ELSE
	IF @A = 1 AND @B = 1 SET @Result = 0
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[visibility]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[visibility]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[visibility](@n AS INT) RETURNS FLOAT(53)
AS
BEGIN
    -- parameters for Makkah: for a new moon to be visible after @SUNSET on
    -- a the same day in which it started, it has to have started before
    -- (@SUNSET-@MINAGE)-@TIMZ=3 A.M. local time.
    DECLARE @Result FLOAT(53)
    
    DECLARE @TIMZ AS FLOAT
    DECLARE @MINAGE AS FLOAT
    DECLARE @SUNSET AS FLOAT
    DECLARE @TIMDIF AS FLOAT
    
    SET @TIMZ = 3.0
    SET @MINAGE = 13.5
    SET @SUNSET = 19.5 -- approximate
    SET @TIMDIF = (@SUNSET - @MINAGE)

    DECLARE @jd AS FLOAT(53)
    DECLARE @tf AS FLOAT
    DECLARE @d AS INT
    
    SET @jd = dbo.tmoonphase(@n, 0)
    SET @d = FLOOR(@jd)
    SET @tf = (@jd - @d)
    IF (@tf <= 0.5)   -- new moon starts in the afternoon
        SET @Result = (@jd + CAST(1 AS FLOAT(53)))
    ELSE  -- new moon starts before noon
    BEGIN
        SET @tf = (@tf - 0.5) * 24 + @TIMZ -- local time
        IF (@tf > @TIMDIF) 
            SET @Result = (@jd + CAST(1 AS FLOAT(53))) -- age at @SUNSET < min for visiblity
        ELSE
            SET @Result = (@jd)
    END
    
    RETURN @Result
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[persian_jdn]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[persian_jdn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[persian_jdn](@Year As INT,@Month As INT,@Day As INT) RETURNS INT AS
BEGIN
    DECLARE @PERSIAN_EPOCH INT
    SET @PERSIAN_EPOCH = 1948321 -- The JDN of 1 Farvardin 1

    DECLARE @epbase AS INT
    DECLARE @epyear AS INT
    DECLARE @mdays AS INT
    DECLARE @Result AS INT
    
    IF @Year >= 0
        SET @epbase = @Year - 474
    ELSE
        SET @epbase = @Year - 473
    
    SET @epyear = 474 + (@epbase % 2820)
    
    IF @Month <= 7
        SET @mdays = (@Month - 1) * 31
    ELSE
        SET @mdays = (@Month - 1) * 30 + 6
    
    SET @Result =
		  @Day
		+ @mdays
		+ dbo.Fix(((@epyear * 682) - 110) / CAST(2816 AS REAL))
		+ (@epyear - 1) * 365
		+ dbo.Fix(@epbase / CAST(2820 AS REAL)) * 1029983
		+ (@PERSIAN_EPOCH - 1)
		
	RETURN @Result
END

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[civil_leapyear]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_leapyear]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[civil_leapyear](@Year AS INT,@CalendarType AS INT = -1) RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	
	IF @CalendarType = -1
		SET @CalendarType = @Gregorian

    IF @CalendarType <> @Gregorian Or @Year < 1582
    BEGIN
    -- Julian calendar
		IF (@Year % 4) = 0
			SET @Result = 1
        ELSE
			SET @Result = 0
	END
    ELSE
    -- Gregorian calendar
        SET @Result = dbo.Xor
					(
						(CASE WHEN @Year % 4 = 0 THEN 1 ELSE 0 END)
                    ,    
                         dbo.Xor
                         (
							(CASE WHEN @Year % 100 = 0 THEN 1 ELSE 0 END),
							(CASE WHEN @Year % 400 = 0 THEN 1 ELSE 0 END)
                         )
					)

	RETURN @Result
END

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[Hebrew_ElapsedCalendarDays]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hebrew_ElapsedCalendarDays]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[Hebrew_ElapsedCalendarDays](@Year INT) RETURNS INT
AS
BEGIN
	DECLARE @Result INT
    DECLARE @MonthsElapsed AS INT
    DECLARE @PartsElapsed AS INT
    DECLARE @HoursElapsed AS INT
    DECLARE @ConjunctionDay AS INT
    DECLARE @ConjunctionParts AS INT
    DECLARE @AlternativeDay AS INT

    SET @MonthsElapsed = (235 * dbo.Fix(((@Year - 1) / CAST(19 AS FLOAT(53))))) + 
                    (12 * ((@Year - 1) % 19)) + 
                    dbo.Fix((7 * ((@Year - 1) % 19) + 1) / CAST(19 AS FLOAT(53)))
    SET @PartsElapsed = 204 + 793 * (@MonthsElapsed % 1080)
    SET @HoursElapsed = 5 + 12 * @MonthsElapsed + 
                   793 * dbo.Fix((@MonthsElapsed / CAST(1080 AS FLOAT(53)))) + 
                   dbo.Fix(@PartsElapsed / CAST(1080 AS FLOAT(53)))
    SET @ConjunctionDay = 1 + 29 * @MonthsElapsed + dbo.Fix(@HoursElapsed / CAST(24 AS FLOAT(53)))
    SET @ConjunctionParts = (1080 * (@HoursElapsed % 24)) + 
                       @PartsElapsed % 1080
    IF ((@ConjunctionParts >= 19440) OR
        (((@ConjunctionDay % 7) = 2) AND
        (@ConjunctionParts >= 9924) AND
        (dbo.Hebrew_LeapYear(@Year) <> 1)) OR
       (((@ConjunctionDay % 7) = 1) AND
        (@ConjunctionParts >= 16789) AND
        (dbo.Hebrew_LeapYear(@Year - 1) = 1))) 
        SET @AlternativeDay = @ConjunctionDay + 1
    ELSE
        SET @AlternativeDay = @ConjunctionDay
    
    IF (((@AlternativeDay % 7) = 0) OR
        ((@AlternativeDay % 7) = 3) OR
        ((@AlternativeDay % 7) = 5)) 
        SET @AlternativeDay = @AlternativeDay + 1

    SET @Result = @AlternativeDay
    
    RETURN @Result
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[jdn_julian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[jdn_julian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[jdn_julian]
(
	@jdn AS INT,
	@Year AS INT OUT,
	@Month AS INT OUT,
	@Day AS INT OUT
)
AS
BEGIN
    DECLARE @L AS INT
    DECLARE @k AS INT
    DECLARE @n AS INT
    DECLARE @i AS INT
    DECLARE @j AS INT

    SET @j = @jdn + 1402
    SET @k = dbo.Fix((@j - 1) / CAST(1461 AS REAL))
    SET @L = @j - 1461 * @k
    SET @n = dbo.Fix((@L - 1) / CAST(365 AS REAL)) - dbo.Fix(@L / CAST(1461 AS REAL))
    SET @i = @L - 365 * @n + 30
    SET @j = dbo.Fix((80 * @i) / CAST(2447 AS REAL))
    SET @Day = @i - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
    SET @i = dbo.Fix(@j / CAST(11 AS REAL))
    SET @Month = @j + 2 - 12 * @i
    SET @Year = 4 * @k + @n + @i - 4716
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[julian_jdn]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[julian_jdn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[julian_jdn](@Year AS INT,@Month AS INT,@Day AS INT) RETURNS INT
AS
BEGIN
	DECLARE @Result INT
	
    DECLARE @OYear AS INT
    DECLARE @OMonth AS INT
    DECLARE @ODay AS INT

    SET @OYear = @Year
    SET @OMonth = @Month
    SET @ODay = @Day

    SET @Result = 367 * @OYear -
            dbo.Fix((7 * (@OYear + 5001 + dbo.Fix((@OMonth - 9) / CAST(7 AS REAL)))) / CAST(4 AS REAL))
            + dbo.Fix((275 * @OMonth) / CAST(9 AS REAL)) + @ODay + 1729777

	RETURN @Result
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[islamic_daysInMonth]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[islamic_daysInMonth]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[islamic_daysInMonth](@Year As INT, @Month As INT) RETURNS INT
AS
BEGIN
    DECLARE @Result As INT
    
    IF @Month IN (1, 3, 5, 7, 9, 11)
		SET @Result = 30
    ELSE
    IF @Month IN (2, 4, 6, 8, 10)
		SET @Result = 29
	ELSE
	IF @Month = 12
	BEGIN
		IF dbo.leap_islamic(@Year) = 1
			SET @Result = 30
		ELSE
			SET @Result = 29
	END
	ELSE
        SET @Result = 0
    
    RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[islamic_jdn]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[islamic_jdn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- Description			:
--
-- Given a Hijri date, compute corresponding julian day number
--
CREATE FUNCTION [dbo].[islamic_jdn](@Year As INT,@Month As INT,@Day As INT) RETURNS INT
AS
BEGIN
    -- NMONTH is the number of months between julian day number 1 and
    -- the @Year 1405 A.H. which started immediatly after lunar
    -- conjunction number 1048 which occured on September 1984 25d
    -- 3h 10m UT.
    DECLARE @Result INT
    DECLARE @NMONTHS INT
    SET @NMONTHS = (1405 * 12 + 1)

    DECLARE @k AS INT
    
    IF (@Year < 0) SET @Year = @Year + 1
    SET @k = @Month + @Year * 12 - @NMONTHS -- nunber of months since 1/1/1405
    SET @Result = FLOOR(dbo.visibility(@k + CAST(1048 AS INT)) + @Day + 0.5)
    
    RETURN @Result
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[civil_daysInMonth]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_daysInMonth]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[civil_daysInMonth](@Year AS INT,@Month AS INT,@CalendarType AS INT = -1) RETURNS INT
AS
BEGIN
	DECLARE @Result INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	
	IF @CalendarType = -1
		SET @CalendarType = @Gregorian

	IF @Month = 2 -- February
	BEGIN
        IF dbo.civil_leapyear(@Year, @CalendarType) = 1
            SET @Result = 29
        ELSE
            SET @Result = 28
	END
	ELSE
	IF @Month IN (4, 6, 9, 11) -- April, June, September or November
        SET @Result = 30
    ELSE    -- Other values.
        SET @Result = 31
    
    RETURN @Result
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[jdn_civil]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[jdn_civil]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[jdn_civil]
(
	@jdn AS INT,
    @Year AS INT OUT,
    @Month AS INT OUT,
    @Day AS INT OUT
)
AS
BEGIN
    DECLARE @L AS INT
    DECLARE @k AS INT
    DECLARE @n AS INT
    DECLARE @i AS INT
    DECLARE @j AS INT

    IF (@jdn > 2299160)
    BEGIN
        SET @L = @jdn + 68569
        SET @n = dbo.Fix((4 * @L) / CAST(146097 AS REAL))
        SET @L = @L - dbo.Fix((146097 * @n + 3) / CAST(4 AS REAL))
        SET @i = dbo.Fix((4000 * (@L + 1)) / CAST(1461001 AS REAL))
        SET @L = @L - dbo.Fix((1461 * @i) / CAST(4 AS REAL)) + 31
        SET @j = dbo.Fix((80 * @L) / CAST(2447 AS REAL))
        SET @Day = @L - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
        SET @L = dbo.Fix(@j / CAST(11 AS REAL))
        SET @Month = @j + 2 - 12 * @L
        SET @Year = 100 * (@n - 49) + @i + @L
    END
    ELSE
        EXEC dbo.jdn_julian @jdn, @Year OUT, @Month OUT, @Day OUT
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[Hebrew_DaysInYear]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hebrew_DaysInYear]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[Hebrew_DaysInYear](@Year INT) RETURNS INT
AS
BEGIN
	DECLARE @Result INT
	
    SET @Result = dbo.Hebrew_ElapsedCalendarDays(@Year + 1) - dbo.Hebrew_ElapsedCalendarDays(@Year)

	RETURN @Result
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[civil_jdn]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_jdn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[civil_jdn](@Year AS INT,@Month AS INT,@Day AS INT,@CalendarType AS INT = -1) RETURNS INT
AS
BEGIN
	DECLARE @Result INT
	
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
    DECLARE @OYear AS INT
    DECLARE @OMonth AS INT
    DECLARE @ODay AS INT

	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	
	IF @CalendarType = -1
		SET @CalendarType = @Gregorian

    IF @CalendarType = @Gregorian AND ((@Year > 1582) OR 
        ((@Year = 1582) AND (@Month > 10)) OR 
        ((@Year = 1582) AND (@Month = 10) AND (@Day > 14))) 
    BEGIN
        SET @OYear = @Year
        SET @OMonth = @Month
        SET @ODay = @Day
        SET @Result = dbo.Fix((1461 * (@OYear + 4800 + dbo.Fix((@OMonth - 14) / CAST(12 AS REAL)))) / CAST(4 AS REAL)) 
            + dbo.Fix((367 * (@OMonth - 2 - 12 * (dbo.Fix((@OMonth - 14) / CAST(12 AS REAL))))) / CAST(12 AS REAL))
            - dbo.Fix((3 * (dbo.Fix((@OYear + 4900 + dbo.Fix((@OMonth - 14) / CAST(12 AS REAL))) / CAST(100 AS REAL)))) / CAST(4 AS REAL))
            + @ODay - 32075
	END
    ELSE
        SET @Result = dbo.julian_jdn(@Year, @Month, @Day)
    
	RETURN @Result
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[jdn_persian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[jdn_persian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[jdn_persian]
(
	@jdn AS INT,
	@Year AS INT OUT,
	@Month AS INT OUT,
	@Day AS INT OUT
)
AS
BEGIN
    DECLARE @depoch AS INT
    DECLARE @cycle AS INT
    DECLARE @cyear AS INT
    DECLARE @ycycle AS INT
    DECLARE @aux1 AS INT
    DECLARE @aux2 AS INT
    DECLARE @yday AS INT
    
    SET @depoch = @jdn - dbo.persian_jdn(475, 1, 1)
    SET @cycle = dbo.Fix(@depoch / CAST(1029983 AS REAL))
    SET @cyear = @depoch % 1029983
    IF @cyear = 1029982
        SET @ycycle = 2820
    ELSE
    BEGIN
        SET @aux1 = dbo.Fix(@cyear / CAST(366 AS REAL))
        SET @aux2 = @cyear % 366
        SET @ycycle = FLOOR(((2134 * @aux1) + (2816 * @aux2) + 2815) / CAST(1028522 AS REAL)) + @aux1 + 1
    END
    
    SET @Year = @ycycle + (2820 * @cycle) + 474
    IF @Year <= 0 
        SET @Year = @Year - 1
    
    SET @yday = (@jdn - dbo.persian_jdn(@Year, 1, 1)) + 1
    IF @yday <= 186 
        SET @Month = dbo.Ceil(@yday / CAST(31 AS REAL))
    ELSE
        SET @Month = dbo.Ceil((@yday - 6) / CAST(30 AS REAL))
    
    SET @Day = (@jdn - dbo.persian_jdn(@Year, @Month, 1)) + 1
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[persian_julian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[persian_julian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[persian_julian]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.persian_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_julian @jdn, @OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Persian2Christian]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Persian2Christian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Persian2Christian](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	---------------------------------------------------------------------------------------
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- persian_civil
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.persian_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_civil
		DECLARE @L AS INT
		DECLARE @k AS INT
		DECLARE @n AS INT

		IF (@jdn > 2299160)
		BEGIN
			SET @L = @jdn + 68569
			SET @n = dbo.Fix((4 * @L) / CAST(146097 AS REAL))
			SET @L = @L - dbo.Fix((146097 * @n + 3) / CAST(4 AS REAL))
			SET @i = dbo.Fix((4000 * (@L + 1)) / CAST(1461001 AS REAL))
			SET @L = @L - dbo.Fix((1461 * @i) / CAST(4 AS REAL)) + 31
			SET @j = dbo.Fix((80 * @L) / CAST(2447 AS REAL))
			SET @ODay = @L - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @L = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @L
			SET @OYear = 100 * (@n - 49) + @i + @L
		END
		ELSE
		BEGIN
			-- jdn_julian
			SET @j = @jdn + 1402
			SET @k = dbo.Fix((@j - 1) / CAST(1461 AS REAL))
			SET @L = @j - 1461 * @k
			SET @n = dbo.Fix((@L - 1) / CAST(365 AS REAL)) - dbo.Fix(@L / CAST(1461 AS REAL))
			SET @i = @L - 365 * @n + 30
			SET @j = dbo.Fix((80 * @i) / CAST(2447 AS REAL))
			SET @ODay = @i - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @i = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @i
			SET @OYear = 4 * @k + @n + @i - 4716
		END
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Julian2Persian]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Julian2Persian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Julian2Persian](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- julian_persian
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.julian_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_persian
		DECLARE @depoch AS INT
		DECLARE @cycle AS INT
		DECLARE @cyear AS INT
		DECLARE @ycycle AS INT
		DECLARE @aux1 AS INT
		DECLARE @aux2 AS INT
		DECLARE @yday AS INT
	    
		SET @depoch = @jdn - dbo.persian_jdn(475, 1, 1)
		SET @cycle = dbo.Fix(@depoch / CAST(1029983 AS REAL))
		SET @cyear = @depoch % 1029983
		IF @cyear = 1029982
			SET @ycycle = 2820
		ELSE
		BEGIN
			SET @aux1 = dbo.Fix(@cyear / CAST(366 AS REAL))
			SET @aux2 = @cyear % 366
			SET @ycycle = FLOOR(((2134 * @aux1) + (2816 * @aux2) + 2815) / CAST(1028522 AS REAL)) + @aux1 + 1
		END
	    
		SET @OYear = @ycycle + (2820 * @cycle) + 474
		IF @OYear <= 0 
			SET @OYear = @OYear - 1
	    
		SET @yday = (@jdn - dbo.persian_jdn(@OYear, 1, 1)) + 1
		IF @yday <= 186 
			SET @OMonth = dbo.Ceil(@yday / CAST(31 AS REAL))
		ELSE
			SET @OMonth = dbo.Ceil((@yday - 6) / CAST(30 AS REAL))
	    
		SET @ODay = (@jdn - dbo.persian_jdn(@OYear, @OMonth, 1)) + 1
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Julian2Islamic]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Julian2Islamic]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Julian2Islamic](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- julian_islamic
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.julian_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_islamic
		DECLARE @mjd As FLOAT(53)
		DECLARE @k As INT
		DECLARE @hm As INT

		-- jdn_civil
		DECLARE @L AS INT
		DECLARE @n AS INT

		IF (@jdn > 2299160)
		BEGIN
			SET @L = @jdn + 68569
			SET @n = dbo.Fix((4 * @L) / CAST(146097 AS REAL))
			SET @L = @L - dbo.Fix((146097 * @n + 3) / CAST(4 AS REAL))
			SET @i = dbo.Fix((4000 * (@L + 1)) / CAST(1461001 AS REAL))
			SET @L = @L - dbo.Fix((1461 * @i) / CAST(4 AS REAL)) + 31
			SET @j = dbo.Fix((80 * @L) / CAST(2447 AS REAL))
			SET @ODay = @L - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @L = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @L
			SET @OYear = 100 * (@n - 49) + @i + @L
		END
		ELSE
		BEGIN
			-- jdn_julian
			SET @j = @jdn + 1402
			SET @k = dbo.Fix((@j - 1) / CAST(1461 AS REAL))
			SET @L = @j - 1461 * @k
			SET @n = dbo.Fix((@L - 1) / CAST(365 AS REAL)) - dbo.Fix(@L / CAST(1461 AS REAL))
			SET @i = @L - 365 * @n + 30
			SET @j = dbo.Fix((80 * @i) / CAST(2447 AS REAL))
			SET @ODay = @i - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @i = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @i
			SET @OYear = 4 * @k + @n + @i - 4716
		END
		
		SET @k = FLOOR(0.6 + (@OYear + CAST((@OMonth - 0.5) AS INT) / CAST(12 AS REAL) + @ODay / CAST(365 AS REAL) - 1900) * 12.3685)
	    
		WHILE (1 = 1)
		BEGIN
			SET @mjd = dbo.visibility(@k)
			SET @k = @k - 1
			IF NOT (@mjd > (@jdn - 0.5)) BREAK
		END
	    
		SET @k = @k + 1
		SET @hm = @k - 1048
		SET @OYear = 1405 + dbo.Fix(@hm / CAST(12 AS REAL))
		--@Year = 1405 + Int(@hm / 12)
	    
		SET @OMonth = (@hm % 12) + 1
		IF (@hm <> 0 And @OMonth <= 0)
		BEGIN
			SET @OMonth = @OMonth + 12
			SET @OYear = @OYear - 1
		END
		IF @OYear <= 0
			SET @OYear = @OYear - 1
		
		SET @ODay = FLOOR(@jdn - @mjd + 0.5)
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Julian2Christian]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Julian2Christian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[UDateConvert_Julian2Christian](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		--julian_civil
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.julian_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_civil
		DECLARE @L AS INT
		DECLARE @k AS INT
		DECLARE @n AS INT

		IF (@jdn > 2299160)
		BEGIN
			SET @L = @jdn + 68569
			SET @n = dbo.Fix((4 * @L) / CAST(146097 AS REAL))
			SET @L = @L - dbo.Fix((146097 * @n + 3) / CAST(4 AS REAL))
			SET @i = dbo.Fix((4000 * (@L + 1)) / CAST(1461001 AS REAL))
			SET @L = @L - dbo.Fix((1461 * @i) / CAST(4 AS REAL)) + 31
			SET @j = dbo.Fix((80 * @L) / CAST(2447 AS REAL))
			SET @ODay = @L - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @L = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @L
			SET @OYear = 100 * (@n - 49) + @i + @L
		END
		ELSE
		BEGIN
			-- jdn_julian
			SET @j = @jdn + 1402
			SET @k = dbo.Fix((@j - 1) / CAST(1461 AS REAL))
			SET @L = @j - 1461 * @k
			SET @n = dbo.Fix((@L - 1) / CAST(365 AS REAL)) - dbo.Fix(@L / CAST(1461 AS REAL))
			SET @i = @L - 365 * @n + 30
			SET @j = dbo.Fix((80 * @i) / CAST(2447 AS REAL))
			SET @ODay = @i - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @i = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @i
			SET @OYear = 4 * @k + @n + @i - 4716
		END
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Persian2Julian]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Persian2Julian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Persian2Julian](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- persian_julian
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.persian_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_julian
		DECLARE @L AS INT
		DECLARE @k AS INT
		DECLARE @n AS INT

		SET @j = @jdn + 1402
		SET @k = dbo.Fix((@j - 1) / CAST(1461 AS REAL))
		SET @L = @j - 1461 * @k
		SET @n = dbo.Fix((@L - 1) / CAST(365 AS REAL)) - dbo.Fix(@L / CAST(1461 AS REAL))
		SET @i = @L - 365 * @n + 30
		SET @j = dbo.Fix((80 * @i) / CAST(2447 AS REAL))
		SET @ODay = @i - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
		SET @i = dbo.Fix(@j / CAST(11 AS REAL))
		SET @OMonth = @j + 2 - 12 * @i
		SET @OYear = 4 * @k + @n + @i - 4716
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Persian2Islamic]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Persian2Islamic]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Persian2Islamic](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- persian_islamic
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.persian_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_islamic
		DECLARE @mjd As FLOAT(53)
		DECLARE @k As INT
		DECLARE @hm As INT

		-- jdn_civil
		DECLARE @L AS INT
		DECLARE @n AS INT

		IF (@jdn > 2299160)
		BEGIN
			SET @L = @jdn + 68569
			SET @n = dbo.Fix((4 * @L) / CAST(146097 AS REAL))
			SET @L = @L - dbo.Fix((146097 * @n + 3) / CAST(4 AS REAL))
			SET @i = dbo.Fix((4000 * (@L + 1)) / CAST(1461001 AS REAL))
			SET @L = @L - dbo.Fix((1461 * @i) / CAST(4 AS REAL)) + 31
			SET @j = dbo.Fix((80 * @L) / CAST(2447 AS REAL))
			SET @ODay = @L - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @L = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @L
			SET @OYear = 100 * (@n - 49) + @i + @L
		END
		ELSE
		BEGIN
			-- jdn_julian
			SET @j = @jdn + 1402
			SET @k = dbo.Fix((@j - 1) / CAST(1461 AS REAL))
			SET @L = @j - 1461 * @k
			SET @n = dbo.Fix((@L - 1) / CAST(365 AS REAL)) - dbo.Fix(@L / CAST(1461 AS REAL))
			SET @i = @L - 365 * @n + 30
			SET @j = dbo.Fix((80 * @i) / CAST(2447 AS REAL))
			SET @ODay = @i - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @i = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @i
			SET @OYear = 4 * @k + @n + @i - 4716
		END
		
		SET @k = FLOOR(0.6 + (@OYear + CAST((@OMonth - 0.5) AS INT) / CAST(12 AS REAL) + @ODay / CAST(365 AS REAL) - 1900) * 12.3685)
	    
		WHILE (1 = 1)
		BEGIN
			SET @mjd = dbo.visibility(@k)
			SET @k = @k - 1
			IF NOT (@mjd > (@jdn - 0.5)) BREAK
		END
	    
		SET @k = @k + 1
		SET @hm = @k - 1048
		SET @OYear = 1405 + dbo.Fix(@hm / CAST(12 AS REAL))
		--@Year = 1405 + Int(@hm / 12)
	    
		SET @OMonth = (@hm % 12) + 1
		IF (@hm <> 0 And @OMonth <= 0)
		BEGIN
			SET @OMonth = @OMonth + 12
			SET @OYear = @OYear - 1
		END
		IF @OYear <= 0
			SET @OYear = @OYear - 1
		
		SET @ODay = FLOOR(@jdn - @mjd + 0.5)
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[julian_civil]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[julian_civil]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[julian_civil]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.julian_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_civil @jdn, @OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Islamic2Christian]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Islamic2Christian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Islamic2Christian](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- islamic_civil
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.islamic_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_civil
		DECLARE @L AS INT
		DECLARE @k AS INT
		DECLARE @n AS INT

		IF (@jdn > 2299160)
		BEGIN
			SET @L = @jdn + 68569
			SET @n = dbo.Fix((4 * @L) / CAST(146097 AS REAL))
			SET @L = @L - dbo.Fix((146097 * @n + 3) / CAST(4 AS REAL))
			SET @i = dbo.Fix((4000 * (@L + 1)) / CAST(1461001 AS REAL))
			SET @L = @L - dbo.Fix((1461 * @i) / CAST(4 AS REAL)) + 31
			SET @j = dbo.Fix((80 * @L) / CAST(2447 AS REAL))
			SET @ODay = @L - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @L = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @L
			SET @OYear = 100 * (@n - 49) + @i + @L
		END
		ELSE
		BEGIN
			-- jdn_julian
			SET @j = @jdn + 1402
			SET @k = dbo.Fix((@j - 1) / CAST(1461 AS REAL))
			SET @L = @j - 1461 * @k
			SET @n = dbo.Fix((@L - 1) / CAST(365 AS REAL)) - dbo.Fix(@L / CAST(1461 AS REAL))
			SET @i = @L - 365 * @n + 30
			SET @j = dbo.Fix((80 * @i) / CAST(2447 AS REAL))
			SET @ODay = @i - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @i = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @i
			SET @OYear = 4 * @k + @n + @i - 4716
		END
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Christian2Persian]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Christian2Persian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Christian2Persian](@Date VARCHAR(10),@SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- civil_persian
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.civil_jdn(@IYear,@IMonth,@IDay,@Gregorian)
		
		-- jdn_persian
		DECLARE @depoch AS INT
		DECLARE @cycle AS INT
		DECLARE @cyear AS INT
		DECLARE @ycycle AS INT
		DECLARE @aux1 AS INT
		DECLARE @aux2 AS INT
		DECLARE @yday AS INT
	    
		SET @depoch = @jdn - dbo.persian_jdn(475, 1, 1)
		SET @cycle = dbo.Fix(@depoch / CAST(1029983 AS REAL))
		SET @cyear = @depoch % 1029983
		IF @cyear = 1029982
			SET @ycycle = 2820
		ELSE
		BEGIN
			SET @aux1 = dbo.Fix(@cyear / CAST(366 AS REAL))
			SET @aux2 = @cyear % 366
			SET @ycycle = FLOOR(((2134 * @aux1) + (2816 * @aux2) + 2815) / CAST(1028522 AS REAL)) + @aux1 + 1
		END
	    
		SET @OYear = @ycycle + (2820 * @cycle) + 474
		IF @OYear <= 0 
			SET @OYear = @OYear - 1
	    
		SET @yday = (@jdn - dbo.persian_jdn(@OYear, 1, 1)) + 1
		IF @yday <= 186 
			SET @OMonth = dbo.Ceil(@yday / CAST(31 AS REAL))
		ELSE
			SET @OMonth = dbo.Ceil((@yday - 6) / CAST(30 AS REAL))
	    
		SET @ODay = (@jdn - dbo.persian_jdn(@OYear, @OMonth, 1)) + 1
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Christian2Julian]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Christian2Julian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Christian2Julian](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- civil_julian
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.civil_jdn(@IYear,@IMonth,@IDay,@Gregorian)
		
		-- jdn_julian
		DECLARE @L AS INT
		DECLARE @k AS INT
		DECLARE @n AS INT

		SET @j = @jdn + 1402
		SET @k = dbo.Fix((@j - 1) / CAST(1461 AS REAL))
		SET @L = @j - 1461 * @k
		SET @n = dbo.Fix((@L - 1) / CAST(365 AS REAL)) - dbo.Fix(@L / CAST(1461 AS REAL))
		SET @i = @L - 365 * @n + 30
		SET @j = dbo.Fix((80 * @i) / CAST(2447 AS REAL))
		SET @ODay = @i - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
		SET @i = dbo.Fix(@j / CAST(11 AS REAL))
		SET @OMonth = @j + 2 - 12 * @i
		SET @OYear = 4 * @k + @n + @i - 4716
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Christian2Islamic]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Christian2Islamic]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Christian2Islamic](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- civil_islamic
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.civil_jdn(@IYear,@IMonth,@IDay,@Gregorian)
		
		-- jdn_islamic
		DECLARE @mjd As FLOAT(53)
		DECLARE @k As INT
		DECLARE @hm As INT

		-- jdn_civil
		DECLARE @L AS INT
		DECLARE @n AS INT

		IF (@jdn > 2299160)
		BEGIN
			SET @L = @jdn + 68569
			SET @n = dbo.Fix((4 * @L) / CAST(146097 AS REAL))
			SET @L = @L - dbo.Fix((146097 * @n + 3) / CAST(4 AS REAL))
			SET @i = dbo.Fix((4000 * (@L + 1)) / CAST(1461001 AS REAL))
			SET @L = @L - dbo.Fix((1461 * @i) / CAST(4 AS REAL)) + 31
			SET @j = dbo.Fix((80 * @L) / CAST(2447 AS REAL))
			SET @ODay = @L - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @L = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @L
			SET @OYear = 100 * (@n - 49) + @i + @L
		END
		ELSE
		BEGIN
			-- jdn_julian
			SET @j = @jdn + 1402
			SET @k = dbo.Fix((@j - 1) / CAST(1461 AS REAL))
			SET @L = @j - 1461 * @k
			SET @n = dbo.Fix((@L - 1) / CAST(365 AS REAL)) - dbo.Fix(@L / CAST(1461 AS REAL))
			SET @i = @L - 365 * @n + 30
			SET @j = dbo.Fix((80 * @i) / CAST(2447 AS REAL))
			SET @ODay = @i - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @i = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @i
			SET @OYear = 4 * @k + @n + @i - 4716
		END
		
		SET @k = FLOOR(0.6 + (@OYear + CAST((@OMonth - 0.5) AS INT) / CAST(12 AS REAL) + @ODay / CAST(365 AS REAL) - 1900) * 12.3685)
	    
		WHILE (1 = 1)
		BEGIN
			SET @mjd = dbo.visibility(@k)
			SET @k = @k - 1
			IF NOT (@mjd > (@jdn - 0.5)) BREAK
		END
	    
		SET @k = @k + 1
		SET @hm = @k - 1048
		SET @OYear = 1405 + dbo.Fix(@hm / CAST(12 AS REAL))
	    
		SET @OMonth = (@hm % 12) + 1
		IF (@hm <> 0 And @OMonth <= 0)
		BEGIN
			SET @OMonth = @OMonth + 12
			SET @OYear = @OYear - 1
		END
		IF @OYear <= 0
			SET @OYear = @OYear - 1
		
		SET @ODay = FLOOR(@jdn - @mjd + 0.5)
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Islamic2Persian]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Islamic2Persian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Islamic2Persian](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- islamic_persian
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.islamic_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_persian
		DECLARE @depoch AS INT
		DECLARE @cycle AS INT
		DECLARE @cyear AS INT
		DECLARE @ycycle AS INT
		DECLARE @aux1 AS INT
		DECLARE @aux2 AS INT
		DECLARE @yday AS INT
	    
		SET @depoch = @jdn - dbo.persian_jdn(475, 1, 1)
		SET @cycle = dbo.Fix(@depoch / CAST(1029983 AS REAL))
		SET @cyear = @depoch % 1029983
		IF @cyear = 1029982
			SET @ycycle = 2820
		ELSE
		BEGIN
			SET @aux1 = dbo.Fix(@cyear / CAST(366 AS REAL))
			SET @aux2 = @cyear % 366
			SET @ycycle = FLOOR(((2134 * @aux1) + (2816 * @aux2) + 2815) / CAST(1028522 AS REAL)) + @aux1 + 1
		END
	    
		SET @OYear = @ycycle + (2820 * @cycle) + 474
		IF @OYear <= 0 
			SET @OYear = @OYear - 1
	    
		SET @yday = (@jdn - dbo.persian_jdn(@OYear, 1, 1)) + 1
		IF @yday <= 186 
			SET @OMonth = dbo.Ceil(@yday / CAST(31 AS REAL))
		ELSE
			SET @OMonth = dbo.Ceil((@yday - 6) / CAST(30 AS REAL))
	    
		SET @ODay = (@jdn - dbo.persian_jdn(@OYear, @OMonth, 1)) + 1
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Islamic2Julian]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Islamic2Julian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Islamic2Julian](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- islamic_julian
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.islamic_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_julian
		DECLARE @L AS INT
		DECLARE @k AS INT
		DECLARE @n AS INT

		SET @j = @jdn + 1402
		SET @k = dbo.Fix((@j - 1) / CAST(1461 AS REAL))
		SET @L = @j - 1461 * @k
		SET @n = dbo.Fix((@L - 1) / CAST(365 AS REAL)) - dbo.Fix(@L / CAST(1461 AS REAL))
		SET @i = @L - 365 * @n + 30
		SET @j = dbo.Fix((80 * @i) / CAST(2447 AS REAL))
		SET @ODay = @i - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
		SET @i = dbo.Fix(@j / CAST(11 AS REAL))
		SET @OMonth = @j + 2 - 12 * @i
		SET @OYear = 4 * @k + @n + @i - 4716
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[persian_civil]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[persian_civil]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[persian_civil]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.persian_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_civil @jdn, @OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Persian2Julian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Persian2Julian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Persian2Julian](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.persian_julian @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[julian_persian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[julian_persian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[julian_persian]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.julian_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_persian @jdn, @OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[civil_weekNumber]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_weekNumber]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[civil_weekNumber](@Year AS INT, 
                    @Month AS INT, 
                    @Day AS INT, 
                    @DaynumStyle AS INT = -1, 
                    @WeeknumStyle AS INT = -1, 
                    @CalendarStyle AS INT = -1) RETURNS INT
AS
BEGIN
	DECLARE @Result INT
    DECLARE @markday AS INT
    DECLARE @firstmarkday AS INT

	DECLARE @ISO_8601 INT
	DECLARE @Gregorian INT
	DECLARE @Jan1InWeek1 INT
	DECLARE @Jan4InWeek1 INT
	DECLARE @Jan7InWeek1 INT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @Jan1InWeek1 = 0
	SET @Jan4InWeek1 = @ISO_8601
	SET @Jan7InWeek1 = 2
	
	IF @DaynumStyle = -1
		SET @DaynumStyle = @ISO_8601
	IF @WeeknumStyle = -1
		SET @WeeknumStyle = @ISO_8601
	IF @CalendarStyle = -1
		SET @CalendarStyle = @Gregorian

    IF @WeeknumStyle = @Jan1InWeek1
        SET @Result = dbo.Fix((dbo.civil_jdn(@Year, @Month, @Day, @CalendarStyle) 
                   - dbo.civil_jdn(@Year, 1, 1, @CalendarStyle) 
                   + dbo.[dayOfWeek](dbo.civil_jdn(@Year, 1, 1, @CalendarStyle), @DaynumStyle) + 6) / CAST(7 AS FLOAT(53)))
	ELSE
    IF @WeeknumStyle IN (@Jan4InWeek1, @Jan7InWeek1)
    BEGIN
        SET @markday = dbo.civil_jdn(@Year, @Month, @Day, @CalendarStyle) 
                   - dbo.[dayOfWeek](dbo.civil_jdn(@Year, @Month, @Day, @CalendarStyle), @DaynumStyle) 
                 + 1 + (@WeeknumStyle * 3)
        IF @markday > dbo.civil_jdn(@Year, 12, 31, @CalendarStyle)
            --this week--s @markday is next @Year, so we--re already in week 1.
            SET @Result = 1
        ELSE
        BEGIN
            IF @markday < dbo.civil_jdn(@Year, 1, 1, @CalendarStyle)
                --We--re still is last @Year--s last week.
                SET @Result = dbo.civil_weekNumber(@Year - 1, 12, 31,@DaynumStyle, @WeeknumStyle, @CalendarStyle)
            ELSE
            BEGIN
                --This is a normal week in the middle of the @Year.
                --Count the weeks between this week--s @markday and
                --the first @markday of the @Year, divide it by seven
                --and add 1. That--s it!
                SET @firstmarkday = dbo.civil_jdn(@Year, 1, 1 + (@WeeknumStyle * 3),@CalendarStyle) 
                             - dbo.[dayOfWeek](dbo.civil_jdn(@Year, 1, 1 + (@WeeknumStyle * 3),@CalendarStyle), @DaynumStyle) 
                             + 1 + (@WeeknumStyle * 3)
                SET @Result = dbo.Fix((@markday - @firstmarkday) / CAST(7 AS FLOAT(53))) + 1
            END
        END
    END
    ELSE
        SET @Result = 0
    
    RETURN @Result
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[civil_persian]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_persian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[civil_persian]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.civil_jdn(@IYear,@IMonth,@IDay,@Gregorian)
	
	EXEC dbo.jdn_persian @jdn, @OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[civil_normDate]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_normDate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[civil_normDate](@Year AS INT OUT, 
                   @Month AS INT OUT, 
                   @Day AS INT OUT, 
                   @CalendarType AS INT = -1)
AS
BEGIN
    DECLARE @monLength INT
    DECLARE @ISO_8601 INT
	DECLARE @Gregorian INT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	
	IF @CalendarType = -1
		SET @CalendarType = @Gregorian
	
    IF (@Month > 12)
    BEGIN
        SET @Year = @Year + dbo.Fix(@Month / CAST(12 AS FLOAT(53)))
        SET @Month = @Month % 12
    END
    ELSE
    IF (@Month < 1)
    BEGIN
        SET @Year = @Year + dbo.Fix(@Month / CAST(12 AS FLOAT(53))) - 1
        SET @Month = 12 + (@Month % 12)
    END

    SET @monLength = dbo.civil_daysInMonth(@Year, @Month, @CalendarType)
    WHILE (@Day > @monLength)
    BEGIN
        IF (@Month = 12)
        BEGIN
            SET @Month = 1
            SET @Year = @Year + 1
        END
        ELSE
            SET @Month = @Month + 1
        
        SET @Day = @Day - @monLength
        SET @monLength = dbo.civil_daysInMonth(@Year, @Month, @CalendarType)
    END

    WHILE (@Day < 1)
    BEGIN
        IF (@Month = 1)
        BEGIN
            SET @Month = 12
            SET @Year = @Year - 1
		END
        ELSE
            SET @Month = @Month - 1
        
        SET @Day = @Day + dbo.civil_daysInMonth(@Year, @Month, @CalendarType)
    END
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[civil_julian]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_julian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[civil_julian]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.civil_jdn(@IYear,@IMonth,@IDay,@Gregorian)
	
	EXEC dbo.jdn_julian @jdn,@OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[jdn_islamic]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[jdn_islamic]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- Description			:
-- Given a julian day number, compute corresponding Hijri date.
-- As a reference point, the routine uses the fact that the @IYear
-- 1405 A.H. started immediatly after lunar conjunction number 1048
-- which occured on September 1984 25d 3h 10m UT.
--
CREATE PROC [dbo].[jdn_islamic]
(
	@jd As INT,
    @Year As INT OUT,
    @Month As INT OUT,
    @Day As INT OUT
)
AS
BEGIN
    DECLARE @mjd As FLOAT(53)
    DECLARE @k As INT
    DECLARE @hm As INT

    EXEC dbo.jdn_civil @jd, @Year OUT, @Month OUT, @Day OUT
    SET @k = FLOOR(0.6 + (@Year + CAST((@Month - 0.5) AS INT) / CAST(12 AS REAL) + @Day / CAST(365 AS REAL) - 1900) * 12.3685)
    
    WHILE (1 = 1)
    BEGIN
        SET @mjd = dbo.visibility(@k)
        SET @k = @k - 1
        IF NOT (@mjd > (@jd - 0.5)) BREAK
	END
    
    SET @k = @k + 1
    SET @hm = @k - 1048
    SET @Year = 1405 + dbo.Fix(@hm / CAST(12 AS REAL))
    --@Year = 1405 + Int(@hm / 12)
    
    SET @Month = (@hm % 12) + 1
    IF (@hm <> 0 And @Month <= 0)
    BEGIN
        SET @Month = @Month + 12
        SET @Year = @Year - 1
    END
    IF @Year <= 0
		SET @Year = @Year - 1
	
    SET @Day = FLOOR(@jd - @mjd + 0.5)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[islamic_persian]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[islamic_persian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[islamic_persian]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.islamic_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_persian @jdn, @OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[islamic_julian]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[islamic_julian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[islamic_julian]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.islamic_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_julian @jdn, @OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[Hebrew_LongHeshvan]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hebrew_LongHeshvan]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE Function [dbo].[Hebrew_LongHeshvan](@Year AS INT) RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT
	
	SET @Result = 0
    IF ((dbo.Hebrew_DaysInYear(@Year) % 10) = 5)
		SET @Result = 1
	
	RETURN @Result
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[islamic_civil]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[islamic_civil]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[islamic_civil]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.islamic_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_civil @jdn, @OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[Hebrew_ShortKislev]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hebrew_ShortKislev]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE Function [dbo].[Hebrew_ShortKislev](@Year INT) RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT
	
	SET @Result = 0
    IF ((dbo.Hebrew_DaysInYear(@Year) % 10) = 3)
		SET @Result = 1
	
	RETURN @Result
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[Hebrew_LastDayOfMonth]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Hebrew_LastDayOfMonth]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[Hebrew_LastDayOfMonth](@Year INT, @Month INT) RETURNS INT
AS
BEGIN
	DECLARE @Result INT
	
    IF ((@Month > 6) AND (dbo.Hebrew_LeapYear(@Year) <> 1))
       SET @Month = @Month + 1
    
    IF @Month = 2
    BEGIN
        IF dbo.Hebrew_LongHeshvan(@Year) = 1
            SET @Result = 30
        ELSE
            SET @Result = 29
    END
    ELSE
    IF @Month = 3
    BEGIN
        IF dbo.Hebrew_ShortKislev(@Year) = 1
            SET @Result = 29
        ELSE
            SET @Result = 30
	END
	ELSE
	IF @Month = 6
	BEGIN
        IF dbo.Hebrew_LeapYear(@Year) = 1
            SET @Result = 30
        ELSE
            SET @Result = 29
	END
	ELSE
	IF @Month IN (4, 7, 9, 11, 13)
        SET @Result = 29
	ELSE
        SET @Result = 30
    
    RETURN @Result
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[julian_islamic]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[julian_islamic]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[julian_islamic]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.julian_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_islamic @jdn, @OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[civil_islamic]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_islamic]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[civil_islamic]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.civil_jdn(@IYear,@IMonth,@IDay,@Gregorian)
	
	EXEC dbo.jdn_islamic @jdn,@OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[persian_islamic]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[persian_islamic]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[persian_islamic]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.persian_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_islamic @jdn,@OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Islamic2Christian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Islamic2Christian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Islamic2Christian](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.islamic_civil @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Christian2Persian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Christian2Persian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Christian2Persian](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.civil_persian @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Christian2Julian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Christian2Julian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Christian2Julian](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.civil_julian @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Julian2Christian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Julian2Christian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROC [dbo].[PDateConvert_Julian2Christian](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.julian_civil @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Islamic2Persian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Islamic2Persian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Islamic2Persian](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.islamic_persian @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Islamic2Julian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Islamic2Julian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Islamic2Julian](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.islamic_julian @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Persian2Christian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Persian2Christian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Persian2Christian](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.persian_civil @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Julian2Persian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Julian2Persian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Julian2Persian](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.julian_persian @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Persian2Hebrew]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Persian2Hebrew]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Persian2Hebrew](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- persian_hebrew
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.persian_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_hebrew
		DECLARE @InputJDN AS INT
		DECLARE @tishri1 AS INT
		DECLARE @LeftOverDays AS INT
	    DECLARE @monthcoding AS INT = 1
	    
		IF @jdn <= 347997
		BEGIN
			SET @OYear = 0
			SET @OMonth = 0
			SET @ODay = 0
		END
		ELSE
		BEGIN
			SET @InputJDN = @jdn - 347997
			SET @OYear = dbo.Fix(@InputJDN / CAST(365 AS FLOAT(53))) + 1
			SET @tishri1 = dbo.Hebrew_ElapsedCalendarDays(@OYear)
	        
			WHILE (@tishri1 > @InputJDN)
			BEGIN
				SET @OYear = @OYear - 1
				SET @tishri1 = dbo.Hebrew_ElapsedCalendarDays(@OYear)
			END
			SET @OMonth = 1
			SET @LeftOverDays = @InputJDN - @tishri1
			WHILE (@LeftOverDays >= dbo.Hebrew_LastDayOfMonth(@OYear, @OMonth))
			BEGIN
				SET @LeftOverDays = @LeftOverDays - dbo.Hebrew_LastDayOfMonth(@OYear, @OMonth)
				SET @OMonth = @OMonth + 1
			END
	        
			IF SIGN(@monthcoding) = -1
			BEGIN
				IF @OMonth > 6
				BEGIN
					IF dbo.Hebrew_LeapYear(@OYear) = 1
						SET @OMonth = @OMonth - 14
					ELSE
						SET @OMonth = @OMonth - 13
				END
			END
	        
			SET @ODay = @LeftOverDays + 1
		END
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Julian2Islamic]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Julian2Islamic]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Julian2Islamic](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.julian_islamic @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Persian2Islamic]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Persian2Islamic]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Persian2Islamic](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.persian_islamic @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Julian2Hebrew]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Julian2Hebrew]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Julian2Hebrew](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- julian_hebrew
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.julian_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_hebrew
		DECLARE @InputJDN AS INT
		DECLARE @tishri1 AS INT
		DECLARE @LeftOverDays AS INT
	    DECLARE @monthcoding AS INT = 1
	    
		IF @jdn <= 347997
		BEGIN
			SET @OYear = 0
			SET @OMonth = 0
			SET @ODay = 0
		END
		ELSE
		BEGIN
			SET @InputJDN = @jdn - 347997
			SET @OYear = dbo.Fix(@InputJDN / CAST(365 AS FLOAT(53))) + 1
			SET @tishri1 = dbo.Hebrew_ElapsedCalendarDays(@OYear)
	        
			WHILE (@tishri1 > @InputJDN)
			BEGIN
				SET @OYear = @OYear - 1
				SET @tishri1 = dbo.Hebrew_ElapsedCalendarDays(@OYear)
			END
			SET @OMonth = 1
			SET @LeftOverDays = @InputJDN - @tishri1
			WHILE (@LeftOverDays >= dbo.Hebrew_LastDayOfMonth(@OYear, @OMonth))
			BEGIN
				SET @LeftOverDays = @LeftOverDays - dbo.Hebrew_LastDayOfMonth(@OYear, @OMonth)
				SET @OMonth = @OMonth + 1
			END
	        
			IF SIGN(@monthcoding) = -1
			BEGIN
				IF @OMonth > 6
				BEGIN
					IF dbo.Hebrew_LeapYear(@OYear) = 1
						SET @OMonth = @OMonth - 14
					ELSE
						SET @OMonth = @OMonth - 13
				END
			END
	        
			SET @ODay = @LeftOverDays + 1
		END
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Islamic2Hebrew]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Islamic2Hebrew]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Islamic2Hebrew](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- islamic_hebrew
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.islamic_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_hebrew
		DECLARE @InputJDN AS INT
		DECLARE @tishri1 AS INT
		DECLARE @LeftOverDays AS INT
	    DECLARE @monthcoding AS INT = 1
	    
		IF @jdn <= 347997
		BEGIN
			SET @OYear = 0
			SET @OMonth = 0
			SET @ODay = 0
		END
		ELSE
		BEGIN
			SET @InputJDN = @jdn - 347997
			SET @OYear = dbo.Fix(@InputJDN / CAST(365 AS FLOAT(53))) + 1
			SET @tishri1 = dbo.Hebrew_ElapsedCalendarDays(@OYear)
	        
			WHILE (@tishri1 > @InputJDN)
			BEGIN
				SET @OYear = @OYear - 1
				SET @tishri1 = dbo.Hebrew_ElapsedCalendarDays(@OYear)
			END
			SET @OMonth = 1
			SET @LeftOverDays = @InputJDN - @tishri1
			WHILE (@LeftOverDays >= dbo.Hebrew_LastDayOfMonth(@OYear, @OMonth))
			BEGIN
				SET @LeftOverDays = @LeftOverDays - dbo.Hebrew_LastDayOfMonth(@OYear, @OMonth)
				SET @OMonth = @OMonth + 1
			END
	        
			IF SIGN(@monthcoding) = -1
			BEGIN
				IF @OMonth > 6
				BEGIN
					IF dbo.Hebrew_LeapYear(@OYear) = 1
						SET @OMonth = @OMonth - 14
					ELSE
						SET @OMonth = @OMonth - 13
				END
			END
	        
			SET @ODay = @LeftOverDays + 1
		END
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Christian2Hebrew]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Christian2Hebrew]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Christian2Hebrew](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- civil_hebrew
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.civil_jdn(@IYear,@IMonth,@IDay,@Gregorian)
		
		-- jdn_hebrew
		DECLARE @InputJDN AS INT
		DECLARE @tishri1 AS INT
		DECLARE @LeftOverDays AS INT
	    DECLARE @monthcoding AS INT = 1
	    
		IF @jdn <= 347997
		BEGIN
			SET @OYear = 0
			SET @OMonth = 0
			SET @ODay = 0
		END
		ELSE
		BEGIN
			SET @InputJDN = @jdn - 347997
			SET @OYear = dbo.Fix(@InputJDN / CAST(365 AS FLOAT(53))) + 1
			SET @tishri1 = dbo.Hebrew_ElapsedCalendarDays(@OYear)
	        
			WHILE (@tishri1 > @InputJDN)
			BEGIN
				SET @OYear = @OYear - 1
				SET @tishri1 = dbo.Hebrew_ElapsedCalendarDays(@OYear)
			END
			SET @OMonth = 1
			SET @LeftOverDays = @InputJDN - @tishri1
			WHILE (@LeftOverDays >= dbo.Hebrew_LastDayOfMonth(@OYear, @OMonth))
			BEGIN
				SET @LeftOverDays = @LeftOverDays - dbo.Hebrew_LastDayOfMonth(@OYear, @OMonth)
				SET @OMonth = @OMonth + 1
			END
	        
			IF SIGN(@monthcoding) = -1
			BEGIN
				IF @OMonth > 6
				BEGIN
					IF dbo.Hebrew_LeapYear(@OYear) = 1
						SET @OMonth = @OMonth - 14
					ELSE
						SET @OMonth = @OMonth - 13
				END
			END
	        
			SET @ODay = @LeftOverDays + 1
		END
    
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Christian2Islamic]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Christian2Islamic]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Christian2Islamic](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.civil_islamic @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[hebrew_jdn]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hebrew_jdn]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE FUNCTION [dbo].[hebrew_jdn](@Year INT, @Month INT, @Day INT) RETURNS INT
AS
BEGIN
	DECLARE @Result INT
    DECLARE @jdn AS INT
    DECLARE @counter AS INT
    
    IF @Month < 0
    BEGIN
        IF dbo.Hebrew_LeapYear(@Year) = 1
            SET @Month = 14 + @Month
        ELSE
            SET @Month = 13 + @Month
    END
    SET @jdn = dbo.Hebrew_ElapsedCalendarDays(@Year)
    SET @counter = 1
    WHILE @counter <= @Month - 1
    BEGIN
        SET @jdn = @jdn + dbo.Hebrew_LastDayOfMonth(@Year, @counter)
		SET @counter = @counter + 1
	END
    SET @Result = @jdn + (@Day - 1 + 347997)
    
    RETURN @Result
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[jdn_hebrew]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[jdn_hebrew]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[jdn_hebrew]
(
	@jdn AS INT, 
	@Year AS INT OUT, 
    @Month AS INT OUT, 
    @Day AS INT OUT, 
    @monthcoding AS INT = 1
)
AS
BEGIN
    DECLARE @InputJDN AS INT
    DECLARE @tishri1 AS INT
    DECLARE @LeftOverDays AS INT
    
    IF @jdn <= 347997
    BEGIN
        SET @Year = 0
        SET @Month = 0
        SET @Day = 0
	END
    ELSE
    BEGIN
        SET @InputJDN = @jdn - 347997
        SET @Year = dbo.Fix(@InputJDN / CAST(365 AS FLOAT(53))) + 1
        SET @tishri1 = dbo.Hebrew_ElapsedCalendarDays(@Year)
        
        WHILE (@tishri1 > @InputJDN)
        BEGIN
            SET @Year = @Year - 1
            SET @tishri1 = dbo.Hebrew_ElapsedCalendarDays(@Year)
        END
        SET @Month = 1
        SET @LeftOverDays = @InputJDN - @tishri1
        WHILE (@LeftOverDays >= dbo.Hebrew_LastDayOfMonth(@Year, @Month))
        BEGIN
            SET @LeftOverDays = @LeftOverDays - dbo.Hebrew_LastDayOfMonth(@Year, @Month)
            SET @Month = @Month + 1
        END
        
        IF SIGN(@monthcoding) = -1
        BEGIN
            IF @Month > 6
            BEGIN
                IF dbo.Hebrew_LeapYear(@Year) = 1
                    SET @Month = @Month - 14
                ELSE
                    SET @Month = @Month - 13
            END
        END
        
        SET @Day = @LeftOverDays + 1
    END
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[julian_hebrew]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[julian_hebrew]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[julian_hebrew]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.julian_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_hebrew @jdn, @OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[islamic_hebrew]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[islamic_hebrew]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[islamic_hebrew]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.islamic_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_hebrew @jdn, @OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[hebrew_persian]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hebrew_persian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[hebrew_persian]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.hebrew_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_persian @jdn, @OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[hebrew_julian]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hebrew_julian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[hebrew_julian]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.hebrew_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_julian @jdn, @OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[hebrew_islamic]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hebrew_islamic]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[hebrew_islamic]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.hebrew_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_islamic @jdn,@OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[hebrew_civil]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hebrew_civil]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[hebrew_civil]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.hebrew_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_civil @jdn, @OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[civil_hebrew]    Script Date: 08/16/2010 21:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[civil_hebrew]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[civil_hebrew]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.civil_jdn(@IYear,@IMonth,@IDay,@Gregorian)
	
	EXEC dbo.jdn_hebrew @jdn,@OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[persian_hebrew]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[persian_hebrew]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- ====================================================================
CREATE PROC [dbo].[persian_hebrew]
(
	@IYear AS INT, 
	@IMonth AS INT, 
	@IDay AS INT,
	@OYear AS INT OUT, 
	@OMonth AS INT OUT, 
	@ODay AS INT OUT
) AS
BEGIN
	DECLARE @jdn INT
	DECLARE @ISO_8601 AS TINYINT
	DECLARE @Gregorian AS TINYINT
	
	SET @ISO_8601 = 1
	SET @Gregorian = @ISO_8601
	SET @jdn = dbo.persian_jdn(@IYear,@IMonth,@IDay)
	
	EXEC dbo.jdn_hebrew @jdn,@OYear OUT, @OMonth OUT, @ODay OUT
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Hebrew2Persian]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Hebrew2Persian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Hebrew2Persian](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- hebrew_persian
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.hebrew_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_persian
		DECLARE @depoch AS INT
		DECLARE @cycle AS INT
		DECLARE @cyear AS INT
		DECLARE @ycycle AS INT
		DECLARE @aux1 AS INT
		DECLARE @aux2 AS INT
		DECLARE @yday AS INT
	    
		SET @depoch = @jdn - dbo.persian_jdn(475, 1, 1)
		SET @cycle = dbo.Fix(@depoch / CAST(1029983 AS REAL))
		SET @cyear = @depoch % 1029983
		IF @cyear = 1029982
			SET @ycycle = 2820
		ELSE
		BEGIN
			SET @aux1 = dbo.Fix(@cyear / CAST(366 AS REAL))
			SET @aux2 = @cyear % 366
			SET @ycycle = FLOOR(((2134 * @aux1) + (2816 * @aux2) + 2815) / CAST(1028522 AS REAL)) + @aux1 + 1
		END
	    
		SET @OYear = @ycycle + (2820 * @cycle) + 474
		IF @OYear <= 0 
			SET @OYear = @OYear - 1
	    
		SET @yday = (@jdn - dbo.persian_jdn(@OYear, 1, 1)) + 1
		IF @yday <= 186 
			SET @OMonth = dbo.Ceil(@yday / CAST(31 AS REAL))
		ELSE
			SET @OMonth = dbo.Ceil((@yday - 6) / CAST(30 AS REAL))
	    
		SET @ODay = (@jdn - dbo.persian_jdn(@OYear, @OMonth, 1)) + 1
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Hebrew2Julian]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Hebrew2Julian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Hebrew2Julian](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- hebrew_julian
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.hebrew_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_julian
		DECLARE @L AS INT
		DECLARE @k AS INT
		DECLARE @n AS INT

		SET @j = @jdn + 1402
		SET @k = dbo.Fix((@j - 1) / CAST(1461 AS REAL))
		SET @L = @j - 1461 * @k
		SET @n = dbo.Fix((@L - 1) / CAST(365 AS REAL)) - dbo.Fix(@L / CAST(1461 AS REAL))
		SET @i = @L - 365 * @n + 30
		SET @j = dbo.Fix((80 * @i) / CAST(2447 AS REAL))
		SET @ODay = @i - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
		SET @i = dbo.Fix(@j / CAST(11 AS REAL))
		SET @OMonth = @j + 2 - 12 * @i
		SET @OYear = 4 * @k + @n + @i - 4716
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Hebrew2Islamic]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Hebrew2Islamic]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Hebrew2Islamic](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS  
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- hebrew_islamic
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.hebrew_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_islamic
		DECLARE @mjd As FLOAT(53)
		DECLARE @k As INT
		DECLARE @hm As INT

		-- jdn_civil
		DECLARE @L AS INT
		DECLARE @n AS INT

		IF (@jdn > 2299160)
		BEGIN
			SET @L = @jdn + 68569
			SET @n = dbo.Fix((4 * @L) / CAST(146097 AS REAL))
			SET @L = @L - dbo.Fix((146097 * @n + 3) / CAST(4 AS REAL))
			SET @i = dbo.Fix((4000 * (@L + 1)) / CAST(1461001 AS REAL))
			SET @L = @L - dbo.Fix((1461 * @i) / CAST(4 AS REAL)) + 31
			SET @j = dbo.Fix((80 * @L) / CAST(2447 AS REAL))
			SET @ODay = @L - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @L = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @L
			SET @OYear = 100 * (@n - 49) + @i + @L
		END
		ELSE
		BEGIN
			-- jdn_julian
			SET @j = @jdn + 1402
			SET @k = dbo.Fix((@j - 1) / CAST(1461 AS REAL))
			SET @L = @j - 1461 * @k
			SET @n = dbo.Fix((@L - 1) / CAST(365 AS REAL)) - dbo.Fix(@L / CAST(1461 AS REAL))
			SET @i = @L - 365 * @n + 30
			SET @j = dbo.Fix((80 * @i) / CAST(2447 AS REAL))
			SET @ODay = @i - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @i = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @i
			SET @OYear = 4 * @k + @n + @i - 4716
		END
		
		SET @k = FLOOR(0.6 + (@OYear + CAST((@OMonth - 0.5) AS INT) / CAST(12 AS REAL) + @ODay / CAST(365 AS REAL) - 1900) * 12.3685)
	    
		WHILE (1 = 1)
		BEGIN
			SET @mjd = dbo.visibility(@k)
			SET @k = @k - 1
			IF NOT (@mjd > (@jdn - 0.5)) BREAK
		END
	    
		SET @k = @k + 1
		SET @hm = @k - 1048
		SET @OYear = 1405 + dbo.Fix(@hm / CAST(12 AS REAL))
		--@Year = 1405 + Int(@hm / 12)
	    
		SET @OMonth = (@hm % 12) + 1
		IF (@hm <> 0 And @OMonth <= 0)
		BEGIN
			SET @OMonth = @OMonth + 12
			SET @OYear = @OYear - 1
		END
		IF @OYear <= 0
			SET @OYear = @OYear - 1
		
		SET @ODay = FLOOR(@jdn - @mjd + 0.5)
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[UDateConvert_Hebrew2Christian]    Script Date: 08/16/2010 21:15:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UDateConvert_Hebrew2Christian]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE FUNCTION [dbo].[UDateConvert_Hebrew2Christian](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = ''/'') RETURNS CHAR(10)
AS
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- hebrew_civil
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.hebrew_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_civil
		DECLARE @L AS INT
		DECLARE @k AS INT
		DECLARE @n AS INT

		IF (@jdn > 2299160)
		BEGIN
			SET @L = @jdn + 68569
			SET @n = dbo.Fix((4 * @L) / CAST(146097 AS REAL))
			SET @L = @L - dbo.Fix((146097 * @n + 3) / CAST(4 AS REAL))
			SET @i = dbo.Fix((4000 * (@L + 1)) / CAST(1461001 AS REAL))
			SET @L = @L - dbo.Fix((1461 * @i) / CAST(4 AS REAL)) + 31
			SET @j = dbo.Fix((80 * @L) / CAST(2447 AS REAL))
			SET @ODay = @L - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @L = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @L
			SET @OYear = 100 * (@n - 49) + @i + @L
		END
		ELSE
		BEGIN
			-- jdn_julian
			SET @j = @jdn + 1402
			SET @k = dbo.Fix((@j - 1) / CAST(1461 AS REAL))
			SET @L = @j - 1461 * @k
			SET @n = dbo.Fix((@L - 1) / CAST(365 AS REAL)) - dbo.Fix(@L / CAST(1461 AS REAL))
			SET @i = @L - 365 * @n + 30
			SET @j = dbo.Fix((80 * @i) / CAST(2447 AS REAL))
			SET @ODay = @i - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @i = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @i
			SET @OYear = 4 * @k + @n + @i - 4716
		END
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Persian2Hebrew]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Persian2Hebrew]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Persian2Hebrew](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.persian_hebrew @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Julian2Hebrew]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Julian2Hebrew]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Julian2Hebrew](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.julian_hebrew @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Islamic2Hebrew]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Islamic2Hebrew]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Islamic2Hebrew](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.islamic_hebrew @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Hebrew2Persian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Hebrew2Persian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Hebrew2Persian](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.hebrew_persian @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Hebrew2Julian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Hebrew2Julian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Hebrew2Julian](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.hebrew_julian @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Hebrew2Islamic]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Hebrew2Islamic]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Hebrew2Islamic](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.hebrew_islamic @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Hebrew2Christian]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Hebrew2Christian]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Hebrew2Christian](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.hebrew_civil @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[PDateConvert_Christian2Hebrew]    Script Date: 08/16/2010 21:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PDateConvert_Christian2Hebrew]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
CREATE PROC [dbo].[PDateConvert_Christian2Hebrew](@Date VARCHAR(10),@Result CHAR(10) OUT, @SEPARATOR AS CHAR(1) = ''/'')
AS  
BEGIN
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	EXEC dbo.DateConvert_readDate @Date, @IYear OUT, @IMonth OUT, @IDay OUT, @SEPARATOR
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		EXEC dbo.civil_hebrew @IYear, @IMonth, @IDay, @OYear OUT, @OMonth OUT, @ODay OUT
		
		SET @Result =	RIGHT(''0000''	+ CAST(@OYear	AS VARCHAR(10)),4) + ''/'' + 
						RIGHT(''0''		+ CAST(@OMonth	AS VARCHAR(10)),2) + ''/'' + 
						RIGHT(''0''		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
END
' 
END
GO
