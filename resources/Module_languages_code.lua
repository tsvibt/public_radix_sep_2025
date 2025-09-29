
local table = table
local insert = table.insert
local u = mw.ustring.char

local export = {}

-- UTF-8 encoded strings for some commonly-used diacritics.
local c = {
	grave			= u(0x0300),
	acute			= u(0x0301),
	circ			= u(0x0302),
	tilde			= u(0x0303),
	macron			= u(0x0304),
	overline		= u(0x0305),
	breve			= u(0x0306),
	dotabove		= u(0x0307),
	diaer			= u(0x0308),
	ringabove		= u(0x030A),
	dacute			= u(0x030B),
	caron			= u(0x030C),
	lineabove		= u(0x030D),
	dgrave			= u(0x030F),
	invbreve		= u(0x0311),
	commaabove		= u(0x0313),
	revcommaabove	= u(0x0314),
	dotbelow		= u(0x0323),
	diaerbelow		= u(0x0324),
	ringbelow		= u(0x0325),
	cedilla			= u(0x0327),
	ogonek			= u(0x0328),
	brevebelow		= u(0x032E),
	macronbelow		= u(0x0331),
	perispomeni		= u(0x0342),
	ypogegrammeni	= u(0x0345),
	CGJ				= u(0x034F), -- combining grapheme joiner
	dbrevebelow		= u(0x035C),
	dinvbreve		= u(0x0361),
	kamora          = u(0x0484),
	dasiapneumata   = u(0x0485),
	psilipneumata   = u(0x0486),
	kashida			= u(0x0640),
	fathatan		= u(0x064B),
	dammatan		= u(0x064C),
	kasratan		= u(0x064D),
	fatha			= u(0x064E),
	damma			= u(0x064F),
	kasra			= u(0x0650),
	shadda			= u(0x0651),
	sukun			= u(0x0652),
	hamzaabove		= u(0x0654),
	nunghunna		= u(0x0658),
	smallv			= u(0x065A),
	superalef		= u(0x0670),
	psili			= u(0x1FBD),
	coronis			= u(0x1FBF),
	ZWNJ			= u(0x200C), -- zero width non-joiner
	ZWJ				= u(0x200D), -- zero width joiner
	RSQuo			= u(0x2019), -- right single quote
	VS01			= u(0xFE00), -- variation selector 1
	-- Punctuation for the standardChars field.
	punc			= " ',%-–…∅"
}
-- Braille characters for the standardChars field.
local braille = {}
for i = 0x2800, 0x28FF do
	insert(braille, u(i))
end
c.braille = table.concat(braille)
export.chars = c

-- PUA characters, generally used in sortkeys.
-- Note: if the limit needs to be increased, do so in powers of 2 (due to the way memory is allocated for tables).
local p = {}
for i = 1, 32 do
	p[i] = u(0xF000+i-1)
end
export.puaChars = p

local s = {}
-- These values are placed here to make it possible to synchronise a group of languages without the need for a dedicated function module.

s["cau-Cyrl-displaytext"] = {
	from = {"[IlІӀ]", "ᴴ"},
	to = {"ӏ", "ᵸ"}
}

s["cau-Cyrl-entryname"] = {
	remove_diacritics = c.grave .. c.acute .. c.macron,
	from = s["cau-Cyrl-displaytext"].from,
	to = s["cau-Cyrl-displaytext"].to
}

s["cau-Latn-entryname"] = {remove_diacritics = c.grave .. c.acute .. c.macron}

s["Cyrs-entryname"] = {remove_diacritics = c.grave .. c.acute ..  c.diaer .. c.kamora .. c.dasiapneumata .. c.psilipneumata}

s["Cyrs-sortkey"] = {
	from = {
		"ї", "оу", -- 2 chars
		"ґ", "ꙣ", "є", "[ѕꙃꙅ]", "ꙁ", "[іꙇ]", "[ђꙉ]", "[ѻꙩꙫꙭꙮꚙꚛ]", "ꙋ", "[ѡѿꙍѽ]", "ꙑ", "ѣ", "ꙗ", "ѥ", "ꙕ", "[ѧꙙ]", "[ѩꙝ]", "ꙛ", "ѫ", "ѭ", "ѯ", "ѱ", "ѳ", "ѵ", "ҁ" -- 1 char
	},
	to = {
		"и" .. p[1], "у",
		"г" .. p[1], "д" .. p[1], "е", "ж" .. p[1], "з", "и" .. p[1], "и" .. p[2], "о", "у", "х" .. p[1], "ы", "ь" .. p[1], "ь" .. p[2], "ь" .. p[3], "ю", "я", "я" .. p[1], "я" .. p[2], "я" .. p[3], "я" .. p[4], "я" .. p[5], "я" .. p[6], "я" .. p[7], "я" .. p[8], "я" .. p[9]
	},
}

s["Grek-sortkey"] = {
	remove_diacritics = c.grave .. c.acute .. c.diaer .. c.caron .. c.commaabove .. c.revcommaabove .. c.diaerbelow .. c.brevebelow .. c.perispomeni .. c.ypogegrammeni,
	from = {"ς"},
	to = {"σ"}
}

s["Jpan-sortkey"] = {
	Jpan = "Jpan-sortkey",
	Hani = "Hani-sortkey",
	Hrkt = "Hira-sortkey", -- sort general kana by normalizing to Hira
	Hira = "Hira-sortkey",
	Kana = "Kana-sortkey"
}

s["Jpan-translit"] = {
	Hrkt = "Hrkt-translit",
	Hira = "Hrkt-translit",
	Kana = "Hrkt-translit"
}

-- local HaniChars = require("Module:scripts").getByCode("Hani"):getCharacters()
s["Kore-entryname"] = {
	remove_diacritics = u(0x302E) .. u(0x302F),
-- 	from = {"([" .. HaniChars .. "])%(.-%)", "(.)%-(.)", "%([" .. HaniChars .. "]+%)"},
	to = {"%1", "%1%2"}
}

s["Mong-displaytext"] = {
	from = {"([ᠨ-ᡂᡸ])ᠶ([ᠨ-ᡂᡸ])", "([ᠠ-ᡂᡸ])ᠸ([^᠋ᠠ-ᠧ])", "([ᠠ-ᡂᡸ])ᠸ$"},
	to = {"%1ᠢ%2", "%1ᠧ%2", "%1ᠧ"}
}

s["Mong-entryname"] = s["Mong-displaytext"]

s["roa-oil-sortkey"] = {
	remove_diacritics = c.grave .. c.acute .. c.circ .. c.diaer .. c.ringabove .. c.cedilla .. "'",
	from = {"æ", "œ"},
	to = {"ae", "oe"}
}

s["Tibt-displaytext"] = {
	from = {"ༀ", "༌", "།།", "༚༚", "༚༝", "༝༚", "༝༝", "ཷ", "ཹ", "ེེ", "ོོ"},
	to = {"ཨོཾ", "་", "༎", "༛", "༟", "࿎", "༞", "ྲཱྀ", "ླཱྀ", "ཻ", "ཽ"}
}

s["Tibt-entryname"] = s["Tibt-displaytext"]

s["wen-sortkey"] = {
	from = {
		"l", -- Ensure "l" comes after "ł".
		"b́", "č", "ć", "dź", "ě", "f́", "ch", "ł", "ḿ", "ń", "ó", "ṕ", "ř", "ŕ", "š", "ś", "ẃ", "ž", "ż", "ź"
	},
	to = {
		"l" .. p[1],
		"b" .. p[1], "c" .. p[1], "c" .. p[2], "d" .. p[1], "e" .. p[1], "f" .. p[1], "h" .. p[1], "l", "m" .. p[1], "n" .. p[1], "o" .. p[1], "p" .. p[1], "r" .. p[1], "r" .. p[2], "s" .. p[1], "s" .. p[2], "w" .. p[1], "z" .. p[1], "z" .. p[2], "z" .. p[3]
	}
}

export.shared = s

-- Short-term solution to override the standard substitution process, by forcing the module to substitute the entire text in one pass. This results in any PUA characters that are used as stand-ins for formatting being handled by the language-specific substitution process, which is usually undesirable.
-- This override is provided for languages which use formatting between strings of text which might need to interact with each other (e.g. Korean 값이 transliterates as "gaps-i", but [[값]] has the formatting '''값'''[[-이]]. The normal process would split the text at the second '''.)
export.contiguous_substitution = {
	["ja"] = "tr",
	["jje"] = "tr",
	["ko"] = "tr",
	["ru"] = "tr",
}

return export
