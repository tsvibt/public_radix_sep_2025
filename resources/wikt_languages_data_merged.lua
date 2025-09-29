
function()
mw = {ustring = require 'ustring/ustring'}
local u = mw.ustring.char
local home = os.getenv("HOME")
local m_langdata = dofile(home .. "/radix/resources/Module_languages_code.lua")
local c = m_langdata.chars
local p = m_langdata.puaChars
local s = m_langdata.shared
-- Ideally, we want to move these into [[Module:languages/data]], but because (a) it's necessary to use require on that module, and (b) they're only used in this data module, it's less memory-efficient to do that at the moment. If it becomes possible to use mw.loadData, then these should be moved there.
s["no-sortkey"] = {
 remove_diacritics = c.grave .. c.acute .. c.circ .. c.tilde .. c.macron .. c.dacute .. c.caron .. c.cedilla,
 remove_exceptions = {"å"},
 from = {"æ", "ø", "å"},
 to = {"z" .. p[1], "z" .. p[2], "z" .. p[3]}
}
s["no-standardchars"] = "AaBbDdEeFfGgHhIiJjKkLlMmNnOoPpRrSsTtUuVvYyÆæØøÅå" .. c.punc
s["ru-Cyrl-entryname"] = {
 remove_diacritics = c.grave .. c.acute .. c.diaer,
 remove_exceptions = {"Ё", "ё", "Ѣ̈", "ѣ̈", "Я̈", "я̈"}
}
s["ru-Cyrl-sortkey"] = {
 from = {
  "ё", "ѣ̈", "я̈", -- 2 chars
  "і", "ѣ", "ѳ", "ѵ" -- 1 char
 },
 to = {
  "е" .. p[1], "ь" .. p[2], "я" .. p[1],
  "и" .. p[1], "ь" .. p[1], "я" .. p[2], "я" .. p[3]
 }
}
local m = {}
m["aa"] = {
 "Afar",
 27811,
 "cus-eas",
 "Latn",
 entry_name = {remove_diacritics = c.acute},
}
m["ab"] = {
 "Abkhaz",
 5111,
 "cau-abz",
 "Cyrl, Geor, Latn",
 translit = {
  Cyrl = "ab-translit",
  Geor = "Geor-translit",
 },
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
 sort_key = {
  Cyrl = {
   from = {
    "х'ә", -- 3 chars
    "гь", "гә", "ӷь", "ҕь", "ӷә", "ҕә", "дә", "ё", "жь", "жә", "ҙә", "ӡә", "ӡ'", "кь", "кә", "қь", "қә", "ҟь", "ҟә", "ҫә", "тә", "ҭә", "ф'", "хь", "хә", "х'", "ҳә", "ць", "цә", "ц'", "ҵә", "ҵ'", "шь", "шә", "џь", -- 2 chars
    "ӷ", "ҕ", "ҙ", "ӡ", "қ", "ҟ", "ԥ", "ҧ", "ҫ", "ҭ", "ҳ", "ҵ", "ҷ", "ҽ", "ҿ", "ҩ", "џ", "ә" -- 1 char
   },
   to = {
    "х" .. p[4],
    "г" .. p[1], "г" .. p[2], "г" .. p[5], "г" .. p[6], "г" .. p[7], "г" .. p[8], "д" .. p[1], "е" .. p[1], "ж" .. p[1], "ж" .. p[2], "з" .. p[2], "з" .. p[4], "з" .. p[5], "к" .. p[1], "к" .. p[2], "к" .. p[4], "к" .. p[5], "к" .. p[7], "к" .. p[8], "с" .. p[2], "т" .. p[1], "т" .. p[3], "ф" .. p[1], "х" .. p[1], "х" .. p[2], "х" .. p[3], "х" .. p[6], "ц" .. p[1], "ц" .. p[2], "ц" .. p[3], "ц" .. p[5], "ц" .. p[6], "ш" .. p[1], "ш" .. p[2], "ы" .. p[3],
    "г" .. p[3], "г" .. p[4], "з" .. p[1], "з" .. p[3], "к" .. p[3], "к" .. p[6], "п" .. p[1], "п" .. p[2], "с" .. p[1], "т" .. p[2], "х" .. p[5], "ц" .. p[4], "ч" .. p[1], "ч" .. p[2], "ч" .. p[3], "ы" .. p[1], "ы" .. p[2], "ь" .. p[1]
   }
  },
 },
}
m["ae"] = {
 "Avestan",
 29572,
 "ira-cen",
 "Avst, Gujr",
 translit = {Avst = "Avst-translit"},
 wikipedia_article = "Avestan",
}
m["af"] = {
 "Afrikaans",
 14196,
 "gmw",
 "Latn, Arab",
 ancestors = "nl",
 sort_key = {
  Latn = {
   remove_diacritics = c.grave .. c.acute .. c.circ .. c.tilde .. c.diaer .. c.ringabove .. c.cedilla .. "'",
   from = {"['ʼ]n"},
   to = {"n" .. p[1]}
  }
 },
}
m["ak"] = {
 "Akan",
 28026,
 "alv-ctn",
 "Latn",
}
m["am"] = {
 "Amharic",
 28244,
 "sem-eth",
 "Ethi",
 translit = "Ethi-translit",
}
m["an"] = {
 "Aragonese",
 8765,
 "roa-ibe",
 "Latn",
 ancestors = "roa-oan",
}
m["ar"] = {
 "Arabic",
 13955,
 "sem-arb",
 "Arab, Hebr, Syrc, Brai",
 translit = {Arab = "ar-translit"},
 entry_name = {Arab = "ar-entryname"},
 -- put Judeo-Arabic (Hebrew-script Arabic) under the category header
 -- U+FB21 HEBREW LETTER WIDE ALEF so that it sorts after Arabic script titles
 sort_key = {
  Hebr = {
   from = {"^%f[" .. u(0x5D0) .. "-" .. u(0x5EA) .. "]"},
   to = {u(0xFB21)},
  },
 },
}
m["as"] = {
 "Assamese",
 29401,
 "inc-eas",
 "as-Beng",
 ancestors = "inc-mas",
 translit = "as-translit",
}
m["av"] = {
 "Avar",
 29561,
 "cau-ava",
 "Cyrl, Latn, Arab",
 ancestors = "oav",
 translit = {
  Cyrl = "cau-nec-translit",
  Arab = "ar-translit",
 },
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
 sort_key = {
  Cyrl = {
   from = {"гъ", "гь", "гӏ", "ё", "кк", "къ", "кь", "кӏ", "лъ", "лӏ", "тӏ", "хх", "хъ", "хь", "хӏ", "цӏ", "чӏ"},
   to = {"г" .. p[1], "г" .. p[2], "г" .. p[3], "е" .. p[1], "к" .. p[1], "к" .. p[2], "к" .. p[3], "к" .. p[4], "л" .. p[1], "л" .. p[2], "т" .. p[1], "х" .. p[1], "х" .. p[2], "х" .. p[3], "х" .. p[4], "ц" .. p[1], "ч" .. p[1]}
  },
 },
}
m["ay"] = {
 "Aymara",
 4627,
 "sai-aym",
 "Latn",
}
m["az"] = {
 "Azerbaijani",
 9292,
 "trk-ogz",
 "Latn, Cyrl, fa-Arab",
 ancestors = "trk-oat",
 dotted_dotless_i = true,
 entry_name = {["fa-Arab"] = "ar-entryname"},
 sort_key = {
  Latn = {
   from = {
    "i", -- Ensure "i" comes after "ı".
    "ç", "ə", "ğ", "x", "ı", "q", "ö", "ş", "ü", "w"
   },
   to = {
    "i" .. p[1],
    "c" .. p[1], "e" .. p[1], "g" .. p[1], "h" .. p[1], "i", "k" .. p[1], "o" .. p[1], "s" .. p[1], "u" .. p[1], "z" .. p[1]
   }
  },
  Cyrl = {
   from = {"ғ", "ә", "ы", "ј", "ҝ", "ө", "ү", "һ", "ҹ"},
   to = {"г" .. p[1], "е" .. p[1], "и" .. p[1], "и" .. p[2], "к" .. p[1], "о" .. p[1], "у" .. p[1], "х" .. p[1], "ч" .. p[1]}
  },
 },
}
m["ba"] = {
 "Bashkir",
 13389,
 "trk-kbu",
 "Cyrl",
 translit = "ba-translit",
 override_translit = true,
 sort_key = {
  from = {"ғ", "ҙ", "ё", "ҡ", "ң", "ө", "ҫ", "ү", "һ", "ә"},
  to = {"г" .. p[1], "д" .. p[1], "е" .. p[1], "к" .. p[1], "н" .. p[1], "о" .. p[1], "с" .. p[1], "у" .. p[1], "х" .. p[1], "э" .. p[1]}
 },
}
m["be"] = {
 "Belarusian",
 9091,
 "zle",
 "Cyrl, Latn",
 ancestors = "zle-obe",
 translit = {Cyrl = "be-translit"},
 entry_name = {
  remove_diacritics = c.grave .. c.acute,
  remove_exceptions = {"Ć", "ć", "Ń", "ń", "Ś", "ś", "Ź", "ź"},
 },
 sort_key = {
  Cyrl = {
   from = {"ґ", "ё", "і", "ў"},
   to = {"г" .. p[1], "е" .. p[1], "и" .. p[1], "у" .. p[1]}
  },
  Latn = {
   from = {"ć", "č", "dz", "dź", "dž", "ch", "ł", "ń", "ś", "š", "ŭ", "ź", "ž"},
   to = {"c" .. p[1], "c" .. p[2], "d" .. p[1], "d" .. p[2], "d" .. p[3], "h" .. p[1], "l" .. p[1], "n" .. p[1], "s" .. p[1], "s" .. p[2], "u" .. p[1], "z" .. p[1], "z" .. p[2]}
  },
 },
 standardChars = {
  Cyrl = "АаБбВвГгДдЕеЁёЖжЗзІіЙйКкЛлМмНнОоПпРрСсТтУуЎўФфХхЦцЧчШшЫыЬьЭэЮюЯя",
  Latn = "AaBbCcĆćČčDdEeFfGgHhIiJjKkLlŁłMmNnŃńOoPpRrSsŚśŠšTtUuŬŭVvYyZzŹźŽž",
  c.punc
 },
}
m["bg"] = {
 "Bulgarian",
 7918,
 "zls",
 "Cyrl",
 ancestors = "cu-bgm",
 translit = "bg-translit",
 entry_name = {
  remove_diacritics = c.grave .. c.acute,
  remove_exceptions = {"%f[^%z%s]ѝ%f[%z%s]"},
 },
 standardChars = "АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЩщЪъЬьЮюЯя" .. c.punc,
}
m["bh"] = {
 "Bihari",
 135305,
 "inc-eas",
 "Deva",
 ancestors = "pra-mag",
}
m["bi"] = {
 "Bislama",
 35452,
 "crp",
 "Latn",
 ancestors = "en",
}
m["bm"] = {
 "Bambara",
 33243,
 "dmn-emn",
 "Latn",
 sort_key = {
  from = {"ɛ", "ɲ", "ŋ", "ɔ"},
  to = {"e" .. p[1], "n" .. p[1], "n" .. p[2], "o" .. p[1]}
 },
}
m["bn"] = {
 "Bengali",
 9610,
 "inc-eas",
 "Beng, Newa",
 ancestors = "inc-mbn",
 translit = {Beng = "bn-translit"},
}
m["bo"] = {
 "Tibetan",
 34271,
 "sit-tib",
 "Tibt", -- sometimes Deva?
 ancestors = "xct",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["br"] = {
 "Breton",
 12107,
 "cel-bry",
 "Latn",
 ancestors = "xbm",
 sort_key = {
  from = {"ch", "c['ʼ’]h"},
  to = {"c" .. p[1], "c" .. p[2]}
 },
}
m["ca"] = {
 "Catalan",
 7026,
 "roa-ocr",
 "Latn",
 ancestors = "roa-oca",
 sort_key = {
  remove_diacritics = c.grave .. c.acute .. c.diaer .. c.cedilla,
  from = {"l·l"},
  to = {"ll"}
 },
 standardChars = "AaÀàBbCcÇçDdEeÉéÈèFfGgHhIiÍíÏïJjLlMmNnOoÓóÒòPpQqRrSsTtUuÚúÜüVvXxYyZz·" .. c.punc,
}
m["ce"] = {
 "Chechen",
 33350,
 "cau-vay",
 "Cyrl, Latn, Arab",
 translit = {
  Cyrl = "cau-nec-translit",
  Arab = "ar-translit",
 },
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
 sort_key = {
  Cyrl = {
   from = {"аь", "гӏ", "ё", "кх", "къ", "кӏ", "оь", "пӏ", "тӏ", "уь", "хь", "хӏ", "цӏ", "чӏ", "юь", "яь"},
   to = {"а" .. p[1], "г" .. p[1], "е" .. p[1], "к" .. p[1], "к" .. p[2], "к" .. p[3], "о" .. p[1], "п" .. p[1], "т" .. p[1], "у" .. p[1], "х" .. p[1], "х" .. p[2], "ц" .. p[1], "ч" .. p[1], "ю" .. p[1], "я" .. p[1]}
  },
 },
}
m["ch"] = {
 "Chamorro",
 33262,
 "poz-sus",
 "Latn",
 sort_key = {
  remove_diacritics = "'",
  from = {"å", "ch", "ñ", "ng"},
  to = {"a" .. p[1], "c" .. p[1], "n" .. p[1], "n" .. p[2]}
 },
}
m["co"] = {
 "Corsican",
 33111,
 "roa-itd",
 "Latn",
 sort_key = {
  from = {"chj", "ghj", "sc", "sg"},
  to = {"c" .. p[1], "g" .. p[1], "s" .. p[1], "s" .. p[2]}
 },
 standardChars = "AaÀàBbCcDdEeÈèFfGgHhIiÌìÏïJjLlMmNnOoÒòPpQqRrSsTtUuÙùÜüVvZz" .. c.punc,
}
m["cr"] = {
 "Cree",
 33390,
 "alg",
 "Cans, Latn",
 translit = {Cans = "cr-translit"},
}
m["cs"] = {
 "Czech",
 9056,
 "zlw",
 "Latn",
 ancestors = "cs-ear",
 sort_key = {
  from = {"á", "č", "ď", "é", "ě", "ch", "í", "ň", "ó", "ř", "š", "ť", "ú", "ů", "ý", "ž"},
  to = {"a" .. p[1], "c" .. p[1], "d" .. p[1], "e" .. p[1], "e" .. p[2], "h" .. p[1], "i" .. p[1], "n" .. p[1], "o" .. p[1], "r" .. p[1], "s" .. p[1], "t" .. p[1], "u" .. p[1], "u" .. p[2], "y" .. p[1], "z" .. p[1]}
 },
 standardChars = "AaÁáBbCcČčDdĎďEeÉéĚěFfGgHhIiÍíJjKkLlMmNnŇňOoÓóPpRrŘřSsŠšTtŤťUuÚúŮůVvYyÝýZzŽž" .. c.punc,
}
m["cu"] = {
 "Old Church Slavonic",
 35499,
 "zls",
 "Cyrs, Glag",
 translit = {Cyrs = "Cyrs-translit", Glag = "Glag-translit"},
 entry_name = {Cyrs = s["Cyrs-entryname"]},
 sort_key = {Cyrs = s["Cyrs-sortkey"]},
}
m["cv"] = {
 "Chuvash",
 33348,
 "trk-ogr",
 "Cyrl",
 ancestors = "xbo",
 translit = "cv-translit",
 override_translit = true,
 sort_key = {
  from = {"ӑ", "ё", "ӗ", "ҫ", "ӳ"},
  to = {"а" .. p[1], "е" .. p[1], "е" .. p[2], "с" .. p[1], "у" .. p[1]}
 },
}
m["cy"] = {
 "Welsh",
 9309,
 "cel-bry",
 "Latn",
 ancestors = "wlm",
 sort_key = {
  remove_diacritics = c.grave .. c.acute .. c.circ .. c.diaer .. "'",
  from = {"ch", "dd", "ff", "ng", "ll", "ph", "rh", "th"},
  to = {"c" .. p[1], "d" .. p[1], "f" .. p[1], "g" .. p[1], "l" .. p[1], "p" .. p[1], "r" .. p[1], "t" .. p[1]}
 },
 standardChars = "ÂâAaBbCcDdEeÊêFfGgHhIiÎîLlMmNnOoÔôPpRrSsTtUuÛûWwŴŵYyŶŷ" .. c.punc,
}
m["da"] = {
 "Danish",
 9035,
 "gmq",
 "Latn",
 ancestors = "gmq-oda",
 sort_key = {
  remove_diacritics = c.grave .. c.acute .. c.circ .. c.tilde .. c.macron .. c.dacute .. c.caron .. c.cedilla,
  remove_exceptions = {"å"},
  from = {"æ", "ø", "å"},
  to = {"z" .. p[1], "z" .. p[2], "z" .. p[3]}
 },
 standardChars = "AaBbDdEeFfGgHhIiJjKkLlMmNnOoPpRrSsTtUuVvYyÆæØøÅå" .. c.punc,
}
m["de"] = {
 "German",
 188,
 "gmw",
 "Latn, Latf",
 ancestors = "gmh",
 sort_key = {
  remove_diacritics = c.grave .. c.acute .. c.circ .. c.diaer .. c.ringabove,
  from = {"ß"},
  to = {"ss"}
 },
 standardChars = "AaÄäBbCcDdEeFfGgHhIiJjKkLlMmNnOoÖöPpQqRrSsẞßTtUuÜüVvWwXxYyZz" .. c.punc,
}
m["dv"] = {
 "Dhivehi",
 32656,
 "inc-ins",
 "Thaa, Diak",
 ancestors = "pra-hel",
 translit = {
  Thaa = "dv-translit",
  Diak = "Diak-translit",
 },
 override_translit = true,
}
m["dz"] = {
 "Dzongkha",
 33081,
 "sit-tib",
 "Tibt",
 ancestors = "xct",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["ee"] = {
 "Ewe",
 30005,
 "alv-gbe",
 "Latn",
 sort_key = {
  remove_diacritics = c.tilde,
  from = {"ɖ", "dz", "ɛ", "ƒ", "gb", "ɣ", "kp", "ny", "ŋ", "ɔ", "ts", "ʋ"},
  to = {"d" .. p[1], "d" .. p[2], "e" .. p[1], "f" .. p[1], "g" .. p[1], "g" .. p[2], "k" .. p[1], "n" .. p[1], "n" .. p[2], "o" .. p[1], "t" .. p[1], "v" .. p[1]}
 },
}
m["el"] = {
 "Greek",
 9129,
 "grk",
 "Grek, Polyt, Brai",
 ancestors = "el-kth",
 translit = {
  Grek = "el-translit",
  Polyt = "grc-translit",
 },
 override_translit = true,
 entry_name = {
  Grek = {remove_diacritics = c.caron .. c.diaerbelow .. c.brevebelow},
  Polyt = {
   remove_diacritics = c.macron .. c.breve .. c.dbrevebelow,
   from = {"[" .. c.RSQuo .. c.psili .. c.coronis .. "]"},
   to = {"'"}
  },
 },
 sort_key = {
  Grek = s["Grek-sortkey"],
  Polyt = s["Grek-sortkey"],
 },
 standardChars = {
  Grek = "΅·ͺ΄ΑαΆάΒβΓγΔδΕεέΈΖζΗηΉήΘθΙιΊίΪϊΐΚκΛλΜμΝνΞξΟοΌόΠπΡρΣσςΤτΥυΎύΫϋΰΦφΧχΨψΩωΏώ",
  Brai = c.braille,
  c.punc
 },
}
m["en"] = {
 "English",
 1860,
 "gmw",
 "Latn, Brai, Shaw, Dsrt", -- entries in Shaw or Dsrt might require prior discussion
 wikimedia_codes = "en, simple",
 ancestors = "enm",
 sort_key = {
  Latn = {
   remove_diacritics = c.grave .. c.acute .. c.circ .. c.tilde .. c.macron .. c.diaer .. c.ringabove .. c.caron .. c.cedilla .. "'%-%s",
   from = {"æ", "œ"},
   to = {"ae", "oe"}
  },
 },
 standardChars = {
  Latn = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz",
  Brai = c.braille,
  c.punc
 },
}
m["eo"] = {
 "Esperanto",
 143,
 "art",
 "Latn",
 sort_key = {
  remove_diacritics = c.grave .. c.acute,
  from = {"ĉ", "ĝ", "ĥ", "ĵ", "ŝ", "ŭ"},
  to = {"c" .. p[1], "g" .. p[1], "h" .. p[1], "j" .. p[1], "s" .. p[1], "u" .. p[1]}
 },
 standardChars = "AaBbCcĈĉDdEeFfGgĜĝHhĤĥIiJjĴĵKkLlMmNnOoPpRrSsŜŝTtUuŬŭVvZz" .. c.punc,
}
m["es"] = {
 "Spanish",
 1321,
 "roa-ibe",
 "Latn, Brai",
 ancestors = "osp",
 sort_key = {
  Latn = {
   remove_diacritics = c.acute .. c.diaer .. c.cedilla,
   from = {"ñ"},
   to = {"n" .. p[1]}
  },
 },
 standardChars = {
  Latn = "AaÁáBbCcDdEeÉéFfGgHhIiÍíJjLlMmNnÑñOoÓóPpQqRrSsTtUuÚúÜüVvXxYyZz",
  Brai = c.braille,
  c.punc
 },
}
m["et"] = {
 "Estonian",
 9072,
 "urj-fin",
 "Latn",
 sort_key = {
  from = {
   "š", "ž", "õ", "ä", "ö", "ü", -- 2 chars
   "z" -- 1 char
  },
  to = {
   "s" .. p[1], "s" .. p[3], "w" .. p[1], "w" .. p[2], "w" .. p[3], "w" .. p[4],
   "s" .. p[2]
  }
 },
 standardChars = "AaBbDdEeFfGgHhIiJjKkLlMmNnOoPpRrSsTtUuVvÕõÄäÖöÜü" .. c.punc,
}
m["eu"] = {
 "Basque",
 8752,
 "euq",
 "Latn",
 sort_key = {
  from = {"ç", "ñ"},
  to = {"c" .. p[1], "n" .. p[1]}
 },
 standardChars = "AaBbDdEeFfGgHhIiJjKkLlMmNnÑñOoPpRrSsTtUuXxZz" .. c.punc,
}
m["fa"] = {
 "Persian",
 9168,
 "ira-swi",
 "fa-Arab",
 ancestors = "fa-cls",
 entry_name = {
  from = {"هٔ", "ٱ"}, -- character "ۂ" code U+06C2 to "ه"; hamzatu l-waṣli to a regular alif
  to = {"ه", "ا"},
  remove_diacritics = c.fathatan .. c.dammatan .. c.kasratan .. c.kashida .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun .. c.superalef,
 },
}
m["ff"] = {
 "Fula",
 33454,
 "alv-fwo",
 "Latn, Adlm",
}
m["fi"] = {
 "Finnish",
 1412,
 "urj-fin",
 "Latn",
 display_text = {
  from = {"'"},
  to = {"’"}
 },
 entry_name = { -- used to indicate gemination of the next consonant
  remove_diacritics = "ˣ",
  from = {"’"},
  to = {"'"},
 },
 sort_key = {
  remove_diacritics = c.grave .. c.acute .. c.circ .. c.tilde .. c.macron .. c.dacute .. c.caron .. c.cedilla .. "':",
  remove_exceptions = {"å"},
  from = {"ø", "æ", "œ", "ß", "å", "(.)%-"},
  to = {"o", "ae", "oe", "ss", "z" .. p[1], "%1"}
 },
 standardChars = "AaBbDdEeFfGgHhIiJjKkLlMmNnOoPpRrSsTtUuVvYyÄäÖö" .. c.punc,
}
m["fj"] = {
 "Fijian",
 33295,
 "poz-occ",
 "Latn",
}
m["fo"] = {
 "Faroese",
 25258,
 "gmq",
 "Latn",
 ancestors = "non",
 sort_key = {
  from = {"á", "ð", "í", "ó", "ú", "ý", "æ", "ø"},
  to = {"a" .. p[1], "d" .. p[1], "i" .. p[1], "o" .. p[1], "u" .. p[1], "y" .. p[1], "z" .. p[1], "z" .. p[2]}
 },
 standardChars = "AaÁáBbDdÐðEeFfGgHhIiÍíJjKkLlMmNnOoÓóPpRrSsTtUuÚúVvYyÝýÆæØø" .. c.punc,
}
m["fr"] = {
 "French",
 150,
 "roa-oil",
 "Latn, Brai",
 display_text = {
  from = {"'"},
  to = {"’"}
 },
 entry_name = {
  from = {"’"},
  to = {"'"},
 },
 ancestors = "frm",
 sort_key = {Latn = s["roa-oil-sortkey"]},
 standardChars = {
  Latn = "AaÀàÂâBbCcÇçDdEeÉéÈèÊêËëFfGgHhIiÎîÏïJjLlMmNnOoÔôŒœPpQqRrSsTtUuÙùÛûÜüVvXxYyZz",
  Brai = c.braille,
  c.punc
 },
}
m["fy"] = {
 "West Frisian",
 27175,
 "gmw-fri",
 "Latn",
 ancestors = "ofs",
 sort_key = {
  remove_diacritics = c.grave .. c.acute .. c.circ .. c.diaer,
  from = {"y"},
  to = {"i"}
 },
 standardChars = "AaâäàÆæBbCcDdEeéêëèFfGgHhIiïìYyỳJjKkLlMmNnOoôöòPpRrSsTtUuúûüùVvWwZz" .. c.punc,
}
m["ga"] = {
 "Irish",
 9142,
 "cel-gae",
 "Latn, Latg",
 ancestors = "mga",
 sort_key = {
  remove_diacritics = c.acute,
  from = {"ḃ", "ċ", "ḋ", "ḟ", "ġ", "ṁ", "ṗ", "ṡ", "ṫ"},
  to = {"bh", "ch", "dh", "fh", "gh", "mh", "ph", "sh", "th"}
 },
 standardChars = "AaÁáBbCcDdEeÉéFfGgHhIiÍíLlMmNnOoÓóPpRrSsTtUuÚúVv" .. c.punc,
}
m["gd"] = {
 "Scottish Gaelic",
 9314,
 "cel-gae",
 "Latn, Latg",
 ancestors = "mga",
 sort_key = {remove_diacritics = c.grave .. c.acute},
 standardChars = "AaÀàBbCcDdEeÈèFfGgHhIiÌìLlMmNnOoÒòPpRrSsTtUuÙù" .. c.punc,
}
m["gl"] = {
 "Galician",
 9307,
 "roa-ibe",
 "Latn",
 ancestors = "roa-opt",
 sort_key = {
  remove_diacritics = c.acute,
  from = {"ñ"},
  to = {"n" .. p[1]}
 },
 standardChars = "AaÁáBbCcDdEeÉéFfGgHhIiÍíÏïLlMmNnÑñOoÓóPpQqRrSsTtUuÚúÜüVvXxZz" .. c.punc,
}
m["gn"] = {
 "Guaraní",
 35876,
 "tup-gua",
 "Latn",
}
m["gu"] = {
 "Gujarati",
 5137,
 "inc-wes",
 "Arab, Gujr",
 ancestors = "inc-mgu",
 translit = {
  Gujr = "gu-translit",
 },
 entry_name = {
  remove_diacritics = c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.kasra .. c.shadda .. c.sukun .. "઼"
 },
}
m["gv"] = {
 "Manx",
 12175,
 "cel-gae",
 "Latn",
 ancestors = "mga",
 sort_key = {remove_diacritics = c.cedilla .. "-"},
 standardChars = "AaBbCcÇçDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwYy" .. c.punc,
}
m["ha"] = {
 "Hausa",
 56475,
 "cdc-wst",
 "Latn, Arab",
 entry_name = {Latn = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.tilde .. c.macron}},
 sort_key = {
  Latn = {
   from = {"ɓ", "b'", "ɗ", "d'", "ƙ", "k'", "sh", "ƴ", "'y"},
   to = {"b" .. p[1], "b" .. p[2], "d" .. p[1], "d" .. p[2], "k" .. p[1], "k" .. p[2], "s" .. p[1], "y" .. p[1], "y" .. p[2]}
  },
 },
}
m["he"] = {
 "Hebrew",
 9288,
 "sem-can",
 "Hebr, Phnx, Brai",
 ancestors = "he-med",
 entry_name = {Hebr = {remove_diacritics = u(0x0591) .. "-" .. u(0x05BD) .. u(0x05BF) .. "-" .. u(0x05C5) .. u(0x05C7) .. c.CGJ}},
}
m["hi"] = {
 "Hindi",
 1568,
 "inc-hnd",
 "Deva, Kthi, Newa",
 ancestors = "inc-ohi",
 translit = {Deva = "hi-translit"},
 standardChars = {
  Deva = "अआइईउऊएऐओऔकखगघङचछजझञटठडढणतथदधनपफबभमयरलवशषसहत्रज्ञक्षक़ख़ग़ज़झ़ड़ढ़फ़काखागाघाङाचाछाजाझाञाटाठाडाढाणाताथादाधानापाफाबाभामायारालावाशाषासाहात्राज्ञाक्षाक़ाख़ाग़ाज़ाझ़ाड़ाढ़ाफ़ाकिखिगिघिङिचिछिजिझिञिटिठिडिढिणितिथिदिधिनिपिफिबिभिमियिरिलिविशिषिसिहित्रिज्ञिक्षिक़िख़िग़िज़िझ़िड़िढ़िफ़िकीखीगीघीङीचीछीजीझीञीटीठीडीढीणीतीथीदीधीनीपीफीबीभीमीयीरीलीवीशीषीसीहीत्रीज्ञीक्षीक़ीख़ीग़ीज़ीझ़ीड़ीढ़ीफ़ीकुखुगुघुङुचुछुजुझुञुटुठुडुढुणुतुथुदुधुनुपुफुबुभुमुयुरुलुवुशुषुसुहुत्रुज्ञुक्षुक़ुख़ुग़ुज़ुझ़ुड़ुढ़ुफ़ुकूखूगूघूङूचूछूजूझूञूटूठूडूढूणूतूथूदूधूनूपूफूबूभूमूयूरूलूवूशूषूसूहूत्रूज्ञूक्षूक़ूख़ूग़ूज़ूझ़ूड़ूढ़ूफ़ूकेखेगेघेङेचेछेजेझेञेटेठेडेढेणेतेथेदेधेनेपेफेबेभेमेयेरेलेवेशेषेसेहेत्रेज्ञेक्षेक़ेख़ेग़ेज़ेझ़ेड़ेढ़ेफ़ेकैखैगैघैङैचैछैजैझैञैटैठैडैढैणैतैथैदैधैनैपैफैबैभैमैयैरैलैवैशैषैसैहैत्रैज्ञैक्षैक़ैख़ैग़ैज़ैझ़ैड़ैढ़ैफ़ैकोखोगोघोङोचोछोजोझोञोटोठोडोढोणोतोथोदोधोनोपोफोबोभोमोयोरोलोवोशोषोसोहोत्रोज्ञोक्षोक़ोख़ोग़ोज़ोझ़ोड़ोढ़ोफ़ोकौखौगौघौङौचौछौजौझौञौटौठौडौढौणौतौथौदौधौनौपौफौबौभौमौयौरौलौवौशौषौसौहौत्रौज्ञौक्षौक़ौख़ौग़ौज़ौझ़ौड़ौढ़ौफ़ौक्ख्ग्घ्ङ्च्छ्ज्झ्ञ्ट्ठ्ड्ढ्ण्त्थ्द्ध्न्प्फ्ब्भ्म्य्र्ल्व्श्ष्स्ह्त्र्ज्ञ्क्ष्क़्ख़्ग़्ज़्झ़्ड़्ढ़्फ़्।॥०१२३४५६७८९॰",
  c.punc
 },
}
m["ho"] = {
 "Hiri Motu",
 33617,
 "crp",
 "Latn",
 ancestors = "meu",
}
m["ht"] = {
 "Haitian Creole",
 33491,
 "crp",
 "Latn",
 ancestors = "ht-sdm",
 sort_key = {
  from = {
   "oun", -- 3 chars
   "an", "ch", "è", "en", "ng", "ò", "on", "ou", "ui" -- 2 chars
  },
  to = {
   "o" .. p[4],
   "a" .. p[1], "c" .. p[1], "e" .. p[1], "e" .. p[2], "n" .. p[1], "o" .. p[1], "o" .. p[2], "o" .. p[3], "u" .. p[1]
  }
 },
}
m["hu"] = {
 "Hungarian",
 9067,
 "urj-ugr",
 "Latn, Hung",
 ancestors = "ohu",
 sort_key = {
  Latn = {
   from = {
    "dzs", -- 3 chars
    "á", "cs", "dz", "é", "gy", "í", "ly", "ny", "ó", "ö", "ő", "sz", "ty", "ú", "ü", "ű", "zs", -- 2 chars
   },
   to = {
    "d" .. p[2],
    "a" .. p[1], "c" .. p[1], "d" .. p[1], "e" .. p[1], "g" .. p[1], "i" .. p[1], "l" .. p[1], "n" .. p[1], "o" .. p[1], "o" .. p[2], "o" .. p[3], "s" .. p[1], "t" .. p[1], "u" .. p[1], "u" .. p[2], "u" .. p[3], "z" .. p[1],
   }
  },
 },
 standardChars = {
  Latn = "AaÁáBbCcDdEeÉéFfGgHhIiÍíJjKkLlMmNnOoÓóÖöŐőPpQqRrSsTtUuÚúÜüŰűVvWwXxYyZz",
  c.punc
 },
}
m["hy"] = {
 "Armenian",
 8785,
 "hyx",
 "Armn, Brai",
 ancestors = "axm",
 translit = {Armn = "Armn-translit"},
 override_translit = true,
 entry_name = {
  Armn = {
   remove_diacritics = "՛՜՞՟",
   from = {"եւ", "<sup>յ</sup>", "<sup>ի</sup>", "<sup>է</sup>"},
   to = {"և", "յ", "ի", "է"}
  },
 },
 sort_key = {
  Armn = {
   from = {
    "ու", "եւ", -- 2 chars
    "և" -- 1 char
   },
   to = {
    "ւ", "եվ",
    "եվ"
   }
  },
 },
}
m["hz"] = {
 "Herero",
 33315,
 "bnt-swb",
 "Latn",
}
m["ia"] = {
 "Interlingua",
 35934,
 "art",
 "Latn",
}
m["id"] = {
 "Indonesian",
 9240,
 "poz-mly",
 "Latn",
 ancestors = "ms",
 standardChars = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz" .. c.punc,
}
m["ie"] = {
 "Interlingue",
 35850,
 "art",
 "Latn",
 type = "appendix-constructed",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ},
}
m["ig"] = {
 "Igbo",
 33578,
 "alv-igb",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.macron},
 sort_key = {
  from = {"gb", "gh", "gw", "ị", "kp", "kw", "ṅ", "nw", "ny", "ọ", "sh", "ụ"},
  to = {"g" .. p[1], "g" .. p[2], "g" .. p[3], "i" .. p[1], "k" .. p[1], "k" .. p[2], "n" .. p[1], "n" .. p[2], "n" .. p[3], "o" .. p[1], "s" .. p[1], "u" .. p[1]}
 },
}
m["ii"] = {
 "Sichuan Yi",
 34235,
 "tbq-lol",
 "Yiii",
 translit = "ii-translit",
}
m["ik"] = {
 "Inupiaq",
 27183,
 "esx-inu",
 "Latn",
 sort_key = {
  from = {
   "ch", "ġ", "dj", "ḷ", "ł̣", "ñ", "ng", "r̂", "sr", "zr", -- 2 chars
   "ł", "ŋ", "ʼ" -- 1 char
  },
  to = {
   "c" .. p[1], "g" .. p[1], "h" .. p[1], "l" .. p[1], "l" .. p[3], "n" .. p[1], "n" .. p[2], "r" .. p[1], "s" .. p[1], "z" .. p[1],
   "l" .. p[2], "n" .. p[2], "z" .. p[2]
  }
 },
}
m["io"] = {
 "Ido",
 35224,
 "art",
 "Latn",
}
m["is"] = {
 "Icelandic",
 294,
 "gmq",
 "Latn",
 ancestors = "non",
 sort_key = {
  from = {"á", "ð", "é", "í", "ó", "ú", "ý", "þ", "æ", "ö"},
  to = {"a" .. p[1], "d" .. p[1], "e" .. p[1], "i" .. p[1], "o" .. p[1], "u" .. p[1], "y" .. p[1], "z" .. p[1], "z" .. p[2], "z" .. p[3]}
 },
 standardChars = "AaÁáBbDdÐðEeÉéFfGgHhIiÍíJjKkLlMmNnOoÓóPpRrSsTtUuÚúVvXxYyÝýÞþÆæÖö" .. c.punc,
}
m["it"] = {
 "Italian",
 652,
 "roa-itd",
 "Latn",
 ancestors = "it-oit",
 sort_key = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.diaer .. c.ringabove},
 standardChars = "AaÀàBbCcDdEeÈèÉéFfGgHhIiÌìLlMmNnOoÒòPpQqRrSsTtUuÙùVvZz" .. c.punc,
}
m["iu"] = {
 "Inuktitut",
 29921,
 "esx-inu",
 "Cans, Latn",
 translit = {Cans = "cr-translit"},
 override_translit = true,
}
m["ja"] = {
 "Japanese",
 5287,
 "jpx",
 "Jpan, Latn, Brai",
 ancestors = "ja-ear",
 translit = s["Jpan-translit"],
 link_tr = true,
 sort_key = s["Jpan-sortkey"],
}
m.ja.sort_key.Latn = {remove_diacritics = c.tilde .. c.macron .. c.diaer}
m["jv"] = {
 "Javanese",
 33549,
 "poz-sus",
 "Latn, Java",
 ancestors = "kaw",
 translit = {Java = "jv-translit"},
 link_tr = true,
 entry_name = {remove_diacritics = c.circ}, -- Modern jv don't use ê
 sort_key = {
  Latn = {
   from = {"å", "dh", "é", "è", "ng", "ny", "th"},
   to = {"a" .. p[1], "d" .. p[1], "e" .. p[1], "e" .. p[2], "n" .. p[1], "n" .. p[2], "t" .. p[1]}
  },
 },
}
m["ka"] = {
 "Georgian",
 8108,
 "ccs-gzn",
 "Geor, Geok, Hebr", -- Hebr is used to write Judeo-Georgian
 ancestors = "ka-mid",
 translit = {
  Geor = "Geor-translit",
  Geok = "Geok-translit",
 },
 override_translit = true,
 entry_name = {remove_diacritics = c.circ},
}
m["kg"] = {
 "Kongo",
 33702,
 "bnt-kng",
 "Latn",
}
m["ki"] = {
 "Kikuyu",
 33587,
 "bnt-kka",
 "Latn",
}
m["kj"] = {
 "Kwanyama",
 1405077,
 "bnt-ova",
 "Latn",
}
m["kk"] = {
 "Kazakh",
 9252,
 "trk-kno",
 "Cyrl, Latn, kk-Arab",
 translit = {
  Cyrl = {
   from = {
    "Ё", "ё", "Й", "й", "Нг", "нг", "Ӯ", "ӯ", -- 2 chars; are "Ӯ" and "ӯ" actually used?
    "А", "а", "Ә", "ә", "Б", "б", "В", "в", "Г", "г", "Ғ", "ғ", "Д", "д", "Е", "е", "Ж", "ж", "З", "з", "И", "и", "К", "к", "Қ", "қ", "Л", "л", "М", "м", "Н", "н", "Ң", "ң", "О", "о", "Ө", "ө", "П", "п", "Р", "р", "С", "с", "Т", "т", "У", "у", "Ұ", "ұ", "Ү", "ү", "Ф", "ф", "Х", "х", "Һ", "һ", "Ц", "ц", "Ч", "ч", "Ш", "ш", "Щ", "щ", "Ъ", "ъ", "Ы", "ы", "І", "і", "Ь", "ь", "Э", "э", "Ю", "ю", "Я", "я", -- 1 char
   },
   to = {
    "E", "e", "İ", "i", "Ñ", "ñ", "U", "u",
    "A", "a", "Ä", "ä", "B", "b", "V", "v", "G", "g", "Ğ", "ğ", "D", "d", "E", "e", "J", "j", "Z", "z", "İ", "i", "K", "k", "Q", "q", "L", "l", "M", "m", "N", "n", "Ñ", "ñ", "O", "o", "Ö", "ö", "P", "p", "R", "r", "S", "s", "T", "t", "U", "u", "Ū", "ū", "Ü", "ü", "F", "f", "X", "x", "H", "h", "S", "s", "Ç", "ç", "Ş", "ş", "Ş", "ş", "", "", "Y", "y", "I", "ı", "", "", "É", "é", "Ü", "ü", "Ä", "ä",
   }
  }
 },
-- override_translit = true,
 sort_key = {
  Cyrl = {
   from = {"ә", "ғ", "ё", "қ", "ң", "ө", "ұ", "ү", "һ", "і"},
   to = {"а" .. p[1], "г" .. p[1], "е" .. p[1], "к" .. p[1], "н" .. p[1], "о" .. p[1], "у" .. p[1], "у" .. p[2], "х" .. p[1], "ы" .. p[1]}
  },
 },
 standardChars = {
  Cyrl = "АаӘәБбВвГгҒғДдЕеЁёЖжЗзИиЙйКкҚқЛлМмНнҢңОоӨөПпРрСсТтУуҰұҮүФфХхҺһЦцЧчШшЩщЪъЫыІіЬьЭэЮюЯя",
  c.punc
 },
}
m["kl"] = {
 "Greenlandic",
 25355,
 "esx-inu",
 "Latn",
 sort_key = {
  from = {"æ", "ø", "å"},
  to = {"z" .. p[1], "z" .. p[2], "z" .. p[3]}
 }
}
m["km"] = {
 "Khmer",
 9205,
 "mkh-kmr",
 "Khmr",
 ancestors = "xhm",
 translit = "km-translit",
}
m["kn"] = {
 "Kannada",
 33673,
 "dra",
 "Knda",
 ancestors = "dra-mkn",
 translit = "kn-translit",
}
m["ko"] = {
 "Korean",
 9176,
 "qfa-kor",
 "Kore, Brai",
 ancestors = "ko-ear",
 translit = {Kore = "ko-translit"},
 entry_name = {Kore = s["Kore-entryname"]},
}
m["kr"] = {
 "Kanuri",
 36094,
 "ssa-sah",
 "Latn, Arab",
 entry_name = {Latn = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.breve}}, -- the sortkey and entry_name are only for standard Kanuri; when dialectal entries get added, someone will have to work out how the dialects should be represented orthographically
 sort_key = {
  Latn = {
   from = {"ǝ", "ny", "ɍ", "sh"},
   to = {"e" .. p[1], "n" .. p[1], "r" .. p[1], "s" .. p[1]}
  },
 },
}
m["ks"] = {
 "Kashmiri",
 33552,
 "inc-dar",
 "ks-Arab, Deva, Shrd, Latn",
 translit = {
  ["ks-Arab"] = "ks-Arab-translit",
  Deva = "ks-Deva-translit",
  Shrd = "Shrd-translit",
 },
}
-- "kv" IS TREATED AS "koi", "kpv", SEE WT:LT
m["kw"] = {
 "Cornish",
 25289,
 "cel-bry",
 "Latn",
 ancestors = "cnx",
 sort_key = {
  from = {"ch"},
  to = {"c" .. p[1]}
 },
}
m["ky"] = {
 "Kyrgyz",
 9255,
 "trk-kip",
 "Cyrl, Latn, Arab",
 translit = {Cyrl = "ky-translit"},
 override_translit = true,
 sort_key = {
  Cyrl = {
   from = {"ё", "ң", "ө", "ү"},
   to = {"е" .. p[1], "н" .. p[1], "о" .. p[1], "у" .. p[1]}
  },
 },
}
m["la"] = {
 "Latin",
 397,
 "itc",
 "Latn, Ital",
 ancestors = "itc-ola",
 entry_name = {Latn = {remove_diacritics = c.macron .. c.breve .. c.diaer .. c.dinvbreve}},
 sort_key = {
  Latn = {
   from = {"æ", "œ"},
   to = {"ae", "oe"}
  },
 },
 standardChars = {
  Latn = "AaBbCcDdEeFfGgHhIiLlMmNnOoPpQqRrSsTtUuVvXxZz",
  c.punc
 },
}
m["lb"] = {
 "Luxembourgish",
 9051,
 "gmw",
 "Latn",
 ancestors = "gmw-cfr",
 sort_key = {
  from = {"ä", "ë", "é"},
  to = {"z" .. p[1], "z" .. p[2], "z" .. p[3]}
 },
}
m["lg"] = {
 "Luganda",
 33368,
 "bnt-nyg",
 "Latn",
 entry_name = {remove_diacritics = c.acute .. c.circ},
 sort_key = {
  from = {"ŋ"},
  to = {"n" .. p[1]}
 },
}
m["li"] = {
 "Limburgish",
 102172,
 "gmw",
 "Latn",
 ancestors = "dum",
}
m["ln"] = {
 "Lingala",
 36217,
 "bnt-bmo",
 "Latn",
 sort_key = {
  remove_diacritics = c.acute .. c.circ .. c.caron,
  from = {"ɛ", "gb", "mb", "mp", "nd", "ng", "nk", "ns", "nt", "ny", "nz", "ɔ"},
  to = {"e" .. p[1], "g" .. p[1], "m" .. p[1], "m" .. p[2], "n" .. p[1], "n" .. p[2], "n" .. p[3], "n" .. p[4], "n" .. p[5], "n" .. p[6], "n" .. p[7], "o" .. p[1]}
 },
}
m["lo"] = {
 "Lao",
 9211,
 "tai-swe",
 "Laoo",
 translit = "lo-translit",
 sort_key = "Laoo-sortkey",
 standardChars = "0-9ກຂຄງຈຊຍດຕຖທນບປຜຝພຟມຢຣລວສຫອຮຯ-ໝ" .. c.punc,
}
m["lt"] = {
 "Lithuanian",
 9083,
 "bat",
 "Latn",
 ancestors = "olt",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.tilde},
 sort_key = {
  from = {"ą", "č", "ę", "ė", "į", "y", "š", "ų", "ū", "ž"},
  to = {"a" .. p[1], "c" .. p[1], "e" .. p[1], "e" .. p[2], "i" .. p[1], "i" .. p[2], "s" .. p[1], "u" .. p[1], "u" .. p[2], "z" .. p[1]}
 },
 standardChars = "AaĄąBbCcČčDdEeĘęĖėFfGgHhIiĮįYyJjKkLlMmNnOoPpRrSsŠšTtUuŲųŪūVvZzŽž" .. c.punc,
}
m["lu"] = {
 "Luba-Katanga",
 36157,
 "bnt-lub",
 "Latn",
}
m["lv"] = {
 "Latvian",
 9078,
 "bat",
 "Latn",
 entry_name = {
  -- This attempts to convert vowels with tone marks to vowels either with or without macrons. Specifically, there should be no macrons if the vowel is part of a diphthong (including resonant diphthongs such pìrksts -> pirksts not #pīrksts). What we do is first convert the vowel + tone mark to a vowel + tilde in a decomposed fashion, then remove the tilde in diphthongs, then convert the remaining vowel + tilde sequences to macroned vowels, then delete any other tilde. We leave already-macroned vowels alone: Both e.g. ar and ār occur before consonants. FIXME: This still might not be sufficient.
  from = {"([Ee])" .. c.cedilla, "[" .. c.grave .. c.circ .. c.tilde .."]", "([aAeEiIoOuU])" .. c.tilde .."?([lrnmuiLRNMUI])" .. c.tilde .. "?([^aAeEiIoOuU])", "([aAeEiIoOuU])" .. c.tilde .."?([lrnmuiLRNMUI])" .. c.tilde .."?$", "([iI])" .. c.tilde .. "?([eE])" .. c.tilde .. "?", "([aAeEiIuU])" .. c.tilde, c.tilde},
  to = {"%1", c.tilde, "%1%2%3", "%1%2", "%1%2", "%1" .. c.macron}
 },
 sort_key = {
  from = {"ā", "č", "ē", "ģ", "ī", "ķ", "ļ", "ņ", "š", "ū", "ž"},
  to = {"a" .. p[1], "c" .. p[1], "e" .. p[1], "g" .. p[1], "i" .. p[1], "k" .. p[1], "l" .. p[1], "n" .. p[1], "s" .. p[1], "u" .. p[1], "z" .. p[1]}
 },
 standardChars = "AaĀāBbCcČčDdEeĒēFfGgĢģHhIiĪīJjKkĶķLlĻļMmNnŅņOoPpRrSsŠšTtUuŪūVvZzŽž" .. c.punc,
}
m["mg"] = {
 "Malagasy",
 7930,
 "poz-bre",
 "Latn",
}
m["mh"] = {
 "Marshallese",
 36280,
 "poz-mic",
 "Latn",
 sort_key = {
  from = {"ā", "ļ", "m̧", "ņ", "n̄", "o̧", "ō", "ū"},
  to = {"a" .. p[1], "l" .. p[1], "m" .. p[1], "n" .. p[1], "n" .. p[2], "o" .. p[1], "o" .. p[2], "u" .. p[1]}
 },
}
m["mi"] = {
 "Maori",
 36451,
 "poz-pep",
 "Latn",
 sort_key = {
  remove_diacritics = c.macron,
  from = {"ng", "wh"},
  to = {"z" .. p[1], "z" .. p[2]}
 },
}
m["mk"] = {
 "Macedonian",
 9296,
 "zls",
 "Cyrl",
 ancestors = "cu",
 translit = "mk-translit",
 entry_name = {
  remove_diacritics = c.acute,
  remove_exceptions = {"Ѓ", "ѓ", "Ќ", "ќ"}
 },
 sort_key = {
  remove_diacritics = c.grave,
  from = {"ѓ", "ѕ", "ј", "љ", "њ", "ќ", "џ"},
  to = {"д" .. p[1], "з" .. p[1], "и" .. p[1], "л" .. p[1], "н" .. p[1], "т" .. p[1], "ч" .. p[1]}
 },
 standardChars = "АаБбВвГгДдЃѓЕеЖжЗзЅѕИиЈјКкЛлЉљМмНнЊњОоПпРрСсТтЌќУуФфХхЦцЧчЏџШш" .. c.punc,
}
m["ml"] = {
 "Malayalam",
 36236,
 "dra",
 "Mlym",
 translit = "ml-translit",
 override_translit = true,
}
m["mn"] = {
 "Mongolian",
 9246,
 "xgn-cen",
 "Cyrl, Mong, Latn, Brai",
 ancestors = "cmg",
 translit = {
  Cyrl = "mn-translit",
  Mong = "Mong-translit",
 },
 override_translit = true,
 display_text = {Mong = s["Mong-displaytext"]},
 entry_name = {
  Cyrl = {remove_diacritics = c.grave .. c.acute},
  Mong = s["Mong-entryname"],
 },
 sort_key = {
  Cyrl = {
   remove_diacritics = c.grave,
   from = {"ё", "ө", "ү"},
   to = {"е" .. p[1], "о" .. p[1], "у" .. p[1]}
  },
 },
 standardChars = {
  Cyrl = "АаБбВвГгДдЕеЁёЖжЗзИиЙйЛлМмНнОоӨөРрСсТтУуҮүХхЦцЧчШшЫыЬьЭэЮюЯя—",
  Brai = c.braille,
  c.punc
 },
}
-- "mo" IS TREATED AS "ro", SEE WT:LT
m["mr"] = {
 "Marathi",
 1571,
 "inc-sou",
 "Deva, Modi",
 ancestors = "omr",
 translit = {
  Deva = "mr-translit",
  Modi = "mr-Modi-translit",
 },
 entry_name = {
  Deva = {
   from = {"च़", "ज़", "झ़"},
   to = {"च", "ज", "झ"}
  },
 },
}
m["ms"] = {
 "Malay",
 9237,
 "poz-mly",
 "Latn, ms-Arab",
 ancestors = "ms-cla",
 standardChars = {
  Latn = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz",
  c.punc
 },
}
m["mt"] = {
 "Maltese",
 9166,
 "sem-arb",
 "Latn",
 display_text = {
  from = {"'"},
  to = {"’"}
 },
 entry_name = {
  from = {"’"},
  to = {"'"},
 },
 ancestors = "sqr",
 sort_key = {
  from = {
   "ċ", "ġ", "ż", -- Convert into PUA so that decomposed form does not get caught by the next step.
   "([cgz])", -- Ensure "c" comes after "ċ", "g" comes after "ġ" and "z" comes after "ż".
   "g" .. p[1] .. "ħ", -- "għ" after initial conversion of "g".
   p[3], p[4], "ħ", "ie", p[5] -- Convert "ċ", "ġ", "ħ", "ie", "ż" into final output.
  },
  to = {
   p[3], p[4], p[5],
   "%1" .. p[1],
   "g" .. p[2],
   "c", "g", "h" .. p[1], "i" .. p[1], "z"
  }
 },
}
m["my"] = {
 "Burmese",
 9228,
 "tbq-brm",
 "Mymr",
 ancestors = "obr",
 translit = "my-translit",
 override_translit = true,
 sort_key = {
  from = {"ျ", "ြ", "ွ", "ှ", "ဿ"},
  to = {"္ယ", "္ရ", "္ဝ", "္ဟ", "သ္သ"}
 },
}
m["na"] = {
 "Nauruan",
 13307,
 "poz-mic",
 "Latn",
}
m["nb"] = {
 "Norwegian Bokmål",
 25167,
 "gmq",
 "Latn",
 wikimedia_codes = "no",
 ancestors = "gmq-mno, da",
 sort_key = s["no-sortkey"],
 standardChars = s["no-standardchars"],
}
m["nd"] = {
 "Northern Ndebele",
 35613,
 "bnt-ngu",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.macron .. c.caron},
}
m["ne"] = {
 "Nepali",
 33823,
 "inc-pah",
 "Deva, Newa",
 translit = {Deva = "ne-translit"},
}
m["ng"] = {
 "Ndonga",
 33900,
 "bnt-ova",
 "Latn",
}
m["nl"] = {
 "Dutch",
 7411,
 "gmw",
 "Latn, Brai",
 ancestors = "dum",
 sort_key = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.tilde .. c.diaer .. c.ringabove .. c.cedilla .. "'"},
 standardChars = {
  Latn = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz",
  Brai = c.braille,
  c.punc
 },
}
m["nn"] = {
 "Norwegian Nynorsk",
 25164,
 "gmq",
 "Latn",
 ancestors = "gmq-mno",
 entry_name = {
  remove_diacritics = c.grave .. c.acute,
 },
 sort_key = s["no-sortkey"],
 standardChars = s["no-standardchars"],
}
m["no"] = {
 "Norwegian",
 9043,
 "gmq",
 "Latn",
 ancestors = "gmq-mno",
 sort_key = s["no-sortkey"],
 standardChars = s["no-standardchars"],
}
m["nr"] = {
 "Southern Ndebele",
 36785,
 "bnt-ngu",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.macron .. c.caron},
}
m["nv"] = {
 "Navajo",
 13310,
 "apa",
 "Latn",
 sort_key = {
  remove_diacritics = c.acute .. c.ogonek,
  from = {
   "chʼ", "tłʼ", "tsʼ", -- 3 chars
   "ch", "dl", "dz", "gh", "hw", "kʼ", "kw", "sh", "tł", "ts", "zh", -- 2 chars
   "ł", "ʼ" -- 1 char
  },
  to = {
   "c" .. p[2], "t" .. p[2], "t" .. p[4],
   "c" .. p[1], "d" .. p[1], "d" .. p[2], "g" .. p[1], "h" .. p[1], "k" .. p[1], "k" .. p[2], "s" .. p[1], "t" .. p[1], "t" .. p[3], "z" .. p[1],
   "l" .. p[1], "z" .. p[2]
  }
 },
}
m["ny"] = {
 "Chichewa",
 33273,
 "bnt-nys",
 "Latn",
 entry_name = {remove_diacritics = c.acute .. c.circ},
 sort_key = {
  from = {"ng'"},
  to = {"ng"}
 },
}
m["oc"] = {
 "Occitan",
 14185,
 "roa-ocr",
 "Latn, Hebr",
 ancestors = "pro",
 sort_key = {
  Latn = {
   remove_diacritics = c.grave .. c.acute .. c.diaer .. c.cedilla,
   from = {"([lns])·h"},
   to = {"%1h"}
  },
 },
}
m["oj"] = {
 "Ojibwe",
 33875,
 "alg",
 "Cans, Latn",
 sort_key = {
  Latn = {
   from = {"aa", "ʼ", "ii", "oo", "sh", "zh"},
   to = {"a" .. p[1], "h" .. p[1], "i" .. p[1], "o" .. p[1], "s" .. p[1], "z" .. p[1]}
  },
 },
}
m["om"] = {
 "Oromo",
 33864,
 "cus-eas",
 "Latn, Ethi",
}
m["or"] = {
 "Odia",
 33810,
 "inc-eas",
 "Orya",
 ancestors = "inc-mor",
 translit = "or-translit",
}
m["os"] = {
 "Ossetian",
 33968,
 "xsc",
 "Cyrl, Geor, Latn",
 ancestors = "oos",
 translit = {
  Cyrl = "os-translit",
  Geor = "Geor-translit",
 },
 override_translit = true,
 display_text = {
  Cyrl = {
   from = {"æ"},
   to = {"ӕ"}
  },
  Latn = {
   from = {"ӕ"},
   to = {"æ"}
  },
 },
 entry_name = {
  Cyrl = {
   remove_diacritics = c.grave .. c.acute,
   from = {"æ"},
   to = {"ӕ"}
  },
  Latn = {
   from = {"ӕ"},
   to = {"æ"}
  },
 },
 sort_key = {
  Cyrl = {
   from = {"ӕ", "гъ", "дж", "дз", "ё", "къ", "пъ", "тъ", "хъ", "цъ", "чъ"},
   to = {"а" .. p[1], "г" .. p[1], "д" .. p[1], "д" .. p[2], "е" .. p[1], "к" .. p[1], "п" .. p[1], "т" .. p[1], "х" .. p[1], "ц" .. p[1], "ч" .. p[1]}
  },
 },
}
m["pa"] = {
 "Punjabi",
 58635,
 "inc-pan",
 "Guru, pa-Arab",
 ancestors = "inc-opa",
 translit = {
  Guru = "Guru-translit",
  ["pa-Arab"] = "pa-Arab-translit",
 },
 entry_name = {
  ["pa-Arab"] = {
   remove_diacritics = c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun .. c.nunghunna,
   from = {"ݨ", "ࣇ"},
   to = {"ن", "ل"}
  },
 },
}
m["pi"] = {
 "Pali",
 36727,
 "inc-mid",
 "Latn, Brah, Deva, Beng, Sinh, Mymr, Thai, Lana, Laoo, Khmr, Cakm",
 ancestors = "sa",
 translit = {
  Brah = "Brah-translit",
  Deva = "sa-translit",
  Beng = "pi-translit",
  Sinh = "si-translit",
  Mymr = "pi-translit",
  Thai = "pi-translit",
  Lana = "pi-translit",
  Laoo = "pi-translit",
  Khmr = "pi-translit",
  Cakm = "Cakm-translit",
 },
 entry_name = {
  Thai = {
   from = {"ึ", u(0xF700), u(0xF70F)}, -- FIXME: Not clear what's going on with the PUA characters here.
   to = {"ิํ", "ฐ", "ญ"}
  },
  remove_diacritics = c.VS01
 },
 sort_key = { -- FIXME: This needs to be converted into the current standardized format.
  from = {"ā", "ī", "ū", "ḍ", "ḷ", "m[" .. c.dotabove .. c.dotbelow .. "]", "ṅ", "ñ", "ṇ", "ṭ", "([เโ])([ก-ฮ])", "([ເໂ])([ກ-ຮ])", "ᩔ", "ᩕ", "ᩖ", "ᩘ", "([ᨭ-ᨱ])ᩛ", "([ᨷ-ᨾ])ᩛ", "ᩤ", u(0xFE00), u(0x200D)},
  to = {"a~", "i~", "u~", "d~", "l~", "m~", "n~", "n~~", "n~~~", "t~", "%2%1", "%2%1", "ᩈ᩠ᩈ", "᩠ᩁ", "᩠ᩃ", "ᨦ᩠", "%1᩠ᨮ", "%1᩠ᨻ", "ᩣ"}
 },
}
m["pl"] = {
 "Polish",
 809,
 "zlw-lch",
 "Latn",
 ancestors = "zlw-mpl",
 sort_key = {
  from = {"ą", "ć", "ę", "ł", "ń", "ó", "ś", "ź", "ż"},
  to = {"a" .. p[1], "c" .. p[1], "e" .. p[1], "l" .. p[1], "n" .. p[1], "o" .. p[1], "s" .. p[1], "z" .. p[1], "z" .. p[2]}
 },
 standardChars = "AaĄąBbCcĆćDdEeĘęFfGgHhIiJjKkLlŁłMmNnŃńOoÓóPpRrSsŚśTtUuWwYyZzŹźŻż" .. c.punc,
}
m["ps"] = {
 "Pashto",
 58680,
 "ira-pat",
 "ps-Arab",
 entry_name = {remove_diacritics = c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun .. c.superalef},
}
m["pt"] = {
 "Portuguese",
 5146,
 "roa-ibe",
 "Latn, Brai",
 ancestors = "roa-opt",
 sort_key = {Latn = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.tilde .. c.diaer .. c.cedilla}},
 standardChars = {
  Latn = "AaÁáÂâÃãBbCcÇçDdEeÉéÊêFfGgHhIiÍíJjLlMmNnOoÓóÔôÕõPpQqRrSsTtUuÚúVvXxZz",
  Brai = c.braille,
  c.punc
 },
}
m["qu"] = {
 "Quechua",
 5218,
 "qwe",
 "Latn",
}
m["rm"] = {
 "Romansch",
 13199,
 "roa-rhe",
 "Latn",
}
m["ro"] = {
 "Romanian",
 7913,
 "roa-eas",
 "Latn, Cyrl",
 sort_key = {
  Latn = {
   from = {"ă", "â", "î", "ș", "ț"},
   to = {"a" .. p[1], "a" .. p[2], "i" .. p[1], "s" .. p[1], "t" .. p[1]}
  },
  Cyrl = {
   from = {"ӂ"},
   to = {"ж" .. p[1]}
  },
 },
 standardChars = {
  Latn = "AaĂăÂâBbCcDdEeFfGgHhIiÎîJjLlMmNnOoPpRrSsȘșTtȚțUuVvXxZz",
  Cyrl = "АаБбВвГгДдЕеЖжӁӂЗзИиЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЫыЬьЭэЮюЯя",
  c.punc
 },
}
m["ru"] = {
 "Russian",
 7737,
 "zle",
 "Cyrl, Cyrs, Brai",
 ancestors = "zle-mru",
 translit = {
  Cyrl = "ru-translit",
  Cyrs = "ru-translit",
 },
 entry_name = {
  Cyrl = s["ru-Cyrl-entryname"],
  Cyrs = s["ru-Cyrl-entryname"],
 },
 sort_key = {
  Cyrl = s["ru-Cyrl-sortkey"],
  Cyrs = s["ru-Cyrl-sortkey"],
 },
 standardChars = {
  Cyrl = "АаБбВвГгДдЕеЁёЖжЗзИиЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЩщЪъЫыЬьЭэЮюЯя—",
  Brai = c.braille,
  c.punc
 },
}
m["rw"] = {
 "Rwanda-Rundi",
 3217514,
 "bnt-glb",
 "Latn",
 entry_name = {remove_diacritics = c.acute .. c.circ .. c.macron .. c.caron},
}
m["sa"] = {
 "Sanskrit",
 11059,
 "inc-old",
 "Deva, Bali, as-Beng, Beng, Bhks, Brah, Gran, Gujr, Guru, Hani, Java, Kawi, Khar, Khmr, Knda, Lana, Laoo, Marc, Mlym, Modi, Mong, mnc-Mong, xwo-Mong, Mymr, Nand, Newa, Orya, Phag, Ranj, Saur, Shrd, Sidd, Sinh, Taml, Tang, Telu, Thai, Tibt, Tirh",
 translit = {
  Deva = "sa-translit",
  ["as-Beng"] = "sa-Beng-translit",
  Beng = "sa-Beng-translit",
  Brah = "Brah-translit",
  Gujr = "sa-Gujr-translit",
  Java = "sa-Java-translit",
  Khmr = "pi-translit",
  Knda = "sa-Knda-translit",
  Lana = "pi-translit",
  Laoo = "pi-translit",
  Mlym = "sa-Mlym-translit",
  Modi = "sa-Modi-translit",
  Mong = "Mong-translit",
  ["mnc-Mong"] = "mnc-translit",
  ["xwo-Mong"] = "xal-translit",
  Mymr = "pi-translit",
  Orya = "sa-Orya-translit",
  Sinh = "si-translit",
  Thai = "pi-translit",
  Tibt = "Tibt-translit",
 },
 display_text = {
  Mong = s["Mong-displaytext"],
  Tibt = s["Tibt-displaytext"],
 },
 entry_name = {
  Mong = s["Mong-entryname"],
  Tibt = s["Tibt-entryname"],
  Thai = {
   from = {"ึ", u(0xF700), u(0xF70F)}, -- FIXME: Not clear what's going on with the PUA characters here.
   to = {"ิํ", "ฐ", "ญ"}
  },
  remove_diacritics = c.VS01
 },
 sort_key = {
  Tibt = "Tibt-sortkey",
  { -- FIXME: This needs to be converted into the current standardized format.
   from = {"ā", "ī", "ū", "ḍ", "ḷ", "ḹ", "m[" .. c.dotabove .. c.dotbelow .. "]", "ṅ", "ñ", "ṇ", "ṛ", "ṝ", "ś", "ṣ", "ṭ", "([เโไ])([ก-ฮ])", "([ເໂໄ])([ກ-ຮ])", "ᩔ", "ᩕ", "ᩖ", "ᩘ", "([ᨭ-ᨱ])ᩛ", "([ᨷ-ᨾ])ᩛ", "ᩤ", u(0xFE00), u(0x200D)},
   to = {"a~", "i~", "u~", "d~", "l~", "l~~", "m~", "n~", "n~~", "n~~~", "r~", "r~~", "s~", "s~~", "t~", "%2%1", "%2%1", "ᩈ᩠ᩈ", "᩠ᩁ", "᩠ᩃ", "ᨦ᩠", "%1᩠ᨮ", "%1᩠ᨻ", "ᩣ"},
  },
 },
}
m["sc"] = {
 "Sardinian",
 33976,
 "roa",
 "Latn",
}
m["sd"] = {
 "Sindhi",
 33997,
 "inc-snd",
 "sd-Arab, Deva, Sind, Khoj",
 translit = {Sind = "Sind-translit"},
 entry_name = {
  ["sd-Arab"] = {
   remove_diacritics = c.kashida .. c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun .. c.superalef,
   from = {"ٱ"},
   to = {"ا"}
  },
 },
 ancestors = "inc-vra",
}
m["se"] = {
 "Northern Sami",
 33947,
 "smi",
 "Latn",
 display_text = {
  from = {"'"},
  to = {"ˈ"}
 },
 entry_name = {remove_diacritics = c.macron .. c.dotbelow .. "'ˈ"},
 sort_key = {
  from = {"á", "č", "đ", "ŋ", "š", "ŧ", "ž"},
  to = {"a" .. p[1], "c" .. p[1], "d" .. p[1], "n" .. p[1], "s" .. p[1], "t" .. p[1], "z" .. p[1]}
 },
 standardChars = "AaÁáBbCcČčDdĐđEeFfGgHhIiJjKkLlMmNnŊŋOoPpRrSsŠšTtŦŧUuVvZzŽž" .. c.punc,
}
m["sg"] = {
 "Sango",
 33954,
 "crp",
 "Latn",
 ancestors = "ngb",
}
m["sh"] = {
 "Serbo-Croatian",
 9301,
 "zls",
 "Latn, Cyrl, Glag",
 wikimedia_codes = "sh, bs, hr, sr",
 entry_name = {
  Latn = {
   remove_diacritics = c.grave .. c.acute .. c.tilde .. c.macron .. c.dgrave .. c.invbreve,
   remove_exceptions = {"Ć", "ć", "Ś", "ś", "Ź", "ź"}
  },
  Cyrl = {
   remove_diacritics = c.grave .. c.acute .. c.tilde .. c.macron .. c.dgrave .. c.invbreve,
   remove_exceptions = {"З́", "з́", "С́", "с́"}
  },
 },
 sort_key = {
  Latn = {
   from = {"č", "ć", "dž", "đ", "lj", "nj", "š", "ś", "ž", "ź"},
   to = {"c" .. p[1], "c" .. p[2], "d" .. p[1], "d" .. p[2], "l" .. p[1], "n" .. p[1], "s" .. p[1], "s" .. p[2], "z" .. p[1], "z" .. p[2]}
  },
  Cyrl = {
   from = {"ђ", "з́", "ј", "љ", "њ", "с́", "ћ", "џ"},
   to = {"д" .. p[1], "з" .. p[1], "и" .. p[1], "л" .. p[1], "н" .. p[1], "с" .. p[1], "т" .. p[1], "ч" .. p[1]}
  },
 },
 standardChars = {
  Latn = "AaBbCcČčĆćDdĐđEeFfGgHhIiJjKkLlMmNnOoPpRrSsŠšTtUuVvZzŽž",
  Cyrl = "АаБбВвГгДдЂђЕеЖжЗзИиЈјКкЛлЉљМмНнЊњОоПпРрСсТтЋћУуФфХхЦцЧчЏџШш",
  c.punc
 },
}
m["si"] = {
 "Sinhalese",
 13267,
 "inc-ins",
 "Sinh",
 ancestors = "pra-hel",
 translit = "si-translit",
 override_translit = true,
}
m["sk"] = {
 "Slovak",
 9058,
 "zlw",
 "Latn",
 ancestors = "zlw-osk",
 sort_key = {remove_diacritics = c.acute .. c.circ .. c.diaer},
 standardChars = "AaÁáÄäBbCcČčDdĎďEeFfGgHhIiÍíJjKkLlĹĺĽľMmNnŇňOoÔôPpRrŔŕSsŠšTtŤťUuÚúVvYyÝýZzŽž" .. c.punc,
}
m["sl"] = {
 "Slovene",
 9063,
 "zls",
 "Latn",
 entry_name = {
  remove_diacritics = c.grave .. c.acute .. c.circ .. c.macron .. c.dgrave .. c.invbreve .. c.dotbelow,
  from = {"Ə", "ə", "Ł", "ł"},
  to = {"E", "e", "L", "l"}
 },
 sort_key = {
  remove_diacritics = c.tilde .. c.dotabove .. c.diaer .. c.ringabove .. c.ringbelow .. c.ogonek,
  from = {"č", "š", "ž"},
  to = {"c" .. p[1], "s" .. p[1], "z" .. p[1]}
 },
 standardChars = "AaBbCcČčDdEeFfGgHhIiJjKkLlMmNnOoPpRrSsŠšTtUuVvZzŽž" .. c.punc,
}
m["sm"] = {
 "Samoan",
 34011,
 "poz-pnp",
 "Latn",
}
m["sn"] = {
 "Shona",
 34004,
 "bnt-sho",
 "Latn",
 entry_name = {remove_diacritics = c.acute},
}
m["so"] = {
 "Somali",
 13275,
 "cus-som",
 "Latn, Arab, Osma",
 entry_name = {Latn = {remove_diacritics = c.grave .. c.acute .. c.circ}},
}
m["sq"] = {
 "Albanian",
 8748,
 "sqj",
 "Latn, Grek, ota-Arab, Elba",
 entry_name = {
  remove_diacritics = c.acute,
  from = {'^i (%w)', '^të (%w)'}, to = {'%1', '%1'},
 },
 sort_key = {
  remove_diacritics = c.circ .. c.tilde,
  from = {'ç', 'dh', 'ë', 'gj', 'll', 'nj', 'rr', 'sh', 'th', 'xh', 'zh'},
  to = {'c'..p[1], 'd'..p[1], 'e'..p[1], 'g'..p[1], 'l'..p[1], 'n'..p[1], 'r'..p[1], 's'..p[1], 't'..p[1], 'x'..p[1], 'z'..p[1]},
 },
 standardChars = "AaBbCcÇçDdEeËëFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvXxYyZz" .. c.punc,
}
m["ss"] = {
 "Swazi",
 34014,
 "bnt-ngu",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.macron .. c.caron},
}
m["st"] = {
 "Sotho",
 34340,
 "bnt-sts",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.macron .. c.caron},
}
m["su"] = {
 "Sundanese",
 34002,
 "poz-msa",
 "Latn, Sund",
 ancestors = "osn",
 translit = {Sund = "su-translit"},
}
m["sv"] = {
 "Swedish",
 9027,
 "gmq",
 "Latn",
 ancestors = "gmq-osw",
 sort_key = {
  remove_diacritics = c.grave .. c.acute .. c.circ .. c.tilde .. c.macron .. c.dacute .. c.caron .. c.cedilla .. "':",
  remove_exceptions = {"å"},
  from = {"ø", "æ", "œ", "ß", "å"},
  to = {"o", "ae", "oe", "ss", "z" .. p[1]}
 },
 standardChars = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpRrSsTtUuVvXxYyÅåÄäÖö" .. c.punc,
}
m["sw"] = {
 "Swahili",
 7838,
 "bnt-swh",
 "Latn, Arab",
 sort_key = {
  Latn = {
   from = {"ng'"},
   to = {"ng" .. p[1]}
  },
 },
}
m["ta"] = {
 "Tamil",
 5885,
 "dra",
 "Taml",
 ancestors = "oty",
 translit = "ta-translit",
 override_translit = true,
}
m["te"] = {
 "Telugu",
 8097,
 "dra",
 "Telu",
 ancestors = "dra-ote",
 translit = "te-translit",
 override_translit = true,
}
m["tg"] = {
 "Tajik",
 9260,
 "ira-swi",
 "Cyrl, fa-Arab, Latn",
 ancestors = "fa-cls",
 translit = {Cyrl = "tg-translit"},
 override_translit = true,
 entry_name = {remove_diacritics = c.grave .. c.acute},
 sort_key = {
  Cyrl = {
   from = {"ғ", "ё", "ӣ", "қ", "ӯ", "ҳ", "ҷ"},
   to = {"г" .. p[1], "е" .. p[1], "и" .. p[1], "к" .. p[1], "у" .. p[1], "х" .. p[1], "ч" .. p[1]}
  },
 },
}
m["th"] = {
 "Thai",
 9217,
 "tai-swe",
 "Thai, Brai",
 translit = {Thai = "th-translit"},
 sort_key = {Thai = "Thai-sortkey"},
}
m["ti"] = {
 "Tigrinya",
 34124,
 "sem-eth",
 "Ethi",
 translit = "Ethi-translit",
}
m["tk"] = {
 "Turkmen",
 9267,
 "trk-ogz",
 "Latn, Cyrl, Arab",
 entry_name = {remove_diacritics = c.macron},
 sort_key = {
  Latn = {
   from = {"ç", "ä", "ž", "ň", "ö", "ş", "ü", "ý"},
   to = {"c" .. p[1], "e" .. p[1], "j" .. p[1], "n" .. p[1], "o" .. p[1], "s" .. p[1], "u" .. p[1], "y" .. p[1]}
  },
  Cyrl = {
   from = {"ё", "җ", "ң", "ө", "ү", "ә"},
   to = {"е" .. p[1], "ж" .. p[1], "н" .. p[1], "о" .. p[1], "у" .. p[1], "э" .. p[1]}
  },
 },
}
m["tl"] = {
 "Tagalog",
 34057,
 "phi",
 "Latn, Tglg",
 translit = {Tglg = "tl-translit"},
 override_translit = true,
 entry_name = {Latn = {remove_diacritics = c.grave .. c.acute .. c.circ}},
 standardChars = {
  Latn = "AaBbKkDdEeGgHhIiLlMmNnOoPpRrSsTtUuWwYy",
  c.punc
 },
 sort_key = {
  Latn = "tl-sortkey",
 },
}
m["tn"] = {
 "Tswana",
 34137,
 "bnt-sts",
 "Latn",
}
m["to"] = {
 "Tongan",
 34094,
 "poz-pol",
 "Latn",
 entry_name = {remove_diacritics = c.acute},
 sort_key = {remove_diacritics = c.macron},
}
m["tr"] = {
 "Turkish",
 256,
 "trk-ogz",
 "Latn",
 ancestors = "ota",
 dotted_dotless_i = true,
 sort_key = {
  from = {
   -- Ignore circumflex, but account for capital Î wrongly becoming ı + circ due to dotted dotless I logic.
   "ı" .. c.circ, c.circ,
   "i", -- Ensure "i" comes after "ı".
   "ç", "ğ", "ı", "ö", "ş", "ü"
  },
  to = {
   "i", "",
   "i" .. p[1],
   "c" .. p[1], "g" .. p[1], "i", "o" .. p[1], "s" .. p[1], "u" .. p[1]
  }
 },
 standardChars = "AaÂâBbCcÇçDdEeFfGgĞğHhIıİiÎîJjKkLlMmNnOoÖöPpRrSsŞşTtUuÛûÜüVvYyZz" .. c.punc,
}
m["ts"] = {
 "Tsonga",
 34327,
 "bnt-tsr",
 "Latn",
}
m["tt"] = {
 "Tatar",
 25285,
 "trk-kbu",
 "Cyrl, Latn, tt-Arab",
 translit = {Cyrl = "tt-translit"},
 override_translit = true,
 dotted_dotless_i = true,
 sort_key = {
  Cyrl = {
   from = {"ә", "ў", "ғ", "ё", "җ", "қ", "ң", "ө", "ү", "һ"},
   to = {"а" .. p[1], "в" .. p[1], "г" .. p[1], "е" .. p[1], "ж" .. p[1], "к" .. p[1], "н" .. p[1], "о" .. p[1], "у" .. p[1], "х" .. p[1]}
  },
  Latn = {
   from = {
    "i", -- Ensure "i" comes after "ı".
    "ä", "ə", "ç", "ğ", "ı", "ñ", "ŋ", "ö", "ɵ", "ş", "ü"
   },
   to = {
    "i" .. p[1],
    "a" .. p[1], "a" .. p[2], "c" .. p[1], "g" .. p[1], "i", "n" .. p[1], "n" .. p[2], "o" .. p[1], "o" .. p[2], "s" .. p[1], "u" .. p[1]
   }
  },
 },
}
-- "tw" IS TREATED AS "ak", SEE WT:LT
m["ty"] = {
 "Tahitian",
 34128,
 "poz-pep",
 "Latn",
}
m["ug"] = {
 "Uyghur",
 13263,
 "trk-kar",
 "ug-Arab, Latn, Cyrl",
 ancestors = "chg",
 translit = {
  ["ug-Arab"] = "ug-translit",
  Cyrl = "ug-translit",
 },
 override_translit = true,
}
m["uk"] = {
 "Ukrainian",
 8798,
 "zle",
 "Cyrl",
 ancestors = "zle-ouk",
 translit = "uk-translit",
 entry_name = {remove_diacritics = c.grave .. c.acute},
 sort_key = {
  from = {
   "ї", -- 2 chars
   "ґ", "є", "і" -- 1 char
  },
  to = {
   "и" .. p[2],
   "г" .. p[1], "е" .. p[1], "и" .. p[1]
  }
 },
 standardChars = "АаБбВвГгДдЕеЄєЖжЗзИиІіЇїЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЩщЬьЮюЯя" .. c.punc,
}
m["ur"] = {
 "Urdu",
 1617,
 "inc-hnd",
 "ur-Arab,Hebr",
 ancestors = "inc-ohi",
 translit = {["ur-Arab"] = "ur-translit"},
 entry_name = {
  -- character "ۂ" code U+06C2 to "ه" and "هٔ" (U+0647 + U+0654) to "ه"; hamzatu l-waṣli to a regular alif
  from = {"هٔ", "ۂ", "ٱ"},
  to = {"ہ", "ہ", "ا"},
  remove_diacritics = c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun .. c.nunghunna .. c.superalef
 },
 -- put Judeo-Urdu (Hebrew-script Urdu) under the category header
 -- U+FB21 HEBREW LETTER WIDE ALEF so that it sorts after Arabic script titles
 sort_key = {
  from = {"^%f[" .. u(0x5D0) .. "-" .. u(0x5EA) .. "]"},
  to = {u(0xFB21)},
 },
}
m["uz"] = {
 "Uzbek",
 9264,
 "trk-kar",
 "Latn, Cyrl, fa-Arab",
 ancestors = "chg",
 translit = {Cyrl = "uz-translit"},
 sort_key = {
  Latn = {
   from = {"oʻ", "gʻ", "sh", "ch", "ng"},
   to = {"z" .. p[1], "z" .. p[2], "z" .. p[3], "z" .. p[4], "z" .. p[5]}
  },
  Cyrl = {
   from = {"ё", "ў", "қ", "ғ", "ҳ"},
   to = {"е" .. p[1], "я" .. p[1], "я" .. p[2], "я" .. p[3], "я" .. p[4]}
  },
 },
}
m["ve"] = {
 "Venda",
 32704,
 "bnt-bso",
 "Latn",
}
m["vi"] = {
 "Vietnamese",
 9199,
 "mkh-vie",
 "Latn, Hani",
 ancestors = "mkh-mvi",
 sort_key = {
  Latn = "vi-sortkey",
  Hani = "Hani-sortkey",
 },
}
m["vo"] = {
 "Volapük",
 36986,
 "art",
 "Latn",
}
m["wa"] = {
 "Walloon",
 34219,
 "roa-oil",
 "Latn",
 ancestors = "fro",
 sort_key = s["roa-oil-sortkey"],
}
m["wo"] = {
 "Wolof",
 34257,
 "alv-fwo",
 "Latn, Arab",
}
m["xh"] = {
 "Xhosa",
 13218,
 "bnt-ngu",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.macron .. c.caron},
}
m["yi"] = {
 "Yiddish",
 8641,
 "gmw",
 "Hebr",
 ancestors = "gmh",
 translit = "yi-translit",
 sort_key = {
  from = {"א[ַָ]", "בּ", "ו[ֹּ]", "יִ", "ײַ", "פֿ"},
  to = {"א", "ב", "ו", "י", "יי", "פ"}
 },
}
m["yo"] = {
 "Yoruba",
 34311,
 "alv-yor",
 "Latn, Arab",
 entry_name = {Latn = {remove_diacritics = c.grave .. c.acute .. c.macron}},
 sort_key = {
  Latn = {
   from = {"ẹ", "ɛ", "gb", "ị", "kp", "ọ", "ɔ", "ṣ", "sh", "ụ"},
   to = {"e" .. p[1], "e" .. p[1], "g" .. p[1], "i" .. p[1], "k" .. p[1], "o" .. p[1], "o" .. p[1], "s" .. p[1], "s" .. p[1], "u" .. p[1]}
  },
 },
}
m["za"] = {
 "Zhuang",
 13216,
 "tai",
 "Latn, Hani",
 sort_key = {
  Latn = "za-sortkey",
  Hani = "Hani-sortkey",
 },
}
m["zh"] = {
 "Chinese",
 7850,
 "zhx",
 "Hani, Hant, Hans, Latn, Bopo, Nshu, Brai",
 ancestors = "ltc",
 generate_forms = "zh-generateforms",
 translit = {
  Hani = "zh-translit",
  Bopo = "zh-translit",
 },
 sort_key = {Hani = "Hani-sortkey"},
}
m["zu"] = {
 "Zulu",
 10179,
 "bnt-ngu",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.macron .. c.caron},
}
m["aav-khs-pro"] = {
 "Proto-Khasian",
 nil,
 "aav-khs",
 "Latnx",
 type = "reconstructed",
}
m["aav-nic-pro"] = {
 "Proto-Nicobarese",
 nil,
 "aav-nic",
 "Latnx",
 type = "reconstructed",
}
m["aav-pkl-pro"] = {
 "Proto-Pnar-Khasi-Lyngngam",
 nil,
 "aav-pkl",
 "Latnx",
 type = "reconstructed",
}
m["aav-pro"] = { --The mkh-pro will merge into this.
 "Proto-Austroasiatic",
 nil,
 "aav",
 "Latnx",
 type = "reconstructed",
}
m["afa-pro"] = {
 "Proto-Afroasiatic",
 269125,
 "afa",
 "Latnx",
 type = "reconstructed",
}
m["alg-aga"] = {
 "Agawam",
 nil,
 "alg-eas",
 "Latn",
}
m["alg-pro"] = {
 "Proto-Algonquian",
 7251834,
 "alg",
 "Latnx",
 type = "reconstructed",
 sort_key = {remove_diacritics = "·"},
}
m["alv-ama"] = {
 "Amasi",
 4740400,
 "nic-grs",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.tilde .. c.macron},
}
m["alv-bgu"] = {
 "Baïnounk Gubëeher",
 17002646,
 "alv-bny",
 "Latn",
}
m["alv-bua-pro"] = {
 "Proto-Bua",
 nil,
 "alv-bua",
 "Latn",
 type = "reconstructed",
}
m["alv-cng-pro"] = {
 "Proto-Cangin",
 nil,
 "alv-cng",
 "Latn",
 type = "reconstructed",
}
m["alv-edo-pro"] = {
 "Proto-Edoid",
 nil,
 "alv-edo",
 "Latn",
 type = "reconstructed",
}
m["alv-fli-pro"] = {
 "Proto-Fali",
 nil,
 "alv-fli",
 "Latn",
 type = "reconstructed",
}
m["alv-gbe-pro"] = {
 "Proto-Gbe",
 nil,
 "alv-gbe",
 "Latn",
 type = "reconstructed",
}
m["alv-gng-pro"] = {
 "Proto-Guang",
 nil,
 "alv-gng",
 "Latn",
 type = "reconstructed",
}
m["alv-gtm-pro"] = {
 "Proto-Central Togo",
 nil,
 "alv-gtm",
 "Latn",
 type = "reconstructed",
}
m["alv-gwa"] = {
 "Gwara",
 16945580,
 "nic-pla",
 "Latn",
}
m["alv-hei-pro"] = {
 "Proto-Heiban",
 nil,
 "alv-hei",
 "Latn",
 type = "reconstructed",
}
m["alv-ido-pro"] = {
 "Proto-Idomoid",
 nil,
 "alv-ido",
 "Latn",
 type = "reconstructed",
}
m["alv-igb-pro"] = {
 "Proto-Igboid",
 nil,
 "alv-igb",
 "Latn",
 type = "reconstructed",
}
m["alv-kwa-pro"] = {
 "Proto-Kwa",
 nil,
 "alv-kwa",
 "Latn",
 type = "reconstructed",
}
m["alv-mum-pro"] = {
 "Proto-Mumuye",
 nil,
 "alv-mum",
 "Latn",
 type = "reconstructed",
}
m["alv-nup-pro"] = {
 "Proto-Nupoid",
 nil,
 "alv-nup",
 "Latn",
 type = "reconstructed",
}
m["alv-pro"] = {
 "Proto-Atlantic-Congo",
 nil,
 "alv",
 "Latn",
 type = "reconstructed",
}
m["alv-edk-pro"] = {
 "Proto-Edekiri",
 nil,
 "alv-edk",
 "Latn",
 type = "reconstructed",
}
m["alv-yor-pro"] = {
 "Proto-Yoruba",
 nil,
 "alv-yor",
 "Latn",
 type = "reconstructed",
}
m["alv-yrd-pro"] = {
 "Proto-Yoruboid",
 nil,
 "alv-yrd",
 "Latn",
 type = "reconstructed",
}
m["alv-von-pro"] = {
 "Proto-Volta-Niger",
 nil,
 "alv-von",
 "Latn",
 type = "reconstructed",
}
m["apa-pro"] = {
 "Proto-Apachean",
 nil,
 "apa",
 "Latnx",
 type = "reconstructed",
}
m["aql-pro"] = {
 "Proto-Algic",
 18389588,
 "aql",
 "Latnx",
 type = "reconstructed",
 sort_key = {remove_diacritics = "·"},
}
m["art-bel"] = {
 "Belter Creole",
 108055510,
 "art",
 "Latn",
 type = "appendix-constructed",
 sort_key = {
  remove_diacritics = c.acute,
  from = {"ɒ"},
  to = {"a"},
 },
}
m["art-blk"] = {
 "Bolak",
 2909283,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["art-bsp"] = {
 "Black Speech",
 686210,
 "art",
 "Latn, Teng",
 type = "appendix-constructed",
}
m["art-com"] = {
 "Communicationssprache",
 35227,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["art-dtk"] = {
 "Dothraki",
 2914733,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["art-elo"] = {
 "Eloi",
 nil,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["art-gld"] = {
 "Goa'uld",
 19823,
 "art",
 "Latn, Egyp, Mero",
 type = "appendix-constructed",
}
m["art-lap"] = {
 "Lapine",
 6488195,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["art-man"] = {
 "Mandalorian",
 54289,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["art-mun"] = {
 "Mundolinco",
 851355,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["art-nav"] = {
 "Na'vi",
 316939,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["art-una"] = {
 "Unas",
 nil,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["art-vlh"] = {
 "High Valyrian",
 64483808,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["ath-nic"] = {
 "Nicola",
 20609,
 "ath-nor",
 "Latn",
}
m["ath-pro"] = {
 "Proto-Athabaskan",
 nil,
 "ath",
 "Latnx",
 type = "reconstructed",
}
m["auf-pro"] = {
 "Proto-Arawa",
 nil,
 "auf",
 "Latnx",
 type = "reconstructed",
}
m["aus-alu"] = {
 "Alungul",
 16827670,
 "aus-pmn",
 "Latn",
}
m["aus-and"] = {
 "Andjingith",
 4754509,
 "aus-pmn",
 "Latn",
}
m["aus-ang"] = {
 "Angkula",
 16828520,
 "aus-pmn",
 "Latn",
}
m["aus-arn-pro"] = {
 "Proto-Arnhem",
 nil,
 "aus-arn",
 "Latnx",
 type = "reconstructed",
}
m["aus-bra"] = {
 "Barranbinya",
 4863220,
 "aus-pmn",
 "Latn",
}
m["aus-brm"] = {
 "Barunggam",
 4865914,
 "aus-pmn",
 "Latn",
}
m["aus-cww-pro"] = {
 "Proto-Central New South Wales",
 nil,
 "aus-cww",
 "Latnx",
 type = "reconstructed",
}
m["aus-dal-pro"] = {
 "Proto-Daly",
 nil,
 "aus-dal",
 "Latnx",
 type = "reconstructed",
}
m["aus-guw"] = {
 "Guwar",
 6652138,
 "aus-pam",
 "Latn",
}
m["aus-lsw"] = {
 "Little Swanport",
 6652138,
 nil,
 "Latn",
}
m["aus-mbi"] = {
 "Mbiywom",
 6799701,
 "aus-pmn",
 "Latn",
}
m["aus-ngk"] = {
 "Ngkoth",
 7022405,
 "aus-pmn",
 "Latn",
}
m["aus-nyu-pro"] = {
 "Proto-Nyulnyulan",
 nil,
 "aus-nyu",
 "Latnx",
 type = "reconstructed",
}
m["aus-pam-pro"] = {
 "Proto-Pama-Nyungan",
 33942,
 "aus-pam",
 "Latnx",
 type = "reconstructed",
}
m["aus-tul"] = {
 "Tulua",
 16938541,
 "aus-pam",
 "Latn",
}
m["aus-uwi"] = {
 "Uwinymil",
 7903995,
 "aus-arn",
 "Latn",
}
m["aus-wdj-pro"] = {
 "Proto-Iwaidjan",
 nil,
 "aus-wdj",
 "Latnx",
 type = "reconstructed",
}
m["aus-won"] = {
 "Wong-gie",
 nil,
 "aus-pam",
 "Latn",
}
m["aus-wul"] = {
 "Wulguru",
 8039196,
 "aus-dyb",
 "Latn",
}
m["aus-ynk"] = { -- contrast nny
 "Yangkaal",
 3913770,
 "aus-tnk",
 "Latn",
}
m["awd-amc-pro"] = {
 "Proto-Amuesha-Chamicuro",
 nil,
 "awd",
 "Latn",
 type = "reconstructed",
 ancestors = "awd-pro",
}
m["awd-kmp-pro"] = {
 "Proto-Kampa",
 nil,
 "awd",
 "Latn",
 type = "reconstructed",
 ancestors = "awd-pro",
}
m["awd-prw-pro"] = {
 "Proto-Paresi-Waura",
 nil,
 "awd",
 "Latn",
 type = "reconstructed",
 ancestors = "awd-pro",
}
m["awd-ama"] = {
 "Amarizana",
 16827787,
 "awd",
 "Latn",
}
m["awd-ana"] = {
 "Anauyá",
 16828252,
 "awd",
 "Latn",
}
m["awd-apo"] = {
 "Apolista",
 16916645,
 "awd",
 "Latn",
}
m["awd-cav"] = {
 "Cavere",
 nil,
 "awd",
 "Latn",
}
m["awd-gnu"] = {
 "Guinau",
 3504087,
 "awd",
 "Latn",
}
m["awd-kar"] = {
 "Cariay",
 16920253,
 "awd",
 "Latn",
}
m["awd-kaw"] = {
 "Kawishana",
 6379993,
 "awd-nwk",
 "Latn",
}
m["awd-kus"] = {
 "Kustenau",
 5196293,
 "awd",
 "Latn",
}
m["awd-man"] = {
 "Manao",
 6746920,
 "awd",
 "Latn",
}
m["awd-mar"] = {
 "Marawan",
 6755108,
 "awd",
 "Latn",
}
m["awd-mpr"] = {
 "Maypure",
 nil,
 "awd",
 "Latn",
}
m["awd-mrt"] = {
 "Mariaté",
 16910017,
 "awd-nwk",
 "Latn",
}
m["awd-nwk-pro"] = {
 "Proto-Nawiki",
 nil,
 "awd-nwk",
 "Latn",
 type = "reconstructed",
}
m["awd-pai"] = {
 "Paikoneka",
 nil,
 "awd",
 "Latn",
}
m["awd-pas"] = {
 "Passé",
 nil,
 "awd-nwk",
 "Latn",
}
m["awd-pro"] = {
 "Proto-Arawak",
 nil,
 "awd",
 "Latn",
 type = "reconstructed",
}
m["awd-she"] = {
 "Shebayo",
 7492248,
 "awd",
 "Latn",
}
m["awd-taa-pro"] = {
 "Proto-Ta-Arawak",
 nil,
 "awd-taa",
 "Latn",
 type = "reconstructed",
}
m["awd-wai"] = {
 "Wainumá",
 16910017,
 "awd-nwk",
 "Latn",
}
m["awd-yum"] = {
 "Yumana",
 8061062,
 "awd-nwk",
 "Latn",
}
m["azc-caz"] = {
 "Cazcan",
 5055514,
 "azc",
 "Latn",
}
m["azc-cup-pro"] = {
 "Proto-Cupan",
 nil,
 "azc-cup",
 "Latnx",
 type = "reconstructed",
}
m["azc-ktn"] = {
 "Kitanemuk",
 3197558,
 "azc-tak",
 "Latn",
}
m["azc-nah-pro"] = {
 "Proto-Nahuan",
 7251860,
 "azc-nah",
 "Latnx",
 type = "reconstructed",
}
m["azc-num-pro"] = {
 "Proto-Numic",
 nil,
 "azc-num",
 "Latnx",
 type = "reconstructed",
}
m["azc-pro"] = {
 "Proto-Uto-Aztecan",
 96400333,
 "azc",
 "Latnx",
 type = "reconstructed",
}
m["azc-tak-pro"] = {
 "Proto-Takic",
 nil,
 "azc-tak",
 "Latnx",
 type = "reconstructed",
}
m["azc-tat"] = {
 "Tataviam",
 743736,
 "azc",
 "Latn",
}
m["ber-pro"] = {
 "Proto-Berber",
 2855698,
 "ber",
 "Latnx",
 type = "reconstructed",
}
m["ber-fog"] = {
 "Fogaha",
 107610173,
 "ber",
 "Latn",
}
m["ber-zuw"] = {
 "Zuwara",
 4117169,
 "ber",
 "Latn",
}
m["bnt-bal"] = {
 "Balong",
 93935237,
 "bnt-bbo",
 "Latn",
}
m["bnt-bon"] = {
 "Boma Nkuu",
 nil,
 "bnt",
 "Latn",
}
m["bnt-boy"] = {
 "Boma Yumu",
 nil,
 "bnt",
 "Latn",
}
m["bnt-bwa"] = {
 "Bwala",
 nil,
 "bnt-tek",
 "Latn",
}
m["bnt-cmw"] = {
 "Chimwiini",
 4958328,
 "bnt-swh",
 "Latn",
}
m["bnt-ind"] = {
 "Indanga",
 51412803,
 "bnt",
 "Latn",
}
m["bnt-lal"] = {
 "Lala (South Africa)",
 6480154,
 "bnt-ngu",
 "Latn",
}
m["bnt-lwl"] = {
 "Lwel",
 93936908,
 "bnt-bdz",
 "Latn",
}
m["bnt-mpi"] = {
 "Mpiin",
 93937013,
 "bnt-bdz",
 "Latn",
}
m["bnt-mpu"] = {
 "Mpuono", --not to be confused with Mbuun zmp
 36056,
 "bnt",
 "Latn",
}
m["bnt-ngu-pro"] = {
 "Proto-Nguni",
 961559,
 "bnt-ngu",
 "Latnx",
 type = "reconstructed",
 sort_key = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.caron},
}
m["bnt-phu"] = {
 "Phuthi",
 33796,
 "bnt-ngu",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute},
}
m["bnt-pro"] = {
 "Proto-Bantu",
 3408025,
 "bnt",
 "Latnx",
 type = "reconstructed",
 sort_key = "bnt-pro-sortkey",
}
m["bnt-sbo"] = {
 "South Boma",
 nil,
 "bnt",
 "Latn",
}
m["bnt-sts-pro"] = {
 "Proto-Sotho-Tswana",
 nil,
 "bnt-sts",
 "Latn",
 type = "reconstructed",
}
m["btk-pro"] = {
 "Proto-Batak",
 nil,
 "btk",
 "Latnx",
 type = "reconstructed",
}
m["cau-abz-pro"] = {
 "Proto-Abkhaz-Abaza",
 7251831,
 "cau-abz",
 "Latnx",
 type = "reconstructed",
}
m["cau-ava-pro"] = {
 "Proto-Avaro-Andian",
 nil,
 "cau-ava",
 "Latnx",
 type = "reconstructed",
}
m["cau-cir-pro"] = {
 "Proto-Circassian",
 7251838,
 "cau-cir",
 "Latnx",
 type = "reconstructed",
}
m["cau-drg-pro"] = {
 "Proto-Dargwa",
 nil,
 "cau-drg",
 "Latnx",
 type = "reconstructed",
}
m["cau-lzg-pro"] = {
 "Proto-Lezghian",
 nil,
 "cau-lzg",
 "Latnx",
 type = "reconstructed",
}
m["cau-nec-pro"] = {
 "Proto-Northeast Caucasian",
 nil,
 "cau-nec",
 "Latnx",
 type = "reconstructed",
}
m["cau-nkh-pro"] = {
 "Proto-Nakh",
 nil,
 "cau-nkh",
 "Latnx",
 type = "reconstructed",
}
m["cau-nwc-pro"] = {
 "Proto-Northwest Caucasian",
 7251861,
 "cau-nwc",
 "Latnx",
 type = "reconstructed",
}
m["cau-tsz-pro"] = {
 "Proto-Tsezian",
 nil,
 "cau-tsz",
 "Latnx",
 type = "reconstructed",
}
m["cba-ata"] = {
 "Atanques",
 4812783,
 "cba",
 "Latn",
}
m["cba-cat"] = {
 "Catío Chibcha",
 7083619,
 "cba",
 "Latn",
}
m["cba-dor"] = {
 "Dorasque",
 5297532,
 "cba",
 "Latn",
}
m["cba-dui"] = {
 "Duit",
 3041061,
 "cba",
 "Latn",
}
m["cba-hue"] = {
 "Huetar",
 35514,
 "cba",
 "Latn",
}
m["cba-nut"] = {
 "Nutabe",
 7070405,
 "cba",
 "Latn",
}
m["cba-pro"] = {
 "Proto-Chibchan",
 nil,
 "cba",
 "Latnx",
 type = "reconstructed",
}
m["ccn-pro"] = {
 "Proto-North Caucasian",
 nil,
 "ccn",
 "Latnx",
 type = "reconstructed",
}
m["ccs-pro"] = {
 "Proto-Kartvelian",
 2608203,
 "ccs",
 "Latnx",
 type = "reconstructed",
 entry_name = {
  from = {"q̣", "p̣", "ʓ", "ċ"},
  to = {"q̇", "ṗ", "ʒ", "c̣"}
 },
}
m["ccs-gzn-pro"] = {
 "Proto-Georgian-Zan",
 23808119,
 "ccs-gzn",
 "Latnx",
 type = "reconstructed",
 entry_name = {
  from = {"q̣", "p̣", "ʓ", "ċ"},
  to = {"q̇", "ṗ", "ʒ", "c̣"}
 },
}
m["cdc-cbm-pro"] = {
 "Proto-Central Chadic",
 nil,
 "cdc-cbm",
 "Latn",
 type = "reconstructed",
}
m["cdc-mas-pro"] = {
 "Proto-Masa",
 nil,
 "cdc-mas",
 "Latn",
 type = "reconstructed",
}
m["cdc-pro"] = {
 "Proto-Chadic",
 nil,
 "cdc",
 "Latn",
 type = "reconstructed",
}
m["cdd-pro"] = {
 "Proto-Caddoan",
 nil,
 "cdd",
 "Latnx",
 type = "reconstructed",
}
m["cel-bry-pro"] = {
 "Proto-Brythonic",
 156877,
 "cel-bry",
 "Latnx, Grek",
 sort_key = "cel-bry-pro-sortkey",
}
m["cel-gal"] = {
 "Gallaecian",
 3094789,
 "cel",
}
m["cel-gau"] = {
 "Gaulish",
 29977,
 "cel",
 "Latn, Grek, Ital",
 entry_name = {remove_diacritics = c.macron .. c.breve .. c.diaer},
}
m["cel-pro"] = {
 "Proto-Celtic",
 653649,
 "cel",
 "Latnx",
 type = "reconstructed",
 sort_key = "cel-pro-sortkey",
}
m["chi-pro"] = {
 "Proto-Chimakuan",
 nil,
 "chi",
 "Latnx",
 type = "reconstructed",
}
m["chm-pro"] = {
 "Proto-Mari",
 nil,
 "chm",
 "Latn",
 type = "reconstructed",
}
m["cmc-pro"] = {
 "Proto-Chamic",
 nil,
 "cmc",
 "Latnx",
 type = "reconstructed",
}
m["cpe-mar"] = {
 "Maroon Spirit Language",
 1093206,
 "crp",
 "Latn",
 ancestors = "en",
}
m["cpe-spp"] = {
 "Samoan Plantation Pidgin",
 7409948,
 "crp",
 "Latn",
 ancestors = "en",
}
m["crp-bip"] = {
 "Basque-Icelandic Pidgin",
 810378,
 "crp",
 "Latn",
 ancestors = "eu",
}
m["crp-gep"] = {
 "West Greenlandic Pidgin",
 17036301,
 "crp",
 "Latn",
 ancestors = "kl",
}
m["crp-mpp"] = {
 "Macau Pidgin Portuguese",
 nil,
 "crp",
 "Hant, Latn",
 ancestors = "pt",
 sort_key = {Hant = "Hani-sortkey"},
}
m["crp-rsn"] = {
 "Russenorsk",
 505125,
 "crp",
 "Cyrl, Latn",
 ancestors = "nn, ru",
}
m["crp-tnw"] = {
 "Tangwang",
 7683179,
 "crp",
 "Arab, Latn",
 ancestors = "cmn, sce",
}
m["crp-tpr"] = {
 "Taimyr Pidgin Russian",
 16930506,
 "crp",
 "Cyrl",
 ancestors = "ru",
}
m["csu-bba-pro"] = {
 "Proto-Bongo-Bagirmi",
 nil,
 "csu-bba",
 "Latnx",
 type = "reconstructed",
}
m["csu-maa-pro"] = {
 "Proto-Mangbetu",
 nil,
 "csu-maa",
 "Latnx",
 type = "reconstructed",
}
m["csu-pro"] = {
 "Proto-Central Sudanic",
 nil,
 "csu",
 "Latnx",
 type = "reconstructed",
}
m["csu-sar-pro"] = {
 "Proto-Sara",
 nil,
 "csu-sar",
 "Latnx",
 type = "reconstructed",
}
m["ctp-san"] = {
 "San Juan Quiahije Chatino",
 nil,
 "omq-cha",
 "Latnx",
}
m["cus-ash"] = {
 "Ashraaf",
 4805855,
 "cus-som",
 "Latn",
}
m["cus-hec-pro"] = {
 "Proto-Highland East Cushitic",
 nil,
 "cus-hec",
 "Latnx",
 type = "reconstructed",
}
m["cus-som-pro"] = {
 "Proto-Somaloid",
 nil,
 "cus-som",
 "Latnx",
 type = "reconstructed",
}
m["cus-sou-pro"] = {
 "Proto-South Cushitic",
 nil,
 "cus-sou",
 "Latnx",
 type = "reconstructed",
}
m["cus-pro"] = {
 "Proto-Cushitic",
 nil,
 "cus",
 "Latnx",
 type = "reconstructed",
}
m["dmn-dam"] = {
 "Dama (Sierra Leone)",
 19601574,
 "dmn",
 "Latn",
}
m["dra-mkn"] = {
 "Middle Kannada",
 nil,
 "dra",
 "Knda",
 ancestors = "dra-okn",
 translit = "kn-translit",
}
m["dra-okn"] = {
 "Old Kannada",
 15723156,
 "dra",
 "Knda",
 ancestors = "dra-pro",
 translit = "kn-translit",
}
m["dra-ote"] = {
 "Old Telugu",
 nil,
 "dra",
 "Telu",
 ancestors = "dra-pro",
 translit = "te-translit",
}
m["dra-pro"] = {
 "Proto-Dravidian",
 1702853,
 "dra",
 "Latnx",
 type = "reconstructed",
}
m["egx-dem"] = {
 "Demotic",
 36765,
 "egx",
 "Latnx, Egyd, Polyt",
 translit = {
  Polyt = "grc-translit",
 },
 ancestors = "egy",
 sort_key = {
  remove_diacritics = "'%-%s",
  from = {"ꜣ", "j", "e", "ꜥ", "y", "w", "b", "p", "f", "m", "n", "r", "l", "ḥ", "ḫ", "h̭", "ẖ", "h", "š", "s", "q", "k", "g", "ṱ", "ṯ", "t", "ḏ", "%.", "⸗"},
  to = {p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9], p[10], p[11], p[12], p[13], p[15], p[16], p[16], p[17], p[14], p[19], p[18], p[20], p[21], p[22], p[23], p[24], p[23], p[25], p[26], p[26]}
 },
}
m["dmn-pro"] = {
 "Proto-Mande",
 nil,
 "dmn",
 "Latnx",
 type = "reconstructed",
}
m["dmn-mdw-pro"] = {
 "Proto-Western Mande",
 nil,
 "dmn-mdw",
 "Latnx",
 type = "reconstructed",
}
m["dru-pro"] = {
 "Proto-Rukai",
 nil,
 "map",
 "Latnx",
 type = "reconstructed",
}
m["esx-esk-pro"] = {
 "Proto-Eskimo",
 7251842,
 "esx-esk",
 "Latnx",
 type = "reconstructed",
}
m["esx-ink"] = {
 "Inuktun",
 1671647,
 "esx-inu",
 "Latn",
}
m["esx-inq"] = {
 "Inuinnaqtun",
 28070,
 "esx-inu",
 "Latn",
}
m["esx-inu-pro"] = {
 "Proto-Inuit",
 nil,
 "esx-inu",
 "Latnx",
 type = "reconstructed",
}
m["esx-pro"] = {
 "Proto-Eskimo-Aleut",
 7251843,
 "esx",
 "Latnx",
 type = "reconstructed",
}
m["esx-tut"] = {
 "Tunumiisut",
 15665389,
 "esx-inu",
 "Latn",
}
m["euq-pro"] = {
 "Proto-Basque",
 938011,
 "euq",
 "Latnx",
 type = "reconstructed",
}
m["gem-bur"] = {
 "Burgundian",
 nil,
 "gme",
 "Latn",
}
m["gem-pro"] = {
 "Proto-Germanic",
 669623,
 "gem",
 "Latnx",
 type = "reconstructed",
 sort_key = "gem-pro-sortkey",
}
m["gme-cgo"] = {
 "Crimean Gothic",
 36211,
 "gme",
 "Latn",
}
m["gmq-gut"] = {
 "Gutnish",
 1256646,
 "gmq",
 "Latn",
 ancestors = "non",
}
m["gmq-jmk"] = {
 "Jamtish",
 nil,
 "gmq",
 "Latn",
 ancestors = "non",
}
m["gmq-mno"] = {
 "Middle Norwegian",
 3417070,
 "gmq",
 "Latn",
 ancestors = "non",
}
m["gmq-oda"] = {
 "Old Danish",
 nil,
 "gmq",
 "Latn",
 ancestors = "non",
 entry_name = {remove_diacritics = c.macron},
}
m["gmq-ogt"] = {
 "Old Gutnish",
 1133488,
 "gmq",
 "Latn",
 ancestors = "non",
}
m["gmq-osw"] = {
 "Old Swedish",
 2417210,
 "gmq",
 "Latn",
 ancestors = "non",
 entry_name = {remove_diacritics = c.macron},
}
m["gmq-pro"] = {
 "Proto-Norse",
 1671294,
 "gmq",
 "Runr",
 translit = "Runr-translit",
}
m["gmq-scy"] = {
 "Scanian",
 768017,
 "gmq",
 "Latn",
 ancestors = "non",
}
m["gmw-bgh"] = {
 "Bergish",
 329030,
 "gmw",
 "Latn",
 ancestors = "odt",
}
m["gmw-cfr"] = {
 "Central Franconian",
 nil,
 "gmw",
 "Latn",
 ancestors = "gmh",
 wikimedia_codes = "ksh",
}
m["gmw-ecg"] = {
 "East Central German",
 499344, -- subsumes Q699284, Q152965
 "gmw",
 "Latn",
 ancestors = "gmh",
}
m["gmw-fin"] = {
 "Fingallian",
 3072588,
 "gmw",
 "Latn",
 ancestors = "enm",
}
m["gmw-gts"] = {
 "Gottscheerish",
 533109,
 "gmw",
 "Latn",
 ancestors = "bar",
}
m["gmw-jdt"] = {
 "Jersey Dutch",
 1687911,
 "gmw",
 "Latn",
 ancestors = "nl",
}
m["gmw-pro"] = {
 "Proto-West Germanic",
 78079021,
 "gmw",
 "Latnx",
 type = "reconstructed",
 sort_key = "gmw-pro-sortkey",
}
m["gmw-rfr"] = {
 "Rhine Franconian",
 707007,
 "gmw",
 "Latn",
 ancestors = "gmh",
}
m["gmw-stm"] = {
 "Sathmar Swabian",
 2223059,
 "gmw",
 "Latn",
 ancestors = "swg",
}
m["gmw-tsx"] = {
 "Transylvanian Saxon",
 260942,
 "gmw",
 "Latn",
 ancestors = "gmw-cfr",
}
m["gmw-vog"] = {
 "Volga German",
 312574,
 "gmw",
 "Latn",
 ancestors = "gmw-rfr",
}
m["gmw-zps"] = {
 "Zipser German",
 205548,
 "gmw",
 "Latn",
 ancestors = "gmh",
}
m["gn-cls"] = {
 "Classical Guaraní",
 17478065,
 "tup-gua",
 "Latn",
 ancestors = "gn",
}
m["grk-cal"] = {
 "Calabrian Greek",
 1146398,
 "grk",
 "Latn",
 ancestors = "grk-ita",
}
m["grk-ita"] = {
 "Italiot Greek",
 nil,
 "grk",
 "Latn, Grek",
 ancestors = "gkm",
 entry_name = {remove_diacritics = c.caron .. c.diaerbelow .. c.brevebelow},
 sort_key = s["Grek-sortkey"],
}
m["grk-mar"] = {
 "Mariupol Greek",
 4400023,
 "grk",
 "Cyrl, Latn, Grek",
 ancestors = "gkm",
 translit = "grk-mar-translit",
 override_translit = true,
 entry_name = "grk-mar-entryname",
 sort_key = s["Grek-sortkey"],
}
m["grk-pro"] = {
 "Proto-Hellenic",
 1231805,
 "grk",
 "Latnx",
 type = "reconstructed",
 sort_key = {
  from = {"[áā]", "[éēḗ]", "[íī]", "[óōṓ]", "[úū]", "ď", "ľ", "ň", "ř", "ʰ", "ʷ", c.acute, c.macron},
  to = {"a", "e", "i", "o", "u", "d", "l", "n", "r", "¯h", "¯w"}
 },
}
m["hmn-pro"] = {
 "Proto-Hmong",
 nil,
 "hmn",
 "Latnx",
 type = "reconstructed",
}
m["hmx-mie-pro"] = {
 "Proto-Mien",
 nil,
 "hmx-mie",
 "Latnx",
 type = "reconstructed",
}
m["hmx-pro"] = {
 "Proto-Hmong-Mien",
 7251846,
 "hmx",
 "Latnx",
 type = "reconstructed",
}
m["hyx-pro"] = {
 "Proto-Armenian",
 3848498,
 "hyx",
 "Latn",
 type = "reconstructed",
}
m["iir-nur-pro"] = {
 "Proto-Nuristani",
 nil,
 "iir-nur",
 "Latnx",
 type = "reconstructed",
}
m["iir-pro"] = {
 "Proto-Indo-Iranian",
 966439,
 "iir",
 "Latnx",
 type = "reconstructed",
}
m["ijo-pro"] = {
 "Proto-Ijoid",
 nil,
 "ijo",
 "Latnx",
 type = "reconstructed",
}
m["inc-ash"] = {
 "Ashokan Prakrit",
 nil,
 "inc-mid",
 "Brah, Khar",
 ancestors = "sa",
 translit = {
  Brah = "Brah-translit",
  Khar = "Khar-translit",
 },
}
m["inc-gup"] = {
 "Gurjar Apabhramsa",
 nil,
 "inc-mid",
 "Deva",
 ancestors = "pra-sau",
}
m["inc-kam"] = {
 "Kamarupi Prakrit",
 6356097,
 "inc-mid",
 "Brah, Sidd",
 ancestors = "pra-mag",
}
m["inc-kho"] = {
 "Kholosi",
 24952008,
 "inc-snd",
 "Latn",
 ancestors = "inc-vra",
}
m["inc-mas"] = {
 "Middle Assamese",
 nil,
 "inc-eas",
 "as-Beng",
 ancestors = "inc-oas",
 translit = "inc-mas-translit",
}
m["inc-mbn"] = {
 "Middle Bengali",
 nil,
 "inc-eas",
 "Beng",
 ancestors = "inc-obn",
 translit = "inc-mbn-translit",
}
m["inc-mgu"] = {
 "Middle Gujarati",
 24907429,
 "inc-wes",
 "Deva",
 ancestors = "inc-ogu",
}
m["inc-mor"] = {
 "Middle Odia",
 nil,
 "inc-eas",
 "Orya",
 ancestors = "inc-oor",
}
m["inc-oas"] = {
 "Early Assamese",
 nil,
 "inc-eas",
 "as-Beng",
 ancestors = "inc-kam",
 translit = "inc-oas-translit",
}
m["inc-obn"] = {
 "Old Bengali",
 nil,
 "inc-eas",
 "Beng",
 ancestors = "pra-mag",
}
m["inc-ogu"] = {
 "Old Gujarati",
 24907427,
 "inc-wes",
 "Deva",
 ancestors = "inc-gup",
 translit = "sa-translit",
}
m["inc-ohi"] = {
 "Old Hindi",
 48767781,
 "inc-hiw",
 "Deva, ur-Arab",
 ancestors = "inc-sap",
 translit = "sa-translit",
 entry_name = {
  from = {"هٔ", "ۂ"}, -- character "ۂ" code U+06C2 to "ه" and "هٔ" (U+0647 + U+0654) to "ه"
  to = {"ہ", "ہ"},
  remove_diacritics = c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun .. c.nunghunna .. c.superalef
 },
}
m["inc-oor"] = {
 "Old Odia",
 nil,
 "inc-eas",
 "Orya",
 ancestors = "pra-mag",
}
m["inc-opa"] = {
 "Old Punjabi",
 nil,
 "inc-pan",
 "Guru, pa-Arab",
 ancestors = "inc-tak",
 translit = {
  Guru = "inc-opa-Guru-translit",
  ["pa-Arab"] = "pa-Arab-translit",
 },
 entry_name = {remove_diacritics = c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun},
}
m["inc-ork"] = {
 "Old Kamta",
 nil,
 "inc-eas",
 "as-Beng",
 ancestors = "inc-kam",
 translit = "as-translit",
}
m["inc-pra"] = {
 "Prakrit",
 192170,
 "inc-mid",
 "Brah, Deva, Knda",
 ancestors = "inc-ash",
 translit = {
  Brah = "Brah-translit",
  Deva = "inc-pra-Deva-translit",
  Knda = "inc-pra-Knda-translit",
 },
 entry_name = {
  from = {"ऎ", "ऒ", u(0x0946), u(0x094A), "य़", "ಯ಼", u(0x11071), u(0x11072), u(0x11073), u(0x11074)},
  to = {"ए", "ओ", u(0x0947), u(0x094B), "य", "ಯ", "𑀏", "𑀑", u(0x11042), u(0x11044)}
 } ,
}
m["inc-pro"] = {
 "Proto-Indo-Aryan",
 23808344,
 "inc",
 "Latnx",
 type = "reconstructed",
}
m["inc-sap"] = {
 "Sauraseni Apabhramsa",
 nil,
 "inc-mid",
 "Deva",
 ancestors = "pra-sau",
}
m["inc-tak"] = {
 "Takka Apabhramsa",
 nil,
 "inc-mid",
 "Deva",
 ancestors = "inc-pra",
 translit = "sa-translit",
}
m["inc-vra"] = {
 "Vracada Apabhramsa",
 nil,
 "inc-mid",
 "Deva",
 ancestors = "inc-pra",
 translit = "sa-translit",
}
m["inc-cen-pro"] = {
 "Proto-Central Indo-Aryan",
 nil,
 "inc-cen",
 "Latnx",
 type = "reconstructed",
 ancestors = "pra-sau",
}
m["ine-ana-pro"] = {
 "Proto-Anatolian",
 7251833,
 "ine-ana",
 "Latnx",
 type = "reconstructed",
}
m["ine-bsl-pro"] = {
 "Proto-Balto-Slavic",
 1703347,
 "ine-bsl",
 "Latnx",
 type = "reconstructed",
 sort_key = {
  from = {"[áā]", "[éēḗ]", "[íī]", "[óōṓ]", "[úū]", c.acute, c.macron, "ˀ"},
  to = {"a", "e", "i", "o", "u"}
 },
}
m["ine-pae"] = {
 "Paeonian",
 2705672,
 "ine",
 "Polyt",
 translit = "grc-translit",
 entry_name = {remove_diacritics = c.macron .. c.breve},
 sort_key = s["Grek-sortkey"],
}
m["ine-pro"] = {
 "Proto-Indo-European",
 37178,
 "ine",
 "Latnx",
 type = "reconstructed",
 sort_key = {
  from = {"[áā]", "[éēḗ]", "[íī]", "[óōṓ]", "[úū]", "ĺ", "ḿ", "ń", "ŕ", "ǵ", "ḱ", "ʰ", "ʷ", "₁", "₂", "₃", c.ringbelow, c.acute, c.macron},
  to = {"a", "e", "i", "o", "u", "l", "m", "n", "r", "g'", "k'", "¯h", "¯w", "1", "2", "3"}
 },
}
m["ine-toc-pro"] = {
 "Proto-Tocharian",
 37029,
 "ine-toc",
 "Latnx",
 type = "reconstructed",
}
m["xme-old"] = {
 "Old Median",
 36461,
 "xme",
 "Grek, Latn",
}
m["xme-mid"] = {
 "Middle Median",
 nil,
 "xme",
 "Latn",
 ancestors = "xme-old",
}
m["xme-ker"] = {
 "Kermanic",
 129850,
 "xme",
 "fa-Arab, Latn",
 ancestors = "xme-mid",
}
m["xme-taf"] = {
 "Tafreshi",
 nil,
 "xme",
 "fa-Arab, Latn",
 ancestors = "xme-mid",
}
m["xme-ttc-pro"] = {
 "Proto-Tatic",
 nil,
 "xme-ttc",
 "Latn",
 ancestors = "xme-mid",
}
m["xme-kls"] = {
 "Kalasuri",
 nil,
 "xme-ttc",
 ancestors = "xme-ttc-nor",
}
m["xme-klt"] = {
 "Kilit",
 3612452,
 "xme-ttc",
 "Cyrl", -- and fa-Arab?
 ancestors = "xme-ttc-pro",
}
m["xme-ott"] = {
 "Old Tati",
 434697,
 "xme-ttc",
 "fa-Arab, Latnx",
 ancestors = "xme-ttc-pro",
}
m["ira-pro"] = {
 "Proto-Iranian",
 4167865,
 "ira",
 "Latnx",
 type = "reconstructed",
}
m["ira-mpr-pro"] = {
 "Proto-Medo-Parthian",
 nil,
 "ira-mpr",
 "Latnx",
 type = "reconstructed",
}
m["ira-kms-pro"] = {
 "Proto-Komisenian",
 nil,
 "ira-kms",
 "Latnx",
 type = "reconstructed",
}
m["ira-zgr-pro"] = {
 "Proto-Zaza-Gorani",
 nil,
 "ira-zgr",
 "Latnx",
 type = "reconstructed",
}
m["ira-pat-pro"] = {
 "Proto-Pathan",
 nil,
 "ira-pat",
 "Latnx",
 type = "reconstructed",
}
m["os-pro"] = {
 "Proto-Ossetic",
 nil,
 "xsc",
 "Latnx",
 type = "reconstructed",
}
m["xsc-pro"] = {
 "Proto-Scythian",
 nil,
 "xsc",
 "Latnx",
 type = "reconstructed",
}
m["xsc-skw-pro"] = {
 "Proto-Saka-Wakhi",
 nil,
 "xsc-skw",
 "Latnx",
 type = "reconstructed",
 ancestors = "xsc-pro",
}
m["xsc-sak-pro"] = {
 "Proto-Saka",
 nil,
 "xsc-sak",
 "Latnx",
 type = "reconstructed",
 ancestors = "xsc-skw-pro",
}
m["ira-sym-pro"] = {
 "Proto-Shughni-Yazghulami-Munji",
 nil,
 "ira-sym",
 "Latnx",
 type = "reconstructed",
}
m["ira-sgi-pro"] = {
 "Proto-Sanglechi-Ishkashimi",
 nil,
 "ira-sgi",
 "Latnx",
 type = "reconstructed",
}
m["ira-mny-pro"] = {
 "Proto-Munji-Yidgha",
 nil,
 "ira-mny",
 "Latnx",
 type = "reconstructed",
 ancestors = "ira-sym-pro",
}
m["ira-shy-pro"] = {
 "Proto-Shughni-Yazghulami",
 nil,
 "ira-shy",
 "Latnx",
 type = "reconstructed",
 ancestors = "ira-sym-pro",
}
m["ira-shr-pro"] = {
 "Proto-Shughni-Roshani",
 nil,
 "ira-shy",
 "Latnx",
 type = "reconstructed",
 ancestors = "ira-shy-pro",
}
m["ira-sgc-pro"] = {
 "Proto-Sogdic",
 nil,
 "ira-sgc",
 "Latnx",
 type = "reconstructed",
}
m["ira-wnj"] = {
 "Vanji",
 nil,
 "ira-shy",
 "Latnx",
 ancestors = "ira-shy-pro",
}
m["iro-ere"] = {
 "Erie",
 5388365,
 "iro-nor",
 "Latn",
}
m["iro-min"] = {
 "Mingo",
 128531,
 "iro-nor",
 "Latn",
}
m["iro-nor-pro"] = {
 "Proto-North Iroquoian",
 nil,
 "iro-nor",
 "Latnx",
 type = "reconstructed",
}
m["iro-pro"] = {
 "Proto-Iroquoian",
 7251852,
 "iro",
 "Latnx",
 type = "reconstructed",
}
m["itc-pro"] = {
 "Proto-Italic",
 17102720,
 "itc",
 "Latnx",
 type = "reconstructed",
}
m["jpx-pro"] = {
 "Proto-Japonic",
 nil,
 "jpx",
 "Latnx",
 type = "reconstructed",
}
m["jpx-ryu-pro"] = {
 "Proto-Ryukyuan",
 nil,
 "jpx-ryu",
 "Latnx",
 type = "reconstructed",
}
m["kar-pro"] = {
 "Proto-Karen",
 nil,
 "kar",
 "Latnx",
 type = "reconstructed",
}
m["khi-kho-pro"] = {
 "Proto-Khoe",
 nil,
 "khi-kho",
 "Latn",
 type = "reconstructed",
}
m["khi-kun"] = {
 "ǃKung",
 32904,
 "khi-kxa",
 "Latn",
}
m["ko-ear"] = {
 "Early Modern Korean",
 756014,
 "qfa-kor",
 "Kore",
 ancestors = "okm",
 translit = "okm-translit",
 entry_name = s["Kore-entryname"],
}
m["kro-pro"] = {
 "Proto-Kru",
 nil,
 "kro",
 "Latn",
 type = "reconstructed",
}
m["ku-pro"] = {
 "Proto-Kurdish",
 nil,
 "ku",
 "Latnx",
 type = "reconstructed",
}
m["map-ata-pro"] = {
 "Proto-Atayalic",
 nil,
 "map-ata",
 "Latnx",
 type = "reconstructed",
}
m["map-bms"] = {
 "Banyumasan",
 33219,
 "map",
 "Latn",
}
m["map-pro"] = {
 "Proto-Austronesian",
 49230,
 "map",
 "Latnx",
 type = "reconstructed",
}
m["mkh-asl-pro"] = {
 "Proto-Aslian",
 55630680,
 "mkh-asl",
 "Latn",
 type = "reconstructed",
}
m["mkh-ban-pro"] = {
 "Proto-Bahnaric",
 nil,
 "mkh-ban",
 "Latn",
 type = "reconstructed",
}
m["mkh-kat-pro"] = {
 "Proto-Katuic",
 nil,
 "mkh-kat",
 "Latnx",
 type = "reconstructed",
}
m["mkh-khm-pro"] = {
 "Proto-Khmuic",
 nil,
 "mkh-khm",
 "Latn",
 type = "reconstructed",
}
m["mkh-kmr-pro"] = {
 "Proto-Khmeric",
 55630684,
 "mkh-kmr",
 "Latn",
 type = "reconstructed",
}
m["mkh-mmn"] = {
 "Middle Mon",
 nil,
 "mkh-mnc",
 "Latnx, Mymr", --and also Pallava
 ancestors = "omx",
}
m["mkh-mnc-pro"] = {
 "Proto-Monic",
 nil,
 "mkh-mnc",
 "Latn",
 type = "reconstructed",
}
m["mkh-mvi"] = {
 "Middle Vietnamese",
 9199,
 "mkh-vie",
 "Hani, Latnx",
 sort_key = {Hani = "Hani-sortkey"},
}
m["mkh-pal-pro"] = {
 "Proto-Palaungic",
 nil,
 "mkh-pal",
 "Latnx",
 type = "reconstructed",
}
m["mkh-pea-pro"] = {
 "Proto-Pearic",
 nil,
 "mkh-pea",
 "Latnx",
 type = "reconstructed",
}
m["mkh-pkn-pro"] = {
 "Proto-Pakanic",
 nil,
 "mkh-pkn",
 "Latn",
 type = "reconstructed",
}
m["mkh-pro"] = { --This will be merged into 2015 aav-pro.
 "Proto-Mon-Khmer",
 7251859,
 "mkh",
 "Latnx",
 type = "reconstructed",
}
m["mkh-vie-pro"] = {
 "Proto-Vietic",
 nil,
 "mkh-vie",
 "Latnx",
 type = "reconstructed",
}
m["mnw-tha"] = {
 "Thai Mon",
 nil,
 "mkh-mnc",
 "Mymr, Thai",
 ancestors = "mkh-mmn",
 sort_key = {
  from = {"[%p]", "ျ", "ြ", "ွ", "ှ", "ၞ", "ၟ", "ၠ", "ၚ", "ဿ", "[็-๎]", "([เแโใไ])([ก-ฮ])ฺ?"},
  to = {"", "္ယ", "္ရ", "္ဝ", "္ဟ", "္န", "္မ", "္လ", "င", "သ္သ", "", "%2%1"}
  },
}
m["mun-pro"] = {
 "Proto-Munda",
 nil,
 "mun",
 "Latnx",
 type = "reconstructed",
}
m["myn-chl"] = { -- the stage after ''emy''
 "Ch'olti'",
 873995,
 "myn",
 "Latnx",
}
m["myn-pro"] = {
 "Proto-Mayan",
 3321532,
 "myn",
 "Latnx",
 type = "reconstructed",
}
m["nai-ala"] = {
 "Alazapa",
 nil,
 nil,
 "Latn",
}
m["nai-bay"] = {
 "Bayogoula",
 1563704,
 nil,
 "Latn",
}
m["nai-bvy"] = {
 "Buena Vista Yokuts",
 4985474,
 "nai-yok",
 "Latn",
}
m["nai-cal"] = {
 "Calusa",
 51782,
 nil,
 "Latn",
}
m["nai-chi"] = {
 "Chiquimulilla",
 25339627,
 "nai-xin",
 "Latn",
}
m["nai-chu-pro"] = {
 "Proto-Chumash",
 nil,
 "nai-chu",
 "Latnx",
 type = "reconstructed",
}
m["nai-cig"] = {
 "Ciguayo",
 20741700,
 nil,
 "Latn",
}
m["nai-ckn-pro"] = {
 "Proto-Chinookan",
 nil,
 "nai-ckn",
 "Latnx",
 type = "reconstructed",
}
m["nai-dly"] = {
 "Delta Yokuts",
 nil,
 "nai-yok",
 "Latn",
}
m["nai-gsy"] = {
 "Gashowu",
 nil,
 "nai-yok",
 "Latn",
}
m["nai-guz"] = {
 "Guazacapán",
 19572028,
 "nai-xin",
 "Latn",
}
m["nai-hit"] = {
 "Hitchiti",
 1542882,
 "nai-mus",
 "Latn",
}
m["nai-ipa"] = {
 "Ipai",
 3027474,
 "nai-yuc",
 "Latn",
}
m["nai-jtp"] = {
 "Jutiapa",
 nil,
 "nai-xin",
 "Latn",
}
m["nai-jum"] = {
 "Jumaytepeque",
 25339626,
 "nai-xin",
 "Latn",
}
m["nai-kat"] = {
 "Kathlamet",
 6376639,
 "nai-ckn",
 "Latn",
}
m["nai-klp-pro"] = {
 "Proto-Kalapuyan",
 nil,
 "nai-klp",
 type = "reconstructed",
}
m["nai-knm"] = {
 "Konomihu",
 3198734,
 "nai-shs",
 "Latn",
}
m["nai-kry"] = {
 "Kings River Yokuts",
 6413014,
 "nai-yok",
 "Latn",
}
m["nai-kum"] = {
 "Kumeyaay",
 4910139,
 "nai-yuc",
 "Latn",
}
m["nai-mac"] = {
 "Macoris",
 21070851,
 nil,
 "Latn",
}
m["nai-mdu-pro"] = {
 "Proto-Maidun",
 nil,
 "nai-mdu",
 "Latnx",
 type = "reconstructed",
}
m["nai-miz-pro"] = {
 "Proto-Mixe-Zoque",
 nil,
 "nai-miz",
 "Latnx",
 type = "reconstructed",
}
m["nai-mus-pro"] = {
 "Proto-Muskogean",
 nil,
 "nai-mus",
 "Latnx",
 type = "reconstructed",
}
m["nai-nao"] = {
 "Naolan",
 6964594,
 nil,
 "Latn",
}
m["nai-nrs"] = {
 "New River Shasta",
 7011254,
 "nai-shs",
 "Latn",
}
m["nai-nvy"] = {
 "Northern Valley Yokuts",
 nil,
 "nai-yok",
 "Latn",
}
m["nai-okw"] = {
 "Okwanuchu",
 3350126,
 "nai-shs",
 "Latn",
}
m["nai-per"] = {
 "Pericú",
 3375369,
 nil,
 "Latn",
}
m["nai-pic"] = {
 "Picuris",
 7191257,
 "nai-kta",
 "Latn",
}
m["nai-plp-pro"] = {
 "Proto-Plateau Penutian",
 nil,
 "nai-plp",
 "Latnx",
 type = "reconstructed",
}
m["nai-ply"] = {
 "Palewyami",
 2387391,
 "nai-yok",
 "Latn",
}
m["nai-pom-pro"] = {
 "Proto-Pomo",
 nil,
 "nai-pom",
 "Latn",
 type = "reconstructed",
}
m["nai-qng"] = {
 "Quinigua",
 36360,
 nil,
 "Latn",
}
m["nai-sca-pro"] = { -- NB 'sio-pro' "Proto-Siouan" which is Proto-Western Siouan
 "Proto-Siouan-Catawban",
 nil,
 "nai-sca",
 "Latnx",
 type = "reconstructed",
}
m["nai-sin"] = {
 "Sinacantán",
 24190249,
 "nai-xin",
 "Latn",
}
m["nai-sln"] = {
 "Salvadoran Lenca",
 3229434,
 "nai-len",
 "Latn",
}
m["nai-spt"] = {
 "Sahaptin",
 3833015,
 "nai-shp",
 "Latn",
}
m["nai-svy"] = {
 "Southern Valley Yokuts",
 nil,
 "nai-yok",
 "Latn",
}
m["nai-tap"] = {
 "Tapachultec",
 7684401,
 "nai-miz",
 "Latn",
}
m["nai-taw"] = {
 "Tawasa",
 7689233,
 nil,
 "Latn",
}
m["nai-teq"] = {
 "Tequistlatec",
 2964454,
 "nai-tqn",
 "Latn",
}
m["nai-tip"] = {
 "Tipai",
 3027471,
 "nai-yuc",
 "Latn",
}
m["nai-tky"] = {
 "Tule-Kaweah Yokuts",
 7851988,
 "nai-yok",
 "Latn",
}
m["nai-tot-pro"] = {
 "Proto-Totozoquean",
 nil,
 "nai-tot",
 "Latnx",
 type = "reconstructed",
}
m["nai-tsi-pro"] = {
 "Proto-Tsimshianic",
 nil,
 "nai-tsi",
 "Latnx",
 type = "reconstructed",
}
m["nai-utn-pro"] = {
 "Proto-Utian",
 nil,
 "nai-utn",
 "Latnx",
 type = "reconstructed",
}
m["nai-wai"] = {
 "Waikuri",
 3118702,
 nil,
 "Latn",
}
m["nai-yup"] = {
 "Yupiltepeque",
 25339628,
 "nai-xin",
 "Latn",
}
m["nds-de"] = {
 "German Low German",
 25433,
 "gmw",
 "Latn",
 ancestors = "nds",
 wikimedia_codes = "nds",
}
m["nds-nl"] = {
 "Dutch Low Saxon",
 516137,
 "gmw",
 "Latn",
 ancestors = "nds",
}
m["ngf-pro"] = {
 "Proto-Trans-New Guinea",
 nil,
 "ngf",
 "Latn",
 type = "reconstructed",
}
m["nic-bco-pro"] = {
 "Proto-Benue-Congo",
 nil,
 "nic-bco",
 "Latn",
 type = "reconstructed",
}
m["nic-bod-pro"] = {
 "Proto-Bantoid",
 nil,
 "nic-bod",
 "Latn",
 type = "reconstructed",
}
m["nic-eov-pro"] = {
 "Proto-Eastern Oti-Volta",
 nil,
 "nic-eov",
 "Latn",
 type = "reconstructed",
}
m["nic-gns-pro"] = {
 "Proto-Gurunsi",
 nil,
 "nic-gns",
 "Latn",
 type = "reconstructed",
}
m["nic-grf-pro"] = {
 "Proto-Grassfields",
 nil,
 "nic-grf",
 "Latn",
 type = "reconstructed",
}
m["nic-gur-pro"] = {
 "Proto-Gur",
 nil,
 "nic-gur",
 "Latn",
 type = "reconstructed",
}
m["nic-jkn-pro"] = {
 "Proto-Jukunoid",
 nil,
 "nic-jkn",
 "Latn",
 type = "reconstructed",
}
m["nic-lcr-pro"] = {
 "Proto-Lower Cross River",
 nil,
 "nic-lcr",
 "Latn",
 type = "reconstructed",
}
m["nic-ogo-pro"] = {
 "Proto-Ogoni",
 nil,
 "nic-ogo",
 "Latn",
 type = "reconstructed",
}
m["nic-ovo-pro"] = {
 "Proto-Oti-Volta",
 nil,
 "nic-ovo",
 "Latn",
 type = "reconstructed",
}
m["nic-plt-pro"] = {
 "Proto-Plateau",
 nil,
 "nic-plt",
 "Latn",
 type = "reconstructed",
}
m["nic-pro"] = {
 "Proto-Niger-Congo",
 nil,
 "nic",
 "Latn",
 type = "reconstructed",
}
m["nic-ubg-pro"] = {
 "Proto-Ubangian",
 nil,
 "nic-ubg",
 "Latn",
 type = "reconstructed",
}
m["nic-ucr-pro"] = {
 "Proto-Upper Cross River",
 nil,
 "nic-ucr",
 "Latn",
 type = "reconstructed",
}
m["nic-vco-pro"] = {
 "Proto-Volta-Congo",
 nil,
 "nic-vco",
 "Latn",
 type = "reconstructed",
}
m["nub-har"] = {
 "Haraza",
 19572059,
 "nub",
 "Arab, Latn",
}
m["nub-pro"] = {
 "Proto-Nubian",
 nil,
 "nub",
 "Latn",
 type = "reconstructed",
}
m["omq-cha-pro"] = {
 "Proto-Chatino",
 nil,
 "omq-cha",
 "Latn",
 type = "reconstructed",
}
m["omq-maz-pro"] = {
 "Proto-Mazatec",
 nil,
 "omq-maz",
 "Latn",
 type = "reconstructed",
}
m["omq-mix-pro"] = {
 "Proto-Mixtecan",
 nil,
 "omq-mix",
 "Latn",
 type = "reconstructed",
}
m["omq-mxt-pro"] = {
 "Proto-Mixtec",
 nil,
 "omq-mxt",
 "Latn",
 type = "reconstructed",
}
m["omq-otp-pro"] = {
 "Proto-Oto-Pamean",
 nil,
 "omq-otp",
 "Latn",
 type = "reconstructed",
 ancestors = "omq-pro",
}
m["omq-pro"] = {
 "Proto-Oto-Manguean",
 33669,
 "omq",
 "Latn",
 type = "reconstructed",
}
m["omq-tel"] = {
 "Teposcolula Mixtec",
 nil,
 "omq-mxt",
 "Latn",
}
m["omq-teo"] = {
 "Teojomulco Chatino",
 25340451,
 "omq-cha",
 "Latn",
}
m["omq-tri-pro"] = {
 "Proto-Trique",
 nil,
 "omq-tri",
 "Latn",
 type = "reconstructed",
}
m["omq-zap-pro"] = {
 "Proto-Zapotecan",
 nil,
 "omq-zap",
 "Latn",
 type = "reconstructed",
}
m["omq-zpc-pro"] = {
 "Proto-Zapotec",
 nil,
 "omq-zpc",
 "Latn",
 type = "reconstructed",
}
m["omv-aro-pro"] = {
 "Proto-Aroid",
 nil,
 "omv-aro",
 "Latn",
 type = "reconstructed",
}
m["omv-diz-pro"] = {
 "Proto-Dizoid",
 nil,
 "omv-diz",
 "Latn",
 type = "reconstructed",
}
m["omv-pro"] = {
 "Proto-Omotic",
 nil,
 "omv",
 "Latn",
 type = "reconstructed",
}
m["oto-otm-pro"] = {
 "Proto-Otomi",
 nil,
 "oto-otm",
 "Latn",
 type = "reconstructed",
 ancestors = "oto-pro",
}
m["oto-pro"] = {
 "Proto-Otomian",
 nil,
 "oto",
 "Latn",
 type = "reconstructed",
 ancestors = "omq-otp-pro",
}
m["paa-kom"] = {
 "Kómnzo",
 18344310,
 "paa-yam",
 "Latn",
}
m["paa-kwn"] = {
 "Kuwani",
 6449056,
 "paa",
 "Latn",
}
m["paa-nha-pro"] = {
 "Proto-North Halmahera",
 nil,
 "paa-nha",
 "Latn",
 type = "reconstructed"
}
m["paa-nun"] = {
 "Nungon",
 nil,
 "paa",
 "Latn",
}
m["phi-din"] = {
 "Dinapigue Agta",
 16945774,
 "phi",
 "Latn",
}
m["phi-kal-pro"] = {
 "Proto-Kalamian",
 nil,
 "phi-kal",
 "Latn",
 type = "reconstructed",
}
m["phi-nag"] = {
 "Nagtipunan Agta",
 16966111,
 "phi",
 "Latn",
}
m["phi-pro"] = {
 "Proto-Philippine",
 18204898,
 "phi",
 "Latnx",
 type = "reconstructed",
}
m["poz-abi"] = {
 "Abai",
 19570729,
 "poz-san",
 "Latn",
}
m["poz-bal"] = {
 "Baliledo",
 4850912,
 "poz",
 "Latn",
}
m["poz-btk-pro"] = {
 "Proto-Bungku-Tolaki",
 nil,
 "poz-btk",
 "Latnx",
 type = "reconstructed",
}
m["poz-cet-pro"] = {
 "Proto-Central-Eastern Malayo-Polynesian",
 2269883,
 "poz-cet",
 "Latnx",
 type = "reconstructed",
}
m["poz-hce-pro"] = {
 "Proto-Halmahera-Cenderawasih",
 nil,
 "poz-hce",
 "Latnx",
 type = "reconstructed",
}
m["poz-lgx-pro"] = {
 "Proto-Lampungic",
 nil,
 "poz-lgx",
 "Latnx",
 type = "reconstructed",
}
m["poz-mcm-pro"] = {
 "Proto-Malayo-Chamic",
 nil,
 "poz-mcm",
 "Latnx",
 type = "reconstructed",
}
m["poz-mly-pro"] = {
 "Proto-Malayic",
 nil,
 "poz-mly",
 "Latnx",
 type = "reconstructed",
}
m["poz-msa-pro"] = {
 "Proto-Malayo-Sumbawan",
 nil,
 "poz-msa",
 "Latnx",
 type = "reconstructed",
}
m["poz-oce-pro"] = {
 "Proto-Oceanic",
 141741,
 "poz-oce",
 "Latnx",
 type = "reconstructed",
}
m["poz-pep-pro"] = {
 "Proto-Eastern Polynesian",
 nil,
 "poz-pep",
 "Latnx",
 type = "reconstructed",
}
m["poz-pnp-pro"] = {
 "Proto-Nuclear Polynesian",
 nil,
 "poz-pnp",
 "Latnx",
 type = "reconstructed",
}
m["poz-pol-pro"] = {
 "Proto-Polynesian",
 1658709,
 "poz-pol",
 "Latnx",
 type = "reconstructed",
}
m["poz-pro"] = {
 "Proto-Malayo-Polynesian",
 3832960,
 "poz",
 "Latnx",
 type = "reconstructed",
}
m["poz-sml"] = {
 "Sarawak Malay",
 4251702,
 "poz-mly",
 "Latn, ms-Arab",
}
m["poz-ssw-pro"] = {
 "Proto-South Sulawesi",
 nil,
 "poz-ssw",
 "Latnx",
 type = "reconstructed",
}
m["poz-sus-pro"] = {
 "Proto-Sunda-Sulawesi",
 nil,
 "poz-sus",
 "Latnx",
 type = "reconstructed",
}
m["poz-swa-pro"] = {
 "Proto-North Sarawak",
 nil,
 "poz-swa",
 "Latnx",
 type = "reconstructed",
}
m["poz-ter"] = {
 "Terengganu Malay",
 4207412,
 "poz-mly",
 "Latn, ms-Arab",
}
m["pqe-pro"] = {
 "Proto-Eastern Malayo-Polynesian",
 2269883,
 "pqe",
 "Latnx",
 type = "reconstructed",
}
m["pra-niy"] = {
 "Niya Prakrit",
 nil,
 "inc-mid",
 "Khar",
 ancestors = "inc-ash",
 translit = "Khar-translit",
}
m["qfa-adm-pro"] = {
 "Proto-Great Andamanese",
 nil,
 "qfa-adm",
 "Latnx",
 type = "reconstructed",
}
m["qfa-bet-pro"] = {
 "Proto-Be-Tai",
 nil,
 "qfa-bet",
 "Latnx",
 type = "reconstructed",
}
m["qfa-cka-pro"] = {
 "Proto-Chukotko-Kamchatkan",
 7251837,
 "qfa-cka",
 "Latnx",
 type = "reconstructed",
}
m["qfa-hur-pro"] = {
 "Proto-Hurro-Urartian",
 nil,
 "qfa-hur",
 "Latnx",
 type = "reconstructed",
}
m["qfa-kad-pro"] = {
 "Proto-Kadu",
 nil,
 "qfa-kad",
 "Latn",
 type = "reconstructed",
}
m["qfa-kms-pro"] = {
 "Proto-Kam-Sui",
 nil,
 "qfa-kms",
 "Latn",
 type = "reconstructed",
}
m["qfa-kor-pro"] = {
 "Proto-Koreanic",
 467883,
 "qfa-kor",
 "Latnx",
 type = "reconstructed",
}
m["qfa-kra-pro"] = {
 "Proto-Kra",
 7251854,
 "qfa-kra",
 "Latnx",
 type = "reconstructed",
}
m["qfa-lic-pro"] = {
 "Proto-Hlai",
 7251845,
 "qfa-lic",
 "Latnx",
 type = "reconstructed",
}
m["qfa-onb-pro"] = {
 "Proto-Be",
 nil,
 "qfa-onb",
 "Latnx",
 type = "reconstructed",
}
m["qfa-ong-pro"] = {
 "Proto-Ongan",
 nil,
 "qfa-ong",
 "Latnx",
 type = "reconstructed",
}
m["qfa-tak-pro"] = {
 "Proto-Kra-Dai",
 nil,
 "qfa-tak",
 "Latn",
 type = "reconstructed",
}
m["qfa-xgx-tuh"] = {
 "Tuyuhun",
 48816625,
 "qfa-xgx",
 "Hani, Latnx",
 sort_key = {Hani = "Hani-sortkey"},
}
m["qfa-xgx-tuo"] = {
 "Tuoba",
 48816629,
 "qfa-xgx",
 "Hani, Latnx",
 sort_key = {Hani = "Hani-sortkey"},
}
m["qfa-xgx-wuh"] = {
 "Wuhuan",
 118976867,
 "qfa-xgx",
 "Hani, Latnx",
 sort_key = {Hani = "Hani-sortkey"},
}
m["qfa-xgx-xbi"] = {
 "Xianbei",
 4448647,
 "qfa-xgx",
 "Hani, Latnx",
 sort_key = {Hani = "Hani-sortkey"},
}
m["qfa-yen-pro"] = {
 "Proto-Yeniseian",
 27639,
 "qfa-yen",
 "Latnx",
 type = "reconstructed",
}
m["qfa-yuk-pro"] = {
 "Proto-Yukaghir",
 nil,
 "qfa-yuk",
 "Latnx",
 type = "reconstructed",
}
m["qwe-kch"] = {
 "Kichwa",
 1740805,
 "qwe",
 "Latn",
 ancestors = "qu",
}
m["qwe-pro"] = {
 "Proto-Quechuan",
 5575757,
 "qwe",
 "Latnx",
 type = "reconstructed",
}
m["roa-ang"] = {
 "Angevin",
 56782,
 "roa-oil",
 "Latn",
 sort_key = s["roa-oil-sortkey"],
}
m["roa-bbn"] = {
 "Bourbonnais-Berrichon",
 nil,
 "roa-oil",
 "Latn",
 sort_key = s["roa-oil-sortkey"],
}
m["roa-brg"] = {
 "Bourguignon",
 508332,
 "roa-oil",
 "Latn",
 sort_key = s["roa-oil-sortkey"],
}
m["roa-cha"] = {
 "Champenois",
 430018,
 "roa-oil",
 "Latn",
 sort_key = s["roa-oil-sortkey"],
}
m["roa-fcm"] = {
 "Franc-Comtois",
 510561,
 "roa-oil",
 "Latn",
 sort_key = s["roa-oil-sortkey"],
}
m["roa-gal"] = {
 "Gallo",
 37300,
 "roa-oil",
 "Latn",
 sort_key = s["roa-oil-sortkey"],
}
m["roa-gib"] = {
 "Gallo-Italic of Basilicata",
 3094838,
 "roa-git",
 "Latn",
}
m["roa-gis"] = {
 "Gallo-Italic of Sicily",
 2629019,
 "roa-git",
 "Latn",
}
m["roa-leo"] = {
 "Leonese",
 34108,
 "roa-ibe",
 "Latn",
 ancestors = "roa-ole",
}
m["roa-lor"] = {
 "Lorrain",
 671198,
 "roa-oil",
 "Latn",
 sort_key = s["roa-oil-sortkey"],
}
m["roa-oan"] = {
 "Navarro-Aragonese",
 2736184,
 "roa-ibe",
 "Latn",
}
m["roa-oca"] = {
 "Old Catalan",
 15478520,
 "roa-ocr",
 "Latn",
 sort_key = {
  from = {"à", "[èé]", "[íï]", "[òó]", "[úü]", "ç", "·"},
  to = {"a", "e", "i", "o", "u", "c"}
 },
}
m["roa-ole"] = {
 "Old Leonese",
 nil,
 "roa-ibe",
 "Latn",
}
m["roa-opt"] = {
 "Old Galician-Portuguese",
 1072111,
 "roa-ibe",
 "Latn",
}
m["roa-orl"] = {
 "Orléanais",
 nil,
 "roa-oil",
 "Latn",
 sort_key = s["roa-oil-sortkey"],
}
m["roa-poi"] = {
 "Poitevin-Saintongeais",
 514123,
 "roa-oil",
 "Latn",
 sort_key = s["roa-oil-sortkey"],
}
m["roa-tar"] = {
 "Tarantino",
 695526,
 "roa-itd",
 "Latn",
 ancestors = "nap",
 wikimedia_codes = "roa-tara",
}
m["sai-ajg"] = {
 "Ajagua",
 nil,
 nil,
 "Latn",
}
m["sai-all"] = {
 "Allentiac",
 19570789,
 "sai-hrp",
 "Latn",
}
m["sai-and"] = { -- not to be confused with 'cbc' or 'ano'
 "Andoquero",
 16828359,
 "sai-wit",
 "Latn",
}
m["sai-ayo"] = {
 "Ayomán",
 16937754,
 "sai-jir",
 "Latn",
}
m["sai-bae"] = {
 "Baenan",
 3401998,
 nil,
 "Latn",
}
m["sai-bag"] = {
 "Bagua",
 5390321,
 nil,
 "Latn",
}
m["sai-bet"] = {
 "Betoi",
 926551,
 "qfa-iso",
 "Latn",
}
m["sai-bor-pro"] = {
 "Proto-Boran",
 nil,
 "sai-bor",
 "Latn",
}
m["sai-cac"] = {
 "Cacán",
 945482,
 nil,
 "Latn",
}
m["sai-caq"] = {
 "Caranqui",
 2937753,
 "sai-bar",
 "Latn",
}
m["sai-car-pro"] = {
 "Proto-Cariban",
 nil,
 "sai-car",
 "Latnx",
 type = "reconstructed",
}
m["sai-cat"] = {
 "Catacao",
 5051136,
 "sai-ctc",
 "Latnx",
}
m["sai-cer-pro"] = {
 "Proto-Cerrado",
 nil,
 "sai-cer",
 "Latn",
 type = "reconstructed",
}
m["sai-chi"] = {
 "Chirino",
 5390321,
 nil,
 "Latn",
}
m["sai-chn"] = {
 "Chaná",
 5072718,
 "sai-crn",
 "Latn",
}
m["sai-chp"] = {
 "Chapacura",
 5072884,
 "sai-cpc",
 "Latn",
}
m["sai-chr"] = {
 "Charrua",
 5086680,
 "sai-crn",
 "Latn",
}
m["sai-chu"] = {
 "Churuya",
 5118339,
 "sai-guh",
 "Latn",
}
m["sai-cje-pro"] = {
 "Proto-Central Jê",
 nil,
 "sai-cje",
 "Latn",
 type = "reconstructed",
}
m["sai-cmg"] = {
 "Comechingon",
 6644203,
 nil,
 "Latn",
}
m["sai-cno"] = {
 "Chono",
 5104704,
 nil,
 "Latn",
}
m["sai-cnr"] = {
 "Cañari",
 5055572,
 nil,
 "Latn",
}
m["sai-coe"] = {
 "Coeruna",
 6425639,
 "sai-wit",
 "Latn",
}
m["sai-col"] = {
 "Colán",
 5141893,
 "sai-ctc",
 "Latnx",
}
m["sai-cop"] = {
 "Copallén",
 5390321,
 nil,
 "Latn",
}
m["sai-crd"] = {
 "Coroado Puri",
 24191321,
 "sai-mje",
 "Latn",
}
m["sai-ctq"] = {
 "Catuquinaru",
 16858455,
 nil,
 "Latn",
}
m["sai-cul"] = {
 "Culli",
 2879660,
 nil,
 "Latn",
}
m["sai-cva"] = {
 "Cueva",
 nil,
 nil,
 "Latn",
}
m["sai-esm"] = {
 "Esmeralda",
 3058083,
 nil,
 "Latn",
}
m["sai-ewa"] = {
 "Ewarhuyana",
 16898104,
 nil,
 "Latn",
}
m["sai-gam"] = {
 "Gamela",
 5403661,
 nil,
 "Latn",
}
m["sai-gay"] = {
 "Gayón",
 5528902,
 "sai-jir",
 "Latn",
}
m["sai-gmo"] = {
 "Guamo",
 5613495,
 nil,
 "Latn",
}
m["sai-gue"] = {
 "Güenoa",
 5626799,
 "sai-crn",
 "Latn",
}
m["sai-hau"] = {
 "Haush",
 3128376,
 "sai-cho",
 "Latn",
}
m["sai-jee-pro"] = {
 "Proto-Jê",
 nil,
 "sai-jee",
 "Latn",
 type = "reconstructed",
}
m["sai-jko"] = {
 "Jeikó",
 6176527,
 "sai-mje",
 "Latn",
}
m["sai-jrj"] = {
 "Jirajara",
 6202966,
 "sai-jir",
 "Latn",
}
m["sai-kat"] = { -- contrast xoo, kzw, sai-xoc
 "Katembri",
 6375925,
 nil,
 "Latn",
}
m["sai-mal"] = {
 "Malalí",
 6741212,
 nil,
 "Latn",
}
m["sai-mar"] = {
 "Maratino",
 6755055,
 nil,
 "Latn",
}
m["sai-mat"] = {
 "Matanawi",
 6786047,
 nil,
 "Latn",
}
m["sai-mcn"] = {
 "Mocana",
 3402048,
 nil,
 "Latn",
}
m["sai-men"] = {
 "Menien",
 16890110,
 "sai-mje",
 "Latn",
}
m["sai-mil"] = {
 "Millcayac",
 19573012,
 "sai-hrp",
 "Latn",
}
m["sai-mlb"] = {
 "Malibu",
 3402048,
 nil,
 "Latn",
}
m["sai-msk"] = {
 "Masakará",
 6782426,
 "sai-mje",
 "Latn",
}
m["sai-muc"] = {
 "Mucuchí",
 nil,
 nil,
 "Latn",
}
m["sai-mue"] = {
 "Muellama",
 16886936,
 "sai-bar",
 "Latn",
}
m["sai-muz"] = {
 "Muzo",
 6644203,
 nil,
 "Latn",
}
m["sai-mys"] = {
 "Maynas",
 16919393,
 nil,
 "Latn",
}
m["sai-nat"] = {
 "Natú",
 9006749,
 nil,
 "Latn",
}
m["sai-nje-pro"] = {
 "Proto-Northern Jê",
 nil,
 "sai-nje",
 "Latn",
 type = "reconstructed",
}
m["sai-opo"] = {
 "Opón",
 7099152,
 "sai-car",
 "Latn",
}
m["sai-oto"] = {
 "Otomaco",
 16879234,
 "sai-otm",
 "Latn",
}
m["sai-pal"] = {
 "Palta",
 3042978,
 nil,
 "Latn",
}
m["sai-pam"] = {
 "Pamigua",
 5908689,
 "sai-otm",
 "Latn",
}
m["sai-par"] = {
 "Paratió",
 16890038,
 nil,
 "Latn",
}
m["sai-pnz"] = {
 "Panzaleo",
 3123275,
 nil,
 "Latn",
}
m["sai-prh"] = {
 "Puruhá",
 3410994,
 nil,
 "Latn",
}
m["sai-ptg"] = {
 "Patagón",
 nil,
 nil,
 "Latn",
}
m["sai-pur"] = {
 "Purukotó",
 7261622,
 "sai-pem",
 "Latn",
}
m["sai-pyg"] = {
 "Payaguá",
 7156643,
 "sai-guc",
 "Latn",
}
m["sai-pyk"] = {
 "Pykobjê",
 98113977,
 "sai-nje",
 "Latn",
}
m["sai-qmb"] = {
 "Quimbaya",
 7272043,
 nil,
 "Latn",
}
m["sai-qtm"] = {
 "Quitemo",
 7272651,
 "sai-cpc",
 "Latn",
}
m["sai-rab"] = {
 "Rabona",
 6644203,
 nil,
 "Latn",
}
m["sai-ram"] = {
 "Ramanos",
 16902824,
 nil,
 "Latn",
}
m["sai-sac"] = {
 "Sácata",
 5390321,
 nil,
 "Latn",
}
m["sai-san"] = {
 "Sanaviron",
 16895999,
 nil,
 "Latn",
}
m["sai-sap"] = {
 "Sapará",
 7420922,
 "sai-car",
 "Latn",
}
m["sai-sec"] = {
 "Sechura",
 7442912,
 nil,
 "Latn",
}
m["sai-sin"] = {
 "Sinúfana",
 7525275,
 nil,
 "Latn",
}
m["sai-sje-pro"] = {
 "Proto-Southern Jê",
 nil,
 "sai-sje",
 "Latn",
 type = "reconstructed",
}
m["sai-tab"] = {
 "Tabancale",
 5390321,
 nil,
 "Latn",
}
m["sai-tal"] = {
 "Tallán",
 16910468,
 nil,
 "Latn",
}
m["sai-tap"] = {
 "Tapayuna",
 nil,
 "sai-nje",
 "Latn",
}
m["sai-tar-pro"] = {
 "Proto-Taranoan",
 nil,
 "sai-tar",
 "Latnx",
 type = "reconstructed",
}
m["sai-teu"] = {
 "Teushen",
 3519243,
 nil,
 "Latn",
}
m["sai-tim"] = {
 "Timote",
 nil,
 nil,
 "Latn",
}
m["sai-tpr"] = {
 "Taparita",
 7684460,
 "sai-otm",
 "Latn",
}
m["sai-trr"] = {
 "Tarairiú",
 7685313,
 nil,
 "Latn",
}
m["sai-wai"] = {
 "Waitaká",
 16918610,
 nil,
 "Latn",
}
m["sai-way"] = {
 "Wayumará",
 nil,
 "sai-car",
 "Latn",
}
m["sai-wit-pro"] = {
 "Proto-Witotoan",
 nil,
 "sai-wit",
 "Latn",
 type = "reconstructed",
}
m["sai-wnm"] = {
 "Wanham",
 16879440,
 "sai-cpc",
 "Latn",
}
m["sai-xoc"] = { -- contrast xoo, kzw, sai-kat
 "Xocó",
 12953620,
 nil,
 "Latn",
}
m["sai-yao"] = {
 "Yao (South America)",
 nil,
 "sai-ven",
 "Latn",
}
m["sai-yar"] = { -- not the same family as 'suy'
 "Yarumá",
 3505859,
 "sai-pek",
 "Latn",
}
m["sai-yri"] = {
 "Yuri",
 nil,
 "sai-tyu",
 "Latn",
}
m["sai-yup"] = {
 "Yupua",
 8061430,
 "sai-tuc",
 "Latn",
}
m["sai-yur"] = {
 "Yurumanguí",
 1281291,
 nil,
 "Latn",
}
m["sal-pro"] = {
 "Proto-Salish",
 nil,
 "sal",
 "Latn",
 type = "reconstructed",
}
m["sdv-daj-pro"] = {
 "Proto-Daju",
 nil,
 "sdv-daj",
 "Latn",
 type = "reconstructed",
}
m["sdv-eje-pro"] = {
 "Proto-Eastern Jebel",
 nil,
 "sdv-eje",
 "Latn",
 type = "reconstructed",
}
m["sdv-nil-pro"] = {
 "Proto-Nilotic",
 nil,
 "sdv-nil",
 "Latn",
 type = "reconstructed",
}
m["sdv-nyi-pro"] = {
 "Proto-Nyima",
 nil,
 "sdv-nyi",
 "Latn",
 type = "reconstructed",
}
m["sdv-tmn-pro"] = {
 "Proto-Taman",
 nil,
 "sdv-tmn",
 "Latn",
 type = "reconstructed",
}
m["sel-nor"] = {
 "Northern Selkup",
 30304565,
 "sel",
 "Cyrl",
}
m["sel-pro"] = {
 "Proto-Selkup",
 nil,
 "sel",
 "Latn",
 type = "reconstructed",
}
m["sel-sou"] = {
 "Southern Selkup",
 30304639,
 "sel",
 "Cyrl",
}
m["sem-amm"] = {
 "Ammonite",
 279181,
 "sem-can",
 "Phnx",
 translit = "Phnx-translit",
}
m["sem-amo"] = {
 "Amorite",
 35941,
 "sem-nwe",
 "Xsux, Latn",
}
m["sem-cha"] = {
 "Chaha",
 nil,
 "sem-eth",
 "Ethi",
 translit = "Ethi-translit",
 ancestors = "sem-pro",
}
m["sem-dad"] = {
 "Dadanitic",
 21838040,
 "sem-cen",
 "Narb",
 translit = "Narb-translit",
}
m["sem-dum"] = {
 "Dumaitic",
 nil,
 "sem-cen",
 "Narb",
 translit = "Narb-translit",
}
m["sem-has"] = {
 "Hasaitic",
 3541433,
 "sem-cen",
 "Narb",
 translit = "Narb-translit",
}
m["sem-him"] = {
 "Himyaritic",
 35604,
 "sem",
 "Arab, Sarb",
}
m["sem-his"] = {
 "Hismaic",
 22948260,
 "sem-cen",
 "Narb",
 translit = "Narb-translit",
}
m["sem-mhr"] = {
 "Muher",
 33743,
 "sem-eth",
 "Latn",
}
m["sem-pro"] = {
 "Proto-Semitic",
 1658554,
 "sem",
 "Latnx",
 type = "reconstructed",
}
m["sem-saf"] = {
 "Safaitic",
 472586,
 "sem-cen",
 "Narb",
 translit = "Narb-translit",
}
m["sem-srb"] = {
 "Old South Arabian",
 35025,
 "sem-osa",
 "Sarb",
 translit = "Sarb-translit",
}
m["sem-tay"] = {
 "Taymanitic",
 24912301,
 "sem-cen",
 "Narb",
 translit = "Narb-translit",
}
m["sem-tha"] = {
 "Thamudic",
 843030,
 "sem-cen",
 "Narb",
 translit = "Narb-translit",
}
m["sem-wes-pro"] = {
 "Proto-West Semitic",
 98021726,
 "sem-wes",
 "Latnx",
 type = "reconstructed",
}
m["sio-pro"] = { -- NB this is not Proto-Siouan-Catawban 'nai-sca-pro'
 "Proto-Siouan",
 34181,
 "sio",
 "Latnx",
 type = "reconstructed",
}
m["sit-bok"] = {
 "Bokar",
 4938727,
 "sit-tan",
 "Latn, Tibt",
 translit = {Tibt = "Tibt-translit"},
 override_translit = true,
 display_text = {Tibt = s["Tibt-displaytext"]},
 entry_name = {Tibt = s["Tibt-entryname"]},
 sort_key = {Tibt = "Tibt-sortkey"},
}
m["sit-cha"] = {
 "Chairel",
 5068066,
 "sit-luu",
 "Latn",
}
m["sit-gkh"] = {
 "Gokhy",
 5578069,
 "tbq-lol",
 "Latn",
}
m["sit-hrs-pro"] = {
 "Proto-Hrusish",
 nil,
 "sit-hrs",
 type = "reconstructed",
}
m["sit-jap"] = {
 "Japhug",
 3162245,
 "sit-rgy",
 "Latn",
}
m["sit-kha-pro"] = {
 "Proto-Kham",
 nil,
 "sit-kha",
 type = "reconstructed",
}
m["sit-liz"] = {
 "Lizu",
 6660653,
 "sit-qia",
 "Latn", -- and Ersu Shaba
}
m["sit-luu-pro"] = {
 "Proto-Luish",
 nil,
 "sit-luu",
 type = "reconstructed",
}
m["sit-mor"] = {
 "Moran",
 6909216,
 "tbq-bdg",
 "Latn",
}
m["sit-prn"] = {
 "Puiron",
 7259048,
 "sit-zem",
}
m["sit-pro"] = {
 "Proto-Sino-Tibetan",
 45961,
 "sit",
 "Latn",
 type = "reconstructed",
}
m["sit-sit"] = {
 "Situ",
 19840830,
 "sit-rgy",
 "Latn",
}
m["sit-tan-pro"] = {
 "Proto-Tani",
 nil,
 "sit-tan",
 "Latn", -- needs verification
 type = "reconstructed",
}
m["sit-tgm"] = {
 "Tangam",
 17041370,
 "sit-tan",
 "Latn",
}
m["sit-tos"] = {
 "Tosu",
 7827899,
 "sit-qia",
 "Latn", -- also Ersu Shaba
}
m["sit-tsh"] = {
 "Tshobdun",
 19840950,
 "sit-rgy",
 "Latn",
}
m["sit-zbu"] = {
 "Zbu",
 19841106,
 "sit-rgy",
 "Latn",
}
m["sla-pro"] = {
 "Proto-Slavic",
 747537,
 "sla",
 "Latnx",
 type = "reconstructed",
 entry_name = {
  remove_diacritics = c.grave .. c.acute .. c.tilde .. c.macron .. c.dgrave .. c.invbreve,
  remove_exceptions = {'ś'},
 },
 sort_key = {
  from = {"č", "ď", "ě", "ę", "ь", "ľ", "ň", "ǫ", "ř", "š", "ś", "ť", "ъ", "ž"},
  to = {"c²", "d²", "e²", "e³", "i²", "l²", "nj", "o²", "r²", "s²", "s³", "t²", "u²", "z²"},
 }
}
m["smi-pro"] = {
 "Proto-Samic",
 7251862,
 "smi",
 "Latn",
 type = "reconstructed",
 sort_key = {
  from = {"ā", "č", "δ", "[ëē]", "ŋ", "ń", "ō", "š", "θ", "%([^()]+%)"},
  to = {"a", "c²", "d", "e", "n²", "n³", "o", "s²", "t²"}
 },
}
m["son-pro"] = {
 "Proto-Songhay",
 nil,
 "son",
 "Latnx",
 type = "reconstructed",
}
m["sqj-pro"] = {
 "Proto-Albanian",
 18210846,
 "sqj",
 "Latnx",
 type = "reconstructed",
}
m["ssa-klk-pro"] = {
 "Proto-Kuliak",
 nil,
 "ssa-klk",
 "Latnx",
 type = "reconstructed",
}
m["ssa-kom-pro"] = {
 "Proto-Koman",
 nil,
 "ssa-kom",
 "Latnx",
 type = "reconstructed",
}
m["ssa-pro"] = {
 "Proto-Nilo-Saharan",
 nil,
 "ssa",
 "Latnx",
 type = "reconstructed",
}
m["syd-fne"] = {
 "Forest Nenets",
 1295107,
 "syd",
 "Cyrl",
 translit = "syd-fne-translit",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.macron .. c.breve .. c.dotabove},
}
m["syd-pro"] = {
 "Proto-Samoyedic",
 7251863,
 "syd",
 "Latn",
 type = "reconstructed",
}
m["tai-pro"] = {
 "Proto-Tai",
 6583709,
 "tai",
 "Latnx",
 type = "reconstructed",
}
m["tai-swe-pro"] = {
 "Proto-Southwestern Tai",
 nil,
 "tai-swe",
 "Latnx",
 type = "reconstructed",
}
m["tbq-bdg-pro"] = {
 "Proto-Bodo-Garo",
 nil,
 "tbq-bdg",
 "Latnx",
 type = "reconstructed",
}
m["tbq-kuk-pro"] = {
 "Proto-Kuki-Chin",
 nil,
 "tbq-kuk",
 "Latnx",
 type = "reconstructed",
}
m["tbq-lal-pro"] = {
 "Proto-Lalo",
 nil,
 "tbq-lol",
 "Latnx",
 type = "reconstructed",
}
m["tbq-laz"] = {
 "Laze",
 17007626,
 "sit-nax",
}
m["tbq-lob-pro"] = {
 "Proto-Lolo-Burmese",
 nil,
 "tbq-lob",
 "Latnx",
 type = "reconstructed",
}
m["tbq-lol-pro"] = {
 "Proto-Loloish",
 7251855,
 "tbq-lol",
 "Latnx",
 type = "reconstructed",
}
m["tbq-ngo"] = {
 "Ngochang",
 nil,
 "tbq-brm",
 "Latn",
}
m["tbq-plg"] = {
 "Pai-lang",
 2879843,
 "tbq-lob",
 "Hani, Latnx",
 sort_key = {Hani = "Hani-sortkey"},
}
-- tbq-pro is now etymology-only
m["trk-dkh"] = {
 "Dukhan",
 nil,
 "trk-sib",
 "Latn, Cyrl, Mong",
 translit = {Mong = "Mong-translit"},
 display_text = {Mong = s["Mong-displaytext"]},
 entry_name = {Mong = s["Mong-entryname"]},
}
m["trk-oat"] = {
 "Old Anatolian Turkish",
 7083390,
 "trk-ogz",
 "ota-Arab",
 ancestors = "trk-ogz-pro",
 entry_name = {["ota-Arab"] = "ar-entryname"},
}
m["trk-pro"] = {
 "Proto-Turkic",
 3657773,
 "trk",
 "Latnx",
 type = "reconstructed",
}
m["tup-gua-pro"] = {
 "Proto-Tupi-Guarani",
 nil,
 "tup-gua",
 "Latnx",
 type = "reconstructed",
}
m["tup-kab"] = {
 "Kabishiana",
 15302988,
 "tup",
 "Latn",
}
m["tup-pro"] = {
 "Proto-Tupian",
 10354700,
 "tup",
 "Latnx",
 type = "reconstructed",
}
m["tuw-pro"] = {
 "Proto-Tungusic",
 nil,
 "tuw",
 "Latnx",
 type = "reconstructed",
}
m["tuw-kkl"] = {
 "Kyakala",
 nil,
 "tuw",
 "Latn, Hani",
 sort_key = {Hani = "Hani-sortkey"},
}
m["tuw-sol"] = {
 "Solon",
 30004,
 "tuw",
}
m["und-isa"] = {
 "Isaurian",
 16956868,
 nil,
-- "Xsux, Hluw, Latn",
}
m["und-kas"] = {
 "Kassite",
 35612,
 nil,
 "Xsux",
}
m["und-mil"] = {
 "Milang",
 6850761,
 nil,
 "Deva, Latn",
}
m["und-mmd"] = {
 "Mimi of Decorse",
 6862206,
 nil,
 "Latn",
}
m["und-mmn"] = {
 "Mimi of Nachtigal",
 6862207,
 nil,
 "Latn",
}
m["und-phi"] = {
 "Philistine",
 2230924,
 nil,
 "Phnx",
}
m["und-wji"] = {
 "Western Jicaque",
 3178610,
 "hok",
 "Latn",
}
m["urj-fin-pro"] = {
 "Proto-Finnic",
 11883720,
 "urj-fin",
 "Latn",
 type = "reconstructed",
}
m["urj-koo"] = {
 "Old Komi",
 nil,
 "urj-prm",
 "Perm, Cyrs",
 translit = "urj-koo-translit",
 sort_key = {Cyrs = s["Cyrs-sortkey"]},
}
m["urj-kuk"] = {
 "Kukkuzi",
 107410460,
 "urj-fin",
 "Latn",
 ancestors = "vot",
}
m["urj-kya"] = {
 "Komi-Yazva",
 2365210,
 "urj-prm",
 "Cyrl",
 translit = "kv-translit",
 override_translit = true,
 entry_name = {remove_diacritics = c.acute},
}
m["urj-mdv-pro"] = {
 "Proto-Mordvinic",
 nil,
 "urj-mdv",
 "Latn",
 type = "reconstructed",
}
m["urj-prm-pro"] = {
 "Proto-Permic",
 nil,
 "urj-prm",
 "Latn",
 type = "reconstructed",
}
m["urj-pro"] = {
 "Proto-Uralic",
 288765,
 "urj",
 "Latnx",
 type = "reconstructed",
}
m["urj-ugr-pro"] = {
 "Proto-Ugric",
 156631,
 "urj-ugr",
 "Latnx",
 type = "reconstructed",
}
m["xnd-pro"] = {
 "Proto-Na-Dene",
 nil,
 "xnd",
 "Latnx",
 type = "reconstructed",
}
m["xgn-mgr"] = {
 "Mangghuer",
 34214,
 "mjg",
 "Latn", -- also Mong, Cyrl ?
}
m["xgn-mgl"] = {
 "Mongghul",
 34214,
 "mjg",
 "Latn", -- also Mong, Cyrl ?
}
m["xgn-pro"] = {
 "Proto-Mongolic",
 2493677,
 "xgn",
 "Latnx",
 type = "reconstructed",
}
m["xgn-rou"] = {
 "Rouran",
 48816637,
 "xgn",
 "Hani, Latnx",
 sort_key = {Hani = "Hani-sortkey"},
}
m["ypk-pro"] = {
 "Proto-Yupik",
 nil,
 "ypk",
 "Latnx",
 type = "reconstructed",
}
m["zhx-min-pro"] = {
 "Proto-Min",
 19646347,
 "zhx-min",
 "Latnx",
 type = "reconstructed",
}
m["zhx-sht"] = {
 "Shaozhou Tuhua",
 1920769,
 "zhx",
 "Nshu, Hani, Hant, Hans",
 generate_forms = "zh-generateforms",
 sort_key = {Hani = "Hani-sortkey"},
}
m["zhx-tai"] = {
 "Taishanese",
 2208940,
 "zhx",
 "Hani, Hant, Hans",
 ancestors = "yue",
 generate_forms = "zh-generateforms",
 translit = "zh-translit",
 sort_key = "Hani-sortkey",
}
m["zhx-teo"] = {
 "Teochew",
 36759,
 "zhx-min-hai",
 "Hani, Hant, Hans",
 ancestors = "nan",
 generate_forms = "zh-generateforms",
 sort_key = "Hani-sortkey",
}
m["zle-ono"] = {
 "Old Novgorodian",
 162013,
 "zle",
 "Cyrs, Glag",
 translit = {Cyrs = "Cyrs-translit", Glag = "Glag-translit"},
 entry_name = {Cyrs = s["Cyrs-entryname"]},
 sort_key = {Cyrs = s["Cyrs-sortkey"]},
}
m["zle-ort"] = {
 "Old Ruthenian",
 13211,
 "zle",
 "Cyrs",
 ancestors = "orv",
 translit = "zle-ort-translit",
 entry_name = {
  remove_diacritics = s["Cyrs-entryname"].remove_diacritics,
  remove_exceptions = {"Ї", "ї"}
 },
 sort_key = s["Cyrs-sortkey"],
}
m["zlw-ocs"] = {
 "Old Czech",
 593096,
 "zlw",
 "Latn",
}
m["zlw-opl"] = {
 "Old Polish",
 149838,
 "zlw-lch",
 "Latn",
 entry_name = {remove_diacritics = c.ringabove},
}
m["zlw-pom-pro"] = {
 "Proto-Pomeranian",
 149588,
 "zlw-pom",
 "Latn",
 type = "reconstructed",
}
m["zlw-osk"] = {
 "Old Slovak",
 nil,
 "zlw",
 "Latn",
}
m["zlw-slv"] = {
 "Slovincian",
 36822,
 "zlw-pom",
 "Latn",
 ancestors = "zlw-pom-pro",
 entry_name = "zlw-slv-entryname"
}
m["aaa"] = {
 "Ghotuo",
 35463,
 "alv-yek",
 "Latn",
}
m["aab"] = {
 "Alumu-Tesu",
 35034,
 "nic-alu",
 "Latn",
}
m["aac"] = {
 "Ari",
 1811224,
 "paa-pag",
 "Latn",
}
m["aad"] = {
 "Amal",
 56708,
 "paa-iwm",
 "Latn",
}
-- "aae" IS TREATED AS "sq", SEE WT:LT
m["aaf"] = {
 "Aranadan",
 3507928,
 "dra",
 "Mlym",
}
m["aag"] = {
 "Ambrak",
 4741706,
 "qfa-tor",
 "Latn",
}
m["aah"] = {
 "Abu' Arapesh",
 4670715,
 "qfa-tor",
 "Latn",
}
m["aai"] = {
 "Arifama-Miniafia",
 4790560,
 "poz-ocw",
 "Latn",
}
m["aak"] = {
 "Ankave",
 3446690,
 "ngf",
 "Latn",
}
m["aal"] = {
 "Afade",
 56434,
 "cdc-cbm",
 "Latn",
}
m["aan"] = {
 "Anambé",
 3507873,
 "tup-gua",
 "Latn",
}
m["aap"] = {
 "Pará Arára",
 56807,
 "sai-pek",
 "Latn",
}
m["aaq"] = {
 "Penobscot",
 3515185,
 "alg-abp",
 "Latn",
}
m["aas"] = {
 "Aasax",
 56620,
 "cus-sou",
 "Latn",
}
-- "aat" IS TREATED AS "sq", SEE WT:LT
m["aau"] = {
 "Abau",
 3073568,
 "paa-spk",
 "Latn",
}
m["aaw"] = {
 "Solong",
 7558834,
 "poz-ocw",
 "Latn",
}
m["aax"] = {
 "Mandobo Atas",
 12636156,
 "ngf",
 "Latn",
}
m["aaz"] = {
 "Amarasi",
 4740192,
 "poz-tim",
 "Latn",
}
m["aba"] = {
 "Abé",
 34833,
 "alv-lag",
 "Latn",
}
m["abb"] = {
 "Bankon",
 34860,
 "bnt-bsa",
 "Latn",
}
m["abc"] = {
 "Ambala Ayta",
 3448896,
 "phi",
 "Latn",
}
m["abd"] = {
 "Camarines Norte Agta",
 3399682,
 "phi",
 "Latn",
}
m["abe"] = {
 "Abenaki",
 17502788,
 "alg-abp",
 "Latn",
}
m["abf"] = {
 "Abai Sungai",
 4663287,
 "poz-san",
 "Latn",
}
m["abg"] = {
 "Abaga",
 3507954,
 "paa-kag",
 "Latn",
}
m["abh"] = {
 "Tajiki Arabic",
 56833,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["abi"] = {
 "Abidji",
 34781,
 "alv-lag",
 "Latn",
}
m["abj"] = {
 "Aka-Bea",
 2356391,
 "qfa-ads",
 "Latn",
}
m["abl"] = {
 "Abung",
 49215,
 "poz-lgx",
 "Latn",
}
m["abm"] = {
 "Abanyom",
 7502,
 "nic-eko",
 "Latn",
}
m["abn"] = {
 "Abua",
 34835,
 "nic-cde",
 "Latn",
}
m["abo"] = {
 "Abon",
 35121,
 "nic-tvn",
 "Latn",
}
m["abp"] = {
 "Abenlen Ayta",
 3436621,
 "phi",
 "Latn",
}
m["abq"] = {
 "Abaza",
 27567,
 "cau-abz",
 "Cyrl, Latn",
 translit = {Cyrl = "abq-translit"},
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
 sort_key = {
  Cyrl = {
   from = {
    "гъв", "гъь", "гӏв", "джв", "джь", "къв", "къь", "кӏв", "кӏь", "хъв", "хӏв", "чӏв", -- 3 chars
    "гв", "гъ", "гь", "гӏ", "дж", "дз", "ё", "жв", "жь", "кв", "къ", "кь", "кӏ", "ль", "лӏ", "пӏ", "тл", "тш", "тӏ", "фӏ", "хв", "хъ", "хь", "хӏ", "цӏ", "чв", "чӏ", "шв", "шӏ" -- 2 chars
   },
   to = {
    "г" .. p[3], "г" .. p[4], "г" .. p[7], "д" .. p[2], "д" .. p[3], "к" .. p[3], "к" .. p[4], "к" .. p[7], "к" .. p[8], "х" .. p[3], "х" .. p[6], "ч" .. p[3],
    "г" .. p[1], "г" .. p[2], "г" .. p[5], "г" .. p[6], "д" .. p[1], "д" .. p[4], "е" .. p[1], "ж" .. p[1], "ж" .. p[2], "к" .. p[1], "к" .. p[2], "к" .. p[5], "к" .. p[6], "л" .. p[1], "л" .. p[2], "п" .. p[1], "т" .. p[1], "т" .. p[2], "т" .. p[3], "ф" .. p[1], "х" .. p[1], "х" .. p[2], "х" .. p[4], "х" .. p[5], "ц" .. p[1], "ч" .. p[1], "ч" .. p[2], "ш" .. p[1], "ш" .. p[2]
   }
  },
 },
}
m["abr"] = {
 "Abron",
 34831,
 "alv-ctn",
 "Latn",
 ancestors = "ak",
}
m["abs"] = {
 "Ambonese Malay",
 3124354,
 "crp",
 "Latn",
 ancestors = "ms",
}
m["abt"] = {
 "Ambulas",
 3508015,
 "paa-spk",
 "Latn",
}
m["abu"] = {
 "Abure",
 34767,
 "alv-ptn",
 "Latn",
}
m["abv"] = {
 "Baharna Arabic",
 56576,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["abw"] = {
 "Pal",
 7126121,
 "ngf-mad",
 "Latn",
}
m["abx"] = {
 "Inabaknon",
 2820163,
 "poz-sbj",
 "Latn",
}
m["aby"] = {
 "Aneme Wake",
 3508107,
 "ngf",
 "Latn",
}
m["abz"] = {
 "Abui",
 2822110,
 "qfa-tap",
 "Latn",
}
m["aca"] = {
 "Achagua",
 2822982,
 "awd",
 "Latn",
}
m["acb"] = {
 "Áncá",
 11130787,
 "nic-mom",
 "Latn",
}
m["acd"] = {
 "Gikyode",
 35256,
 "alv-gng",
 "Latn",
}
m["ace"] = {
 "Acehnese",
 27683,
 "cmc",
 "Latn, ms-Arab",
 standardChars = {
  Latn = "AaBbCcDdEeÉéÈèËëFfGgHhIiJjKkLlMmNnOoÔôÖöPpQqRrSsTtUuVvWwXxYyZz", -- current orthography (not yet add Arab)
  c.punc
 },
}
m["ach"] = {
 "Acholi",
 34926,
 "sdv-los",
 "Latn",
}
m["aci"] = {
 "Aka-Cari",
 2670418,
 "qfa-adn",
 "Latn",
}
m["ack"] = {
 "Aka-Kora",
 3433680,
 "qfa-adn",
 "Latn",
}
m["acl"] = {
 "Akar-Bale",
 3436825,
 "qfa-ads",
 "Latn",
}
m["acm"] = {
 "Iraqi Arabic",
 56232,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["acn"] = {
 "Achang",
 56582,
 "tbq-brm",
 "Latn",
}
m["acp"] = {
 "Eastern Acipa",
 5329945,
 "nic-kmk",
 "Latn",
}
m["acr"] = {
 "Achi",
 34774,
 "myn",
 "Latn",
}
m["acs"] = {
 "Acroá",
 2829146,
 "sai-cje",
 "Latn",
}
m["acu"] = {
 "Achuar",
 2823170,
 "sai-jiv",
 "Latn",
}
m["acv"] = {
 "Achumawi",
 56661,
 "nai-pal",
 "Latn",
}
m["acw"] = {
 "Hijazi Arabic",
 56608,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["acx"] = {
 "Omani Arabic",
 56630,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["acy"] = {
 "Cypriot Arabic",
 56416,
 "sem-arb",
 "Latn,Grek",
 ancestors = "acm",
 standardChars = {
  Latn = "AaBbCcDdΔδEeFfGgĠġĊċIiJjKkLlMmNnOoPpΘθRrSsTtUuVvWwXxYyZzŞş",
  c.punc
 },
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.breve},
}
m["acz"] = {
 "Acheron",
 34769,
 "alv-tal",
 "Latn",
}
m["ada"] = {
 "Adangme",
 35141,
 "alv-gda",
 "Latn",
}
m["adb"] = { -- rename or remove, see RFM
 "Adabe",
 36872,
 nil,
 "Latn",
}
m["add"] = {
 "Dzodinka",
 35266,
 "nic-nka",
 "Latn",
}
m["ade"] = {
 "Adele",
 27740,
 "alv-ntg",
 "Latn",
}
m["adf"] = {
 "Dhofari Arabic",
 56565,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["adg"] = {
 "Andegerebinha",
 3508123,
 "aus-pam",
 "Latn",
}
m["adh"] = {
 "Adhola",
 1971400,
 "sdv-los",
 "Latn",
}
m["adi"] = {
 "Adi",
 56440,
 "sit-tan",
 "Latn",
}
m["adj"] = {
 "Adioukrou",
 34738,
 "alv-lag",
 "Latn",
}
m["adl"] = {
 "Galo",
 2857892,
 "sit-tan",
 "Latn",
}
m["adn"] = {
 "Adang",
 3398276,
 "qfa-tap",
 "Latn",
}
m["ado"] = {
 "Abu",
 56659,
 "paa-ram",
 "Latn",
}
m["adp"] = {
 "Adap",
 3512402,
 "sit-tib",
 "Tibt",
 ancestors = "dz",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
 wikipedia_article = "Dzongkha",  -- Considered a dialect of Dzongkha
}
m["adq"] = {
 "Adangbe",
 34730,
 "alv-gda",
 "Latn",
 ancestors = "ada",
}
m["adr"] = {
 "Adonara",
 4684505,
 "poz-cet",
 "Latn",
}
m["ads"] = {
 "Adamorobe Sign Language",
 27709,
 "sgn",
 "Latn", -- when documented
}
m["adt"] = {
 "Adnyamathanha",
 2225391,
 "aus-psw",
 "Latn",
}
m["adu"] = {
 "Aduge",
 34734,
 "alv-nwd",
 "Latn",
 ancestors = "opa",
 wikipedia_article = "Okpamheri language",
}
m["adw"] = {
 "Amondawa",
 12626847,
 "tup-gua",
 "Latn",
}
m["ady"] = {
 "Adyghe",
 27776,
 "cau-cir",
 "Cyrl, Latn, Arab",
 translit = {
  Cyrl = "cau-cir-translit",
  Arab = "ar-translit",
 },
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
 sort_key = {
  Cyrl = {
   from = {
    "кхъу", "къӏу", -- 4 chars
    "гъу", "джу", "дзу", "жъу", "къу", "кхъ", "къӏ", "кӏу", "кӏь", "лъу", "лӏу", "пӏу", "сӏу", "тӏу", "фӏу", "хъу", "цӏу", "чъу", "чӏу", "шъу", "шӏу", "щӏу", -- 3 chars
    "гу", "гъ", "гь", "дж", "дз", "ё", "жъ", "жь", "ку", "къ", "кь", "кӏ", "лъ", "ль", "лӏ", "пӏ", "сӏ", "тӏ", "фӏ", "ху", "хъ", "хь", "цу", "цӏ", "чу", "чъ", "чӏ", "шъ", "шӏ", "щӏ", "ӏу", "ӏь" -- 2 chars
   },
   to = {
    "к" .. p[5], "к" .. p[7],
    "г" .. p[3], "д" .. p[2], "д" .. p[4], "ж" .. p[2], "к" .. p[3], "к" .. p[4], "к" .. p[6], "к" .. p[10], "к" .. p[11], "л" .. p[2], "л" .. p[5], "п" .. p[2], "с" .. p[2], "т" .. p[2], "ф" .. p[2], "х" .. p[3], "ц" .. p[3], "ч" .. p[3], "ч" .. p[5], "ш" .. p[2], "ш" .. p[4], "щ" .. p[2],
    "г" .. p[1], "г" .. p[2], "г" .. p[4], "д" .. p[1], "д" .. p[3], "е" .. p[1], "ж" .. p[1], "ж" .. p[3], "к" .. p[1], "к" .. p[2], "к" .. p[8], "к" .. p[9], "л" .. p[1], "л" .. p[3], "л" .. p[4], "п" .. p[1], "с" .. p[1], "т" .. p[1], "ф" .. p[1], "х" .. p[1], "х" .. p[2], "х" .. p[4], "ц" .. p[1], "ц" .. p[2], "ч" .. p[1], "ч" .. p[2], "ч" .. p[4], "ш" .. p[1], "ш" .. p[3], "щ" .. p[1], "ӏ" .. p[1], "ӏ" .. p[2]
   }
  },
 },
}
m["adz"] = {
 "Adzera",
 nil,
 "poz-ocw",
 "Latn",
}
m["aea"] = {
 "Areba",
 3509129,
 "aus-pam",
 "Latn",
}
m["aeb"] = {
 "Tunisian Arabic",
 56240,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["aed"] = {
 "Argentine Sign Language",
 3322073,
 "sgn",
 "Latn", -- when documented
}
m["aee"] = {
 "Northeast Pashayi",
 12642198,
 "inc-dar",
 "Latn",
}
m["aek"] = {
 "Haeke",
 5638166,
 "poz-cln",
 "Latn",
}
m["ael"] = {
 "Ambele",
 34818,
 "nic-grf",
 "Latn",
}
m["aem"] = {
 "Arem",
 3507920,
 "mkh-vie",
 "Latn",
}
m["aen"] = {
 "Armenian Sign Language",
 3446604,
 "sgn",
}
m["aeq"] = {
 "Aer",
 3246741,
 "inc-wes",
 "Arab",
 ancestors = "inc-gup",
}
m["aer"] = {
 "Eastern Arrernte",
 10728232,
 "aus-pam",
 "Latn",
}
m["aes"] = {
 "Alsea",
 2395641,
 nil,
 "Latn",
}
m["aeu"] = {
 "Akeu",
 4700657,
 "tbq-lol",
 "Latn",
}
m["aew"] = {
 "Ambakich",
 56642,
 "paa-ram",
 "Latn",
}
m["aey"] = {
 "Amele",
 3508025,
 "ngf-mad",
 "Latn",
}
m["aez"] = {
 "Aeka",
 16110528,
 "ngf",
 "Latn",
 wikipedia_article = "Orokaiva language", -- subvariety?
}
m["afb"] = {
 "Gulf Arabic",
 56385,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["afd"] = {
 "Andai",
 4753480,
 "paa-arf",
 "Latn",
}
m["afe"] = {
 "Putukwam",
 3914930,
 "nic-ben",
 "Latn",
}
m["afg"] = {
 "Afghan Sign Language",
 4689093,
 "sgn",
}
m["afh"] = {
 "Afrihili",
 384707,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["afi"] = {
 "Akrukay",
 57003,
 "paa-ram",
 "Latn",
}
m["afk"] = {
 "Nanubae",
 6964416,
 "paa-arf",
 "Latn",
}
m["afn"] = {
 "Defaka",
 35174,
 "nic",
 "Latn",
}
m["afo"] = {
 "Eloyi",
 3914066,
 "nic-plt",
 "Latn",
}
m["afp"] = {
 "Tapei",
 16887371,
 "paa-arf",
 "Latn",
}
m["afs"] = {
 "Afro-Seminole Creole",
 27867,
 "crp",
 "Latn",
 ancestors = "en",
}
m["aft"] = {
 "Afitti",
 3400829,
 "sdv-nyi",
 "Latn",
}
m["afu"] = {
 "Awutu",
 34847,
 "alv-gng",
 "Latn",
}
m["afz"] = {
 "Obokuitai",
 7075258,
 "paa-lkp",
 "Latn",
}
m["aga"] = {
 "Aguano",
 3331203,
 nil,
 "Latn",
}
m["agb"] = {
 "Legbo",
 35584,
 "nic-uce",
 "Latn",
}
m["agc"] = {
 "Agatu",
 34732,
 "alv-ido",
 "Latn",
}
m["agd"] = {
 "Agarabi",
 3399642,
 "paa-kag",
 "Latn",
}
m["age"] = {
 "Angal",
 10951553,
 "paa-eng",
 "Latn",
}
m["agf"] = {
 "Arguni",
 12473346,
 "poz-cet",
 "Latn",
}
m["agg"] = {
 "Angor",
 3508100,
 "paa",
 "Latn",
}
m["agh"] = {
 "Ngelima",
 7022266,
 "bnt-bta",
 "Latn",
}
m["agi"] = {
 "Agariya",
 663586,
 "mun",
 "Deva",
}
m["agj"] = {
 "Argobba",
 29292,
 "sem-eth",
 "Ethi",
}
m["agk"] = {
 "Isarog Agta",
 6078982,
 "phi",
 "Latn",
}
m["agl"] = {
 "Fembe",
 372927,
 "ngf",
 "Latn",
}
m["agm"] = {
 "Angaataha",
 3508001,
 "ngf",
 "Latn",
}
m["agn"] = {
 "Agutaynen",
 3399717,
 "phi-kal",
 "Latn",
}
m["ago"] = {
 "Tainae",
 7676186,
 "ngf",
 "Latn",
}
m["agq"] = {
 "Aghem",
 34737,
 "nic-rnw",
 "Latn",
}
m["agr"] = {
 "Aguaruna",
 1526530,
 "sai-jiv",
 "Latn",
}
m["ags"] = {
 "Esimbi",
 35260,
 "nic-bds",
 "Latn",
}
m["agt"] = {
 "Central Cagayan Agta",
 5017296,
 "phi",
 "Latn",
}
m["agu"] = {
 "Aguacateca",
 35091,
 "myn",
 "Latn",
}
m["agv"] = {
 "Remontado Agta",
 3508085,
 "phi",
 "Latn",
}
m["agw"] = {
 "Kahua",
 3191906,
 "poz-sls",
 "Latn",
}
m["agx"] = {
 "Aghul",
 36498,
 "cau-esm",
 "Cyrl",
 translit = "cau-nec-translit",
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
 sort_key = {
  from = {"аь", "гъ", "гь", "гӏ", "дж", "ё", "къ", "кь", "кӏ", "оь", "пӏ", "тӏ", "уь", "хъ", "хь", "хӏ", "цӏ", "чӏ"},
  to = {"а" .. p[1], "г" .. p[1], "г" .. p[2], "г" .. p[3], "д" .. p[1], "е" .. p[1], "к" .. p[1], "к" .. p[2], "к" .. p[3], "о" .. p[1], "п" .. p[1], "т" .. p[1], "у" .. p[1], "х" .. p[1], "х" .. p[2], "х" .. p[3], "ц" .. p[1], "ч" .. p[1]}
 },
}
m["agy"] = {
 "Southern Alta",
 7569611,
 "phi",
 "Latn",
}
m["agz"] = {
 "Mount Iriga Agta",
 6921432,
 "phi",
 "Latn",
}
m["aha"] = {
 "Ahanta",
 34729,
 "alv-ctn",
 "Latn",
}
m["ahb"] = {
 "Axamb",
 2874710,
 "poz-vnc",
 "Latn",
}
m["ahg"] = {
 "Qimant",
 35663,
 "cus-cen",
 "Latn",
}
m["ahh"] = {
 "Aghu",
 3436645,
 "ngf",
 "Latn",
}
m["ahi"] = {
 "Tiagbamrin Aizi",
 3400073,
 "kro-aiz",
 "Latn",
}
m["ahk"] = {
 "Akha",
 56643,
 "tbq-lol",
 "Latn, Mymr, Thai",
 sort_key = {
  Thai = {
   from = {"[%pๆ]", "[็-๎]", "([เแโใไ])([ก-ฮ])"},
   to = {"", "", "%2%1"}
  },
 },
}
m["ahl"] = {
 "Igo",
 35412,
 "alv-ktg",
 "Latn",
}
m["ahm"] = {
 "Mobumrin Aizi",
 35967,
 "kro-aiz",
 "Latn",
}
m["ahn"] = {
 "Àhàn",
 34723,
 "alv-aah",
 "Latn",
}
m["aho"] = {
 "Ahom",
 34778,
 "tai-swe",
 "Ahom",
 translit = "Ahom-translit",
}
m["ahp"] = {
 "Aproumu Aizi",
 34810,
 "alv-kwa",
 "Latn",
}
m["ahr"] = {
 "Ahirani",
 15549890,
 "inc-wes",
 "Deva",
 ancestors = "inc-pra",
 translit = "mr-translit",
}
m["ahs"] = {
 "Ashe",
 34823,
 "nic-plc",
 "Latn",
}
m["aht"] = {
 "Ahtna",
 21058,
 "ath-nor",
 "Latn",
}
m["aia"] = {
 "Arosi",
 2863483,
 "poz-sls",
 "Latn",
}
m["aib"] = {
 "Aynu",
 27927,
 "trk-kar",
 "Arab, Latn",
}
m["aic"] = {
 "Ainbai",
 3332149,
 "paa-brd",
 "Latn",
}
m["aid"] = {
 "Alngith",
 3279409,
 "aus-pmn",
 "Latn",
}
m["aie"] = {
 "Amara",
 2841180,
 "poz-ocw",
 "Latn",
}
m["aif"] = {
 "Agi",
 3331491,
 "qfa-tor",
 "Latn",
}
m["aig"] = {
 "Antigua and Barbuda Creole English",
 3244184,
 "crp",
 "Latn",
 ancestors = "en",
}
m["aih"] = {
 "Ai-Cham",
 2827749,
 "qfa-kms",
 "Latn, Hani",
 sort_key = {Hani = "Hani-sortkey"},
}
m["aii"] = {
 "Assyrian Neo-Aramaic",
 29440,
 "sem-nna",
 "Syrc",
 translit = "aii-translit",
 entry_name = "Syrc-entryname",
}
m["aij"] = {
 "Lishanid Noshan",
 3436467,
 "sem-nna",
 "Hebr",
}
m["aik"] = {
 "Ake",
 34808,
 "nic-pls",
 "Latn",
}
m["ail"] = {
 "Aimele",
 3327418,
 "ngf",
 "Latn",
}
m["aim"] = {
 "Aimol",
 4697175,
 "tbq-kuk",
 "Latn, Beng",
}
m["ain"] = {
 "Ainu",
 27969,
 "qfa-iso",
 "Kana, Latn, Cyrl",
 sort_key = {Kana = "Kana-sortkey"},
}
m["aio"] = {
 "Aiton",
 3399725,
 "tai-swe",
 "Mymr",
 translit = "aio-phk-translit",
 entry_name = {remove_diacritics = c.VS01},
}
m["aip"] = {
 "Burumakok",
 5000984,
 "ngf-okk",
 "Latn",
}
m["air"] = {
 "Airoran",
 3321131,
 "paa-tkw",
 "Latn",
}
m["ait"] = {
 "Arikem",
 3446679,
 "tup",
 "Latn",
}
m["aiw"] = {
 "Aari",
 7495,
 "omv-aro",
 "Latn",
}
m["aix"] = {
 "Aighon",
 3504287,
 "poz-ocw",
 "Latn",
}
m["aiy"] = {
 "Ali",
 34814,
 "alv-gbf",
 "Latn",
}
m["aja"] = {
 "Aja",
 3237491,
 "csu-bkr",
 "Latn",
}
m["ajg"] = {
 "Adja",
 35035,
 "alv-gbe",
 "Latn",
}
m["aji"] = {
 "Ajië",
 2828867,
 "poz-cln",
 "Latn",
}
m["ajn"] = {
 "Andajin",
 16111302,
 "aus-wor",
 "Latn",
}
m["ajp"] = {
 "South Levantine Arabic",
 nil,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["ajw"] = {
 "Ajawa",
 56645,
 "cdc-wst",
 "Latn",
}
m["ajz"] = {
 "Amri Karbi",
 3508092,
 "tbq-kuk",
 "Latn",
 ancestors = "mjw",
}
m["akb"] = {
 "Angkola Batak",
 2640686,
 "btk",
 "Latn, Batk",
}
m["akc"] = {
 "Mpur",
 3327139,
 "paa-wpa",
 "Latn",
}
m["akd"] = {
 "Ukpet-Ehom",
 36618,
 "nic-ucr",
 "Latn",
}
m["ake"] = {
 "Akawaio",
 28059,
 "sai-pem",
 "Latn",
}
m["akf"] = {
 "Akpa",
 34801,
 "alv-ido",
 "Latn",
}
m["akg"] = {
 "Anakalangu",
 4750964,
 "poz-cet",
 "Latn",
}
m["akh"] = {
 "Angal Heneng",
 10950354,
 "paa-eng",
 "Latn",
}
m["aki"] = {
 "Aiome",
 56735,
 "paa",
 "Latn",
}
m["akj"] = {
 "Jeru",
 2919121,
 "qfa-adn",
 "Latn, Deva",
}
m["akk"] = {
 "Akkadian",
 35518,
 "sem-eas",
 "Xsux, Latn",
}
m["akl"] = {
 "Aklanon",
 8773,
 "phi",
 "Latn",
}
m["akm"] = {
 "Aka-Bo",
 35361,
 "qfa-adn",
 "Latn",
}
m["ako"] = {
 "Akurio",
 56650,
 "sai-tar",
 "Latn",
}
m["akp"] = {
 "Siwu",
 36470,
 "alv-ntg",
 "Latn",
}
m["akq"] = {
 "Ak",
 56654,
 "paa",
 "Latn",
}
m["akr"] = {
 "Araki",
 2699882,
 "poz-vnc",
 "Latn",
}
m["aks"] = {
 "Akaselem",
 34817,
 "nic-grm",
 "Latn",
}
m["akt"] = {
 "Akolet",
 3330162,
 "poz-ocw",
 "Latn",
}
m["aku"] = {
 "Akum",
 34799,
 "nic-ykb",
 "Latn",
}
m["akv"] = {
 "Akhvakh",
 56423,
 "cau-and",
 "Cyrl",
 translit = "cau-nec-translit",
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
}
m["akw"] = {
 "Akwa",
 34802,
 "bnt-mbo",
 "Latn",
}
m["akx"] = {
 "Aka-Kede",
 3436816,
 "qfa-adc",
 "Latn",
}
m["aky"] = {
 "Aka-Kol",
 3436784,
 "qfa-adc",
 "Latn",
}
m["akz"] = {
 "Alabama",
 1815020,
 "nai-mus",
 "Latn",
}
m["ala"] = {
 "Alago",
 34813,
 "alv-ido",
 "Latn",
}
m["alc"] = {
 "Kawésqar",
 56544,
 "aqa",
 "Latn",
}
m["ald"] = {
 "Alladian",
 34837,
 "alv-lag",
 "Latn",
}
m["ale"] = {
 "Aleut",
 27210,
 "esx",
 "Latn",
}
m["alf"] = {
 "Alege",
 34815,
 "nic-ben",
 "Latn",
}
m["alh"] = {
 "Alawa",
 2147917,
 "aus-gun",
 "Latn",
}
m["ali"] = {
 "Amaimon",
 3327427,
 "ngf-mad",
 "Latn",
}
m["alj"] = {
 "Alangan",
 3327423,
 "phi",
 "Latn",
}
m["alk"] = {
 "Alak",
 2714690,
 "mkh",
 "Latn",
}
m["all"] = {
 "Allar",
 3393634,
 "dra",
 "Mlym",
}
-- "aln" IS TREATED AS "sq", SEE WT:LT
m["alm"] = {
 "Amblong",
 11022615,
 "poz-vnc",
 "Latn",
}
m["alo"] = {
 "Larike-Wakasihu",
 3217929,
 "poz-cma",
 "Latn",
}
m["alp"] = {
 "Alune",
 3327367,
 "poz-cet",
 "Latn",
}
m["alq"] = {
 "Algonquin",
 28092,
 "alg",
 "Latn",
 ancestors = "oj",
}
m["alr"] = {
 "Alutor",
 28213,
 "qfa-cka",
 "Cyrl",
 entry_name = {
  from = {"['’]"},
  to = {"ʼ"}
 },
 sort_key = {
  from = {"вʼ", "гʼ", "ғ", "ә", "ё", "ӄ", "ӈ"},
  to = {"в" .. p[1], "г" .. p[1], "г" .. p[2], "е" .. p[1], "е" .. p[2], "к" .. p[1], "н" .. p[1]}
 },
}
m["alt"] = {
 "Southern Altai",
 1991779,
 "trk-sib",
 "Cyrl",
 translit = "Altai-translit",
 sort_key = {
  from = {"ј", "ё", "ҥ", "ӧ", "ӱ"},
  to = {"д" .. p[1], "е" .. p[1], "н" .. p[1], "о" .. p[1], "у" .. p[1]}
 },
}
m["alu"] = {
 "'Are'are",
 5160,
 "poz-sls",
 "Latn",
}
m["alw"] = {
 "Alaba",
 56652,
 "cus-hec",
 "Latn",
}
m["alx"] = {
 "Amol",
 3504260,
 "qfa-tor",
 "Latn",
}
m["aly"] = {
 "Alyawarr",
 3327389,
 "aus-pam",
 "Latn",
}
m["alz"] = {
 "Alur",
 56507,
 "sdv-los",
 "Latn",
}
m["ama"] = {
 "Amanayé",
 3508053,
 "tup-gua",
 "Latn",
}
m["amb"] = {
 "Ambo",
 3450142,
 "nic-tvn",
 "Latn",
}
m["amc"] = {
 "Amahuaca",
 2669150,
 "sai-pan",
 "Latn",
}
m["ame"] = {
 "Yanesha'",
 3088540,
 "awd",
 "Latn",
}
m["amf"] = {
 "Hamer-Banna",
 35764,
 "omv-aro",
 "Latn",
}
m["amg"] = {
 "Amurdag",
 3360016,
 "aus-wdj",
 "Latn",
}
m["ami"] = {
 "Amis",
 35132,
 "map",
 "Latn",
}
m["amj"] = {
 "Amdang",
 28335,
 "ssa-fur",
 "Latn",
}
m["amk"] = {
 "Ambai",
 1875885,
 "poz-hce",
 "Latn",
}
m["aml"] = {
 "War-Jaintia",
 56321,
 "aav-khs",
 "Latn",
}
m["amm"] = {
 "Ama",
 3446626,
 "qfa-mal",
 "Latn",
}
m["amn"] = {
 "Amanab",
 3327399,
 "paa-brd",
 "Latn",
}
m["amo"] = {
 "Amo",
 34826,
 "nic-kne",
 "Latn",
}
m["amp"] = {
 "Alamblak",
 56688,
 "paa",
 "Latn",
}
m["amq"] = {
 "Amahai",
 3327384,
 "poz-cma",
 "Latn",
}
m["amr"] = {
 "Amarakaeri",
 35128,
 "sai-har",
 "Latn",
}
m["ams"] = {
 "Southern Amami-Oshima",
 2840986,
 "jpx-ryu",
 "Jpan",
 translit = s["Jpan-translit"],
 sort_key = s["Jpan-sortkey"],
}
m["amt"] = {
 "Amto",
 56517,
 "paa-asa",
 "Latn",
}
m["amu"] = {
 "Guerrero Amuzgo",
 3501942,
 "omq",
 "Latn",
}
m["amv"] = {
 "Ambelau",
 2669214,
 "poz-cma",
 "Latn",
}
m["amw"] = {
 "Western Neo-Aramaic",
 34226,
 "sem-arw",
 "Armi, Syrc, Latn",
 entry_name = {Syrc = "Syrc-entryname"},
}
m["amx"] = {
 "Anmatyerre",
 10412317,
 "aus-pam",
 "Latn",
}
m["amy"] = {
 "Ami",
 12626835,
 "aus-dal",
 "Latn",
}
m["amz"] = {
 "Atampaya",
 3446651,
 "aus-pam",
 "Latn",
}
m["ana"] = {
 "Andaqui",
 2846078,
 nil,
 "Latn",
}
m["anb"] = {
 "Andoa",
 2846171,
 "sai-zap",
 "Latn",
}
m["anc"] = {
 "Ngas",
 35999,
 "cdc-wst",
 "Latn",
}
m["and"] = {
 "Ansus",
 3513300,
 "poz-hce",
 "Latn",
}
m["ane"] = {
 "Xârâcùù",
 3571097,
 "poz-cln",
 "Latn",
}
m["anf"] = {
 "Animere",
 34783,
 "alv-ktg",
 "Latn",
}
m["ang"] = {
 "Old English",
 42365,
 "gmw",
 "Latnx, Runr",
 translit = {Runr = "Runr-translit"},
 entry_name = {
  Latnx = {
   remove_diacritics = c.acute .. c.macron .. c.dotabove,
   from = {"Ƿ", "ƿ"},
   to = {"W", "w"}
  },
 },
 sort_key = {
  Latnx = {
   from = {"æ", "ð", "þ", "ƿ"},
   to = {"ae", "t" .. p[1], "t" .. p[2], "w" .. p[1]}
  },
 },
}
m["anh"] = {
 "Nend",
 6991554,
 "ngf-mad",
 "Latn",
}
m["ani"] = {
 "Andi",
 34849,
 "cau-and",
 "Cyrl",
 translit = "cau-nec-translit",
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
}
m["anj"] = {
 "Anor",
 56458,
 "paa",
 "Latn",
}
m["ank"] = {
 "Goemai",
 35272,
 "cdc-wst",
 "Latn",
}
m["anl"] = {
 "Anu",
 4777679,
 "sit-mru",
 "Latn",
}
m["anm"] = {
 "Anal",
 56235,
 "tbq-kuk",
 "Latn",
}
m["ann"] = {
 "Obolo",
 36614,
 "nic-lcr",
 "Latn",
}
m["ano"] = {
 "Andoque",
 2669225,
 "qfa-iso",
 "Latn",
}
m["anp"] = {
 "Angika",
 28378,
 "inc-eas",
 "Deva",
 ancestors = "bh",
}
m["anq"] = {
 "Jarawa",
 2475526,
 "qfa-ong",
 "Latn",
}
m["anr"] = {
 "Andh",
 4754314,
 "inc-sou",
 "Deva",
 ancestors = "pra-mah",
}
m["ans"] = {
 "Anserma",
 3446613,
 "sai-chc",
 "Latn",
}
m["ant"] = {
 "Antakarinya",
 921304,
 "aus-psw",
 "Latn",
}
m["anu"] = {
 "Anuak",
 56677,
 "sdv-lon",
 "Latn",
}
m["anv"] = {
 "Denya",
 35187,
 "nic-mam",
 "Latn",
}
m["anw"] = {
 "Anaang",
 2845320,
 "nic-ief",
 "Latn",
}
m["anx"] = {
 "Andra-Hus",
 2846195,
 "poz-aay",
 "Latn",
}
m["any"] = {
 "Anyi",
 28395,
 "alv-ctn",
 "Latn",
}
m["anz"] = {
 "Anem",
 56512,
 "paa",
 "Latn",
}
m["aoa"] = {
 "Angolar",
 34994,
 "crp",
 "Latn",
 ancestors = "pt",
}
m["aob"] = {
 "Abom",
 3446647,
 "ngf",
 "Latn",
}
m["aoc"] = {
 "Pemon",
 10729616,
 "sai-pem",
 "Latn",
}
m["aod"] = {
 "Andarum",
 3507888,
 "paa",
 "Latn",
}
m["aoe"] = {
 "Angal Enen",
 10951638,
 "paa-eng",
 "Latn",
}
m["aof"] = {
 "Bragat",
 3507977,
 "qfa-tor",
 "Latn",
}
m["aog"] = {
 "Angoram",
 56366, -- cf 6754745 for merged dialect
 "paa-lsp",
 "Latn",
}
m["aoi"] = {
 "Anindilyakwa",
 2714654,
 "aus-arn",
 "Latn",
}
m["aoj"] = {
 "Mufian",
 3507881,
 "qfa-tor",
 "Latn",
}
m["aok"] = {
 "Arhö",
 4790086,
 "poz-cln",
 "Latn",
}
m["aol"] = {
 "Alor",
 3332062,
 "poz",
 "Latn",
}
m["aom"] = {
 "Ömie",
 8078975,
 "ngf",
 "Latn",
}
m["aon"] = {
 "Bumbita Arapesh",
 3508044,
 "qfa-tor",
 "Latn",
}
m["aor"] = {
 "Aore",
 12627129,
 "poz-vnc",
 "Latn",
}
m["aos"] = {
 "Taikat",
 7676018,
 "paa-brd",
 "Latn",
}
m["aot"] = {
 "Atong (India)",
 5646,
 "tbq-bdg",
 "Latn, Beng",
}
m["aou"] = {
 "A'ou",
 16109994,
 "qfa-gel",
 "Latn", -- also Hani?
}
m["aox"] = {
 "Atorada",
 3507932,
 "awd",
 "Latn",
}
m["aoz"] = {
 "Uab Meto",
 3441962,
 "poz-tim",
 "Latn",
}
m["apb"] = {
 "Sa'a",
 36294,
 "poz-sls",
 "Latn",
}
m["apc"] = {
 "North Levantine Arabic",
 22809485,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["apd"] = {
 "Sudanese Arabic",
 56573,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["ape"] = {
 "Bukiyip",
 3507895,
 "qfa-tor",
 "Latn",
}
m["apf"] = {
 "Pahanan Agta",
 7135432,
 "phi",
 "Latn",
}
m["apg"] = {
 "Ampanang",
 4748035,
 "poz",
 "Latn",
}
m["aph"] = {
 "Athpare",
 3449126,
 "sit-kie",
 "Deva, Latn",
}
m["api"] = {
 "Apiaká",
 3507941,
 "tup-gua",
 "Latn",
}
m["apj"] = {
 "Jicarilla",
 28277,
 "apa",
 "Latn",
}
m["apk"] = {
 "Plains Apache",
 27861,
 "apa",
 "Latn",
}
m["apl"] = {
 "Lipan",
 28269,
 "apa",
 "Latn",
}
m["apm"] = {
 "Chiricahua",
 13368,
 "apa",
 "Latn",
}
m["apn"] = {
 "Apinayé",
 2858311,
 "sai-nje",
 "Latn",
}
m["apo"] = {
 "Ambul",
 12627135,
 "poz-ocw",
 "Latn",
}
m["app"] = {
 "Apma",
 2669188,
 "poz-vnc",
 "Latn",
}
m["apq"] = {
 "A-Pucikwar",
 28466,
 "qfa-adc",
 "Latn",
}
m["apr"] = {
 "Arop-Lokep",
 2863482,
 "poz-ocw",
 "Latn",
}
m["aps"] = {
 "Arop-Sissano",
 12627242,
 "poz-ocw",
 "Latn",
}
m["apt"] = {
 "Apatani",
 56306,
 "sit-tan",
 "Latn",
}
m["apu"] = {
 "Apurinã",
 2859081,
 "awd",
 "Latn",
}
m["apv"] = {
 "Alapmunte",
 16110782,
 "sai-nmk",
 "Latn",
}
m["apw"] = {
 "Western Apache",
 28060,
 "apa",
 "Latn",
}
m["apx"] = {
 "Aputai",
 12473343,
 "poz-tim",
 "Latn",
}
m["apy"] = {
 "Apalaí",
 2736980,
 "sai-gui",
 "Latn",
}
m["apz"] = {
 "Safeyoka",
 7398693,
 "ngf",
 "Latn",
}
m["aqc"] = {
 "Archi",
 34915,
 "cau-lzg",
 "Cyrl",
 translit = "cau-nec-translit",
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
 sort_key = {
  from = {
   "ккъӏв", "ххьӏв", -- 5 chars
   "гъӏв", "ёоӏ", "ккъӏ", "ккъв", "къӏв", "ллъв", "ххьӏ", "хъӏв", "хьӏв", "ццӏв", "ччӏв", -- 4 chars
   "ааӏ", "гӏв", "гъӏ", "гъв", "гьв", "ееӏ", "ёӏ", "ёо", "ииӏ", "кӏв", "ккв", "ккъ", "къӏ", "къв", "кьв", "лӏв", "ллъ", "лъв", "льв", "ооӏ", "пӏв", "ппв", "ссв", "тӏв", "ттв", "ууӏ", "хӏв", "ххв", "хъӏ", "хъв", "хьӏ", "цӏв", "ццӏ", "ццв", "чӏв", "ччӏ", "ээӏ", "юуӏ", "яаӏ", -- 3 chars
   "аӏ", "аа", "гӏ", "гв", "гъ", "гь", "дв", "еӏ", "ее", "ё", "жв", "зв", "иӏ", "ии", "кӏ", "кв", "кк", "къ", "кь", "лӏ", "лв", "лъ", "ль", "оӏ", "оо", "пӏ", "пв", "пп", "св", "сс", "тӏ", "тв", "тт", "уӏ", "уу", "фв", "хӏ", "хв", "хх", "хъ", "цӏ", "цв", "цц", "чӏ", "чв", "шв", "щв", "эӏ", "ээ", "юӏ", "юу", "яӏ", "яа" -- 2 chars
  },
  to = {
   "к" .. p[8], "х" .. p[7],
   "г" .. p[6], "е" .. p[7], "к" .. p[7], "к" .. p[9], "к" .. p[12], "л" .. p[5], "х" .. p[6], "х" .. p[10], "х" .. p[13], "ц" .. p[6], "ч" .. p[5],
   "а" .. p[3], "г" .. p[2], "г" .. p[5], "г" .. p[7], "г" .. p[9], "е" .. p[3], "е" .. p[5], "е" .. p[6], "и" .. p[3], "к" .. p[2], "к" .. p[5], "к" .. p[6], "к" .. p[11], "к" .. p[13], "к" .. p[15], "л" .. p[2], "л" .. p[4], "л" .. p[7], "л" .. p[9], "о" .. p[3], "п" .. p[2], "п" .. p[5], "с" .. p[3], "т" .. p[2], "т" .. p[5], "у" .. p[3], "х" .. p[2], "х" .. p[5], "х" .. p[9], "х" .. p[11], "х" .. p[12], "ц" .. p[2], "ц" .. p[5], "ц" .. p[7], "ч" .. p[2], "ч" .. p[4], "э" .. p[3], "ю" .. p[3], "я" .. p[3],
   "а" .. p[1], "а" .. p[2], "г" .. p[1], "г" .. p[3], "г" .. p[4], "г" .. p[8], "д" .. p[1], "е" .. p[1], "е" .. p[2], "е" .. p[4], "ж" .. p[1], "з" .. p[1], "и" .. p[1], "и" .. p[2], "к" .. p[1], "к" .. p[3], "к" .. p[4], "к" .. p[10], "к" .. p[14], "л" .. p[1], "л" .. p[3], "л" .. p[6], "л" .. p[8], "о" .. p[1], "о" .. p[2], "п" .. p[1], "п" .. p[3], "п" .. p[4], "с" .. p[1], "с" .. p[2], "т" .. p[1], "т" .. p[3], "т" .. p[4], "у" .. p[1], "у" .. p[2], "ф" .. p[1], "х" .. p[1], "х" .. p[3], "х" .. p[4], "х" .. p[8], "ц" .. p[1], "ц" .. p[3], "ц" .. p[4], "ч" .. p[1], "ч" .. p[3], "ш" .. p[1], "щ" .. p[1], "э" .. p[1], "э" .. p[2], "ю" .. p[1], "ю" .. p[2], "я" .. p[1], "я" .. p[2]
  }
 },
}
m["aqd"] = {
 "Ampari Dogon",
 4748057,
 "nic-dgw",
 "Latn",
}
m["aqg"] = {
 "Arigidi",
 34829,
 "alv-von",
 "Latn",
}
m["aqm"] = {
 "Atohwaim",
 11732297,
 "ngf",
 "Latn",
}
m["aqn"] = {
 "Northern Alta",
 7058116,
 "phi",
 "Latn",
}
m["aqp"] = {
 "Atakapa",
 10975683,
 "qfa-iso",
 "Latn",
}
m["aqr"] = {
 "Arhâ",
 4790085,
 "poz-cln",
 "Latn",
}
m["aqt"] = {
 "Angaité",
 15736037,
 "sai-mas",
 "Latn",
}
m["aqz"] = {
 "Akuntsu",
 4701960,
 "tup",
 "Latn",
}
m["arc"] = {
 "Aramaic",
 28602,
 "sem-ara",
 "Hebr, Armi, Syrc, Palm, Nbat, Phnx, Mand, Samr, Hatr",
 translit = {
  Armi = "Armi-translit",
  Palm = "Palm-translit",
 },
 entry_name = {
  Hebr = {remove_diacritics = u(0x0591) .. "-" .. u(0x05BD) .. u(0x05BF) .. "-" .. u(0x05C5) .. u(0x05C7)},
  Syrc = {remove_diacritics = u(0x0730) .. "-" .. u(0x0748)},
  remove_diacritics = c.macron .. c.diaer .. c.macronbelow}, -- Which script(s)?
}
m["ard"] = {
 "Arabana",
 3507959,
 "aus-kar",
 "Latn",
}
m["are"] = {
 "Western Arrernte",
 12645549,
 "aus-pam",
 "Latn",
}
m["arh"] = {
 "Arhuaco",
 2640621,
 "cba",
 "Latn",
}
m["ari"] = {
 "Arikara",
 56539,
 "cdd",
 "Latn",
}
m["arj"] = {
 "Arapaso",
 12627166,
 "sai-tuc",
 "Latn",
}
m["ark"] = {
 "Arikapú",
 3446640,
 "sai-mje",
 "Latn",
}
m["arl"] = {
 "Arabela",
 2591221,
 "sai-zap",
 "Latn",
}
m["arn"] = {
 "Mapudungun",
 33730,
 "sai-ara",
 "Latn",
}
m["aro"] = {
 "Araona",
 958414,
 "sai-tac",
 "Latn",
}
m["arp"] = {
 "Arapaho",
 56417,
 "alg-ara",
 "Latn",
}
m["arq"] = {
 "Algerian Arabic",
 56499,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["arr"] = {
 "Arara-Karo",
 35539,
 "tup",
 "Latn",
}
m["ars"] = {
 "Najdi Arabic",
 56574,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["aru"] = {
 "Arua",
 2746221,
 "auf",
 "Latn",
}
m["arv"] = {
 "Arbore",
 56883,
 "cus-eas",
 "Latn",
}
m["arw"] = {
 "Arawak",
 2655664,
 "awd-taa",
 "Latn",
}
m["arx"] = {
 "Aruá",
 3507907,
 "tup",
 "Latn",
}
m["ary"] = {
 "Moroccan Arabic",
 56426,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
 sort_key = {
  from = {"^%f[" .. u(0x5D0) .. "-" .. u(0x5EA) .. "]"},
  to = {u(0xFB21)},
 },
}
m["arz"] = {
 "Egyptian Arabic",
 29919,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["asa"] = {
 "Pare",
 36403,
 "bnt-par",
 "Latn",
}
m["asb"] = {
 "Assiniboine",
 2591288,
 "sio-dkt",
 "Latn",
}
m["asc"] = {
 "Casuarina Coast Asmat",
 11732046,
 "ngf",
 "Latn",
}
m["ase"] = {
 "American Sign Language",
 14759,
 "sgn",
 "Sgnw",
}
m["asf"] = {
 "Auslan",
 29525,
 "sgn",
 "Latn", -- when documented
}
m["asg"] = {
 "Cishingini",
 35199,
 "nic-kam",
 "Latn",
}
m["ash"] = {
 "Abishira",
 2871740,
 "qfa-iso",
 "Latn",
}
m["asi"] = {
 "Buruwai",
 5001031,
 "ngf",
 "Latn",
}
m["asj"] = {
 "Nsari",
 36418,
 "nic-bbe",
 "Latn",
}
m["ask"] = {
 "Ashkun",
 29379,
 "nur-sou",
 "Arab, Latn",
}
m["asl"] = {
 "Asilulu",
 12473347,
 "poz-cma",
 "Latn",
}
m["asn"] = {
 "Xingú Asuriní",
 8044571,
 "tup-gua",
 "Latn",
}
m["aso"] = {
 "Dano",
 5220979,
 "paa-kag",
 "Latn",
}
m["asp"] = {
 "Algerian Sign Language",
 3135421,
 "sgn",
}
m["asq"] = {
 "Austrian Sign Language",
 36668,
 "sgn",
 "Latn", -- when documented
}
m["asr"] = {
 "Asuri",
 3504321,
 "mun",
 "Latn", -- when documented
}
m["ass"] = {
 "Ipulo",
 35408,
 "nic-tvc",
 "Latn",
}
m["ast"] = {
 "Asturian",
 29507,
 "roa-ibe",
 "Latn",
 ancestors = "roa-ole",
}
m["asu"] = {
 "Tocantins Asurini",
 32041490,
 "tup-gua",
 "Latn",
}
m["asv"] = {
 "Asoa",
 56296,
 "csu-maa",
 "Latn",
}
m["asw"] = {
 "Australian Aboriginal Sign Language",
 955216,
 "sgn",
 "Latn", -- when documented
}
m["asx"] = {
 "Muratayak",
 11732766,
 "ngf-fin",
 "Latn",
}
m["asy"] = {
 "Yaosakor Asmat",
 16113158,
 "ngf",
 "Latn",
}
m["asz"] = {
 "As",
 2866218,
 "poz-hce",
 "Latn",
}
m["ata"] = {
 "Pele-Ata",
 56511,
 "paa",
 "Latn",
}
m["atb"] = {
 "Zaiwa",
 56594,
 "tbq-brm",
 "Latn, Lisu", -- also Hani?
}
m["atc"] = {
 "Atsahuaca",
 4817730,
 "sai-pan",
 "Latn",
}
m["atd"] = {
 "Ata Manobo",
 12627315,
 "mno",
 "Latn",
}
m["ate"] = {
 "Atemble",
 4813055,
 "ngf-mad",
 "Latn",
}
m["atg"] = {
 "Okpela",
 7082551,
 "alv-yek",
 "Latn",
}
m["ati"] = {
 "Attié",
 34844,
 "alv-lag",
 "Latn",
}
m["atj"] = {
 "Atikamekw",
 56590,
 "alg",
 "Latn",
 ancestors = "cr",
}
m["atk"] = {
 "Ati",
 4815751,
 "phi",
 "Latn",
}
m["atl"] = {
 "Mount Iraya Agta",
 6921430,
 "phi",
 "Latn",
}
m["atm"] = {
 "Ata",
 4812603,
 "phi",
 "Latn",
}
m["ato"] = {
 "Atong (Cameroon)",
 34824,
 "nic-grs",
 "Latn",
}
m["atp"] = {
 "Pudtol Atta",
 12640726,
 "phi",
 "Latn",
}
m["atq"] = {
 "Aralle-Tabulahan",
 4783889,
 "poz-ssw",
 "Latn",
}
m["atr"] = {
 "Waimiri-Atroari",
 56865,
 "sai-car",
 "Latn",
}
m["ats"] = {
 "Gros Ventre",
 56628,
 "alg-ara",
 "Latn",
}
m["att"] = {
 "Pamplona Atta",
 12639245,
 "phi",
 "Latn",
}
m["atu"] = {
 "Reel",
 7306882,
 "sdv-dnu",
 "Latn",
}
m["atv"] = {
 "Northern Altai",
 2640863,
 "trk-sib",
 "Cyrl",
 translit = "Altai-translit",
}
m["atw"] = {
 "Atsugewi",
 56718,
 "nai-pal",
 "Latn",
}
m["atx"] = {
 "Arutani",
 56609,
 nil,
 "Latn",
}
m["aty"] = {
 "Aneityum",
 2379113,
 "poz-oce",
 "Latn",
}
m["atz"] = {
 "Arta",
 3508067,
 "phi",
 "Latn",
}
m["aua"] = {
 "Asumboa",
 4811870,
 "poz-oce",
 "Latn",
}
m["aub"] = {
 "Alugu",
 12626798,
 "tbq-lol",
 "Latn", -- also Hani?
}
m["auc"] = {
 "Huaorani",
 758570,
 "qfa-iso",
 "Latn",
}
m["aud"] = {
 "Anuta",
 35326,
 "poz-pnp",
 "Latn",
}
m["aug"] = {
 "Aguna",
 34733,
 "alv-gbe",
 "Latn",
}
m["auh"] = {
 "Aushi",
 2872082,
 "bnt-sbi",
 "Latn",
}
m["aui"] = {
 "Anuki",
 3508132,
 "poz-ocw",
 "Latn",
}
m["auj"] = {
 "Awjila",
 56398,
 "ber",
 "Latn, Arab, Tfng",
}
m["auk"] = {
 "Heyo",
 3504295,
 "qfa-tor",
 "Latn",
}
m["aul"] = {
 "Aulua",
 427300,
 "poz-vnc",
 "Latn",
}
m["aum"] = {
 "Asu",
 34798,
 "alv-ngb",
 "Latn",
}
m["aun"] = {
 "Molmo One",
 12637224,
 "qfa-tor",
 "Latn",
}
m["auo"] = {
 "Auyokawa",
 56247,
 "cdc-wst",
 "Latn",
}
m["aup"] = {
 "Makayam",
 6738863,
 "ngf",
 "Latn",
}
m["auq"] = {
 "Anus",
 23855,
 "poz-ocw",
 "Latn",
}
m["aur"] = {
 "Aruek",
 3504279,
 "qfa-tor",
 "Latn",
}
m["aut"] = {
 "Austral",
 2669261,
 "poz-pep",
 "Latn",
}
m["auu"] = {
 "Auye",
 4827334,
 "ngf",
 "Latn",
}
m["auw"] = {
 "Awyi",
 3513326,
 "paa-brd",
 "Latn",
}
m["aux"] = {
 "Aurá",
 3507995,
 "tup-gua",
 "Latn",
}
m["auy"] = {
 "Auyana",
 2873211,
 "paa-kag",
 "Latn",
}
m["auz"] = {
 "Uzbeki Arabic",
 3399507,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["avb"] = {
 "Avau",
 12627412,
 "poz-ocw",
 "Latn",
}
m["avd"] = {
 "Alviri-Vidari",
 3327357,
 "xme",
 "fa-Arab",
 ancestors = "xme-mid",
}
m["avi"] = {
 "Avikam",
 34840,
 "alv-lag",
 "Latn",
}
m["avk"] = {
 "Kotava",
 1377116,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["avm"] = {
 "Angkamuthi",
 nil,
 "aus-pmn",
 "Latn",
}
m["avn"] = {
 "Avatime",
 34796,
 "alv-ktg",
 "Latn",
}
m["avo"] = {
 "Agavotaguerra",
 3508007,
 "awd",
 "Latn",
}
m["avs"] = {
 "Aushiri",
 3409318,
 "sai-zap",
 "Latn",
}
m["avt"] = {
 "Au",
 3446608,
 "qfa-tor",
 "Latn",
}
m["avu"] = {
 "Avokaya",
 56685,
 "csu-mma",
 "Latn",
}
m["avv"] = {
 "Avá-Canoeiro",
 4829584,
 "tup-gua",
 "Latn",
}
m["awa"] = {
 "Awadhi",
 29579,
 "inc-hie",
 "Deva, Kthi, fa-Arab",
 ancestors = "inc-pra",
 translit = {Deva = "hi-translit"},
}
m["awb"] = {
 "Awa (New Guinea)",
 2874650,
 "paa-kag",
 "Latn",
}
m["awc"] = {
 "Cicipu",
 35193,
 "nic-kam",
 "Latn",
}
m["awe"] = {
 "Awetí",
 4830038,
 "tup",
 "Latn",
}
m["awg"] = {
 "Anguthimri",
 4764288,
 "aus-pam",
 "Latn",
}
m["awh"] = {
 "Awbono",
 3446684,
 "ngf",
 "Latn",
}
m["awi"] = {
 "Aekyom",
 3399691,
 "ngf",
 "Latn",
}
m["awk"] = {
 "Awabakal",
 3449138,
 "aus-pam",
 "Latn",
}
m["awm"] = {
 "Arawum",
 4784537,
 "ngf-mad",
 "Latn",
}
m["awn"] = {
 "Awngi",
 34934,
 "cus-cen",
 "Ethi",
}
m["awo"] = {
 "Awak",
 3446643,
 "alv-wjk",
 "Latn",
}
m["awr"] = {
 "Awera",
 56379,
 "paa-lkp",
 "Latn",
}
m["aws"] = {
 "South Awyu",
 12633986,
 "ngf",
 "Latn",
}
m["awt"] = {
 "Araweté",
 4784535,
 "tup-gua",
 "Latn",
}
m["awu"] = {
 "Central Awyu",
 12628801,
 "ngf",
 "Latn",
}
m["awv"] = {
 "Jair Awyu",
 16110177,
 "ngf",
 "Latn",
}
m["aww"] = {
 "Awun",
 56369,
 "paa-spk",
 "Latn",
}
m["awx"] = {
 "Awara",
 2874670,
 "ngf-fin",
 "Latn",
}
m["awy"] = {
 "Edera Awyu",
 12630425,
 "ngf",
 "Latn",
}
m["axb"] = {
 "Abipon",
 11252539,
 "sai-guc",
 "Latn",
}
m["axe"] = {
 "Ayerrerenge",
 16112737,
 "aus-pam",
 "Latn",
}
m["axg"] = {
 "Mato Grosso Arára",
 3446660,
 nil,
 "Latn",
}
m["axk"] = {
 "Aka (Central Africa)",
 11010149,
 "bnt-ngn",
 "Latn",
}
m["axl"] = {
 "Lower Southern Aranda",
 6693295,
 "aus-pam",
 "Latn",
}
m["axm"] = {
 "Middle Armenian",
 4438498,
 "hyx",
 "Armn",
 ancestors = "xcl",
 translit = "Armn-translit",
 override_translit = true,
 entry_name = {
  remove_diacritics = "՞՜՛՟",
  from = {"եւ"},
  to = {"և"}
 }
}
m["axx"] = {
 "Xaragure",
 8045635,
 "poz-cln",
 "Latn",
}
m["aya"] = {
 "Awar",
 56876,
 "paa",
 "Latn",
}
m["ayb"] = {
 "Ayizo",
 34841,
 "alv-pph",
 "Latn",
}
m["ayd"] = {
 "Ayabadhu",
 3509164,
 "aus-pmn",
 "Latn",
}
m["aye"] = {
 "Ayere",
 34788,
 "alv-aah",
 "Latn",
}
m["ayg"] = {
 "Nyanga (Togo)",
 35446,
 "alv-gng",
 "Latn",
}
m["ayi"] = {
 "Leyigha",
 3914492,
 "nic-uce",
 "Latn",
}
m["ayk"] = {
 "Akuku",
 3450179,
 "alv-nwd",
 "Latn",
}
m["ayl"] = {
 "Libyan Arabic",
 56503,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["ayn"] = {
 "Yemeni Arabic",
 1686766,
 "sem-arb",
 "Arab",
 entry_name = "ar-entryname",
}
m["ayo"] = {
 "Ayoreo",
 56634,
 "sai-zam",
 "Latn",
}
m["ayp"] = {
 "North Mesopotamian Arabic",
 56577,
 "sem-arb",
 "Arab",
 ancestors = "acm",
 entry_name = "ar-entryname",
}
m["ayq"] = {
 "Ayi",
 56449,
 "paa-spk",
 "Latn",
}
m["ays"] = {
 "Sorsogon Ayta",
 7563752,
 "phi",
 "Latn",
}
m["ayt"] = {
 "Bataan Ayta",
 4921648,
 "phi",
 "Latn",
}
m["ayu"] = {
 "Ayu",
 34786,
 "alv",
 "Latn",
}
m["ayy"] = {
 "Tayabas Ayta",
 7689745,
 "phi",
 "Latn",
}
m["ayz"] = {
 "Maybrat",
 4830892,
 "paa-wpa",
 "Latn",
}
m["aza"] = {
 "Azha",
 4832486,
 "tbq-lol",
 "Latn",
}
m["azd"] = {
 "Eastern Durango Nahuatl",
 16115449,
 "azc-nah",
 "Latn",
}
m["azg"] = {
 "San Pedro Amuzgos Amuzgo",
 35092,
 "omq",
 "Latn",
}
m["azm"] = {
 "Ipalapa Amuzgo",
 12633013,
 "omq",
 "Latn",
}
m["azn"] = {
 "Western Durango Nahuatl",
 12645553,
 "azc-nah",
 "Latn",
}
m["azo"] = {
 "Awing",
 34856,
 "nic-nge",
 "Latn",
}
m["azt"] = {
 "Faire Atta",
 12630884,
 "phi",
 "Latn",
}
m["azz"] = {
 "Highland Puebla Nahuatl",
 12953754,
 "azc-nah",
 "Latn",
}
m["baa"] = {
 "Babatana",
 2877785,
 "poz-ocw",
 "Latn",
}
m["bab"] = {
 "Bainouk-Gunyuño",
 35508,
 "alv-bny",
 "Latn",
}
m["bac"] = {
 "Badui",
 3449885,
 "poz-msa",
 "Latn",
}
m["bae"] = {
 "Baré",
 3504087,
 "awd",
 "Latn",
}
m["baf"] = {
 "Nubaca",
 36270,
 "nic-ymb",
 "Latn",
}
m["bag"] = {
 "Tuki",
 36621,
 "nic-mba",
 "Latn",
}
m["bah"] = {
 "Bahamian Creole",
 2669229,
 "crp",
 "Latn",
 ancestors = "en",
}
m["baj"] = {
 "Barakai",
 3502030,
 "poz-cet",
 "Latn",
}
m["bal"] = {
 "Baluchi",
 33049,
 "ira-nwi",
 "fa-Arab",
}
m["ban"] = {
 "Balinese",
 33070,
 "poz-mcm",
 "Latn, Bali",
}
m["bao"] = {
 "Waimaha",
 2883738,
 "sai-tuc",
 "Latn",
}
m["bap"] = {
 "Bantawa",
 56500,
 "sit-kic",
 "Deva",
}
m["bar"] = {
 "Bavarian",
 29540,
 "gmw",
 "Latn",
 ancestors = "gmh",
}
m["bas"] = {
 "Basaa",
 33093,
 "bnt-bsa",
 "Latn",
}
m["bau"] = {
 "Badanchi",
 11001650,
 "nic-jrw",
 "Latn",
}
m["bav"] = {
 "Babungo",
 34885,
 "nic-rnn",
 "Latn",
}
m["baw"] = {
 "Bambili-Bambui",
 34880,
 "nic-nge",
 "Latn",
}
m["bax"] = {
 "Bamum",
 35280,
 "nic-nun",
 "Latn, Bamu",
}
m["bay"] = {
 "Batuley",
 8828787,
 "poz",
 "Latn",
}
m["bba"] = {
 "Baatonum",
 34889,
 "alv-sav",
 "Latn",
}
m["bbb"] = {
 "Barai",
 4858206,
 "ngf",
 "Latn",
}
m["bbc"] = {
 "Toba Batak",
 33017,
 "btk",
 "Latn, Batk",
}
m["bbd"] = {
 "Bau",
 4873415,
 "ngf-mad",
 "Latn",
}
m["bbe"] = {
 "Bangba",
 34895,
 "nic-nke",
 "Latn",
}
m["bbf"] = {
 "Baibai",
 56902,
 "paa",
 "Latn",
}
m["bbg"] = {
 "Barama",
 34884,
 "bnt-sir",
 "Latn",
}
m["bbh"] = {
 "Bugan",
 3033554,
 "mkh-pkn",
 "Latn",
}
m["bbi"] = {
 "Barombi",
 34985,
 "bnt-bsa",
 "Latn",
}
m["bbj"] = {
 "Ghomala'",
 35271,
 "bai",
 "Latn",
}
m["bbk"] = {
 "Babanki",
 34790,
 "nic-rnc",
 "Latn",
}
m["bbl"] = {
 "Bats",
 33259,
 "cau-nkh",
 "Geor",
 translit = "Geor-translit",
 override_translit = true,
 entry_name = {
  remove_diacritics = c.tilde .. c.macron .. c.breve,
  from = {"<sup>ნ</sup>"},
  to = {"ნ"}
 },
}
m["bbm"] = { -- name includes prefix
 "Babango",
 34819,
 "bnt-bta",
 "Latn",
}
m["bbn"] = {
 "Uneapa",
 7884126,
 "poz-ocw",
 "Latn",
}
m["bbo"] = {
 "Konabéré",
 35371,
 "dmn-snb",
 "Latn",
}
m["bbp"] = {
 "West Central Banda",
 7984377,
 "bad",
 "Latn",
}
m["bbq"] = {
 "Bamali",
 34901,
 "nic-nun",
 "Latn",
}
m["bbr"] = {
 "Girawa",
 5564185,
 "ngf-mad",
 "Latn",
}
m["bbs"] = {
 "Bakpinka",
 3515061,
 "nic-ucr",
 "Latn",
}
m["bbt"] = {
 "Mburku",
 3441324,
 "cdc-wst",
 "Latn",
}
m["bbu"] = {
 "Bakulung",
 35580,
 "nic-jrn",
 "Latn",
}
m["bbv"] = {
 "Karnai",
 6372803,
 "poz-ocw",
 "Latn",
}
m["bbw"] = {
 "Baba",
 34822,
 "nic-nun",
 "Latn",
}
m["bbx"] = { -- cf bvb
 "Bubia",
 34953,
 "nic-bds",
 "Latn",
 ancestors = "bvb",
}
m["bby"] = {
 "Befang",
 34960,
 "nic-bds",
 "Latn",
}
m["bca"] = {
 "Central Bai",
 12628803,
 "zhx-gba",
 "Hani, Latn",
 sort_key = {Hani = "Hani-sortkey"},
}
m["bcb"] = {
 "Bainouk-Samik",
 36390,
 "alv-bny",
 "Latn",
}
m["bcd"] = {
 "North Babar",
 7054041,
 "poz-tim",
 "Latn",
}
m["bce"] = {
 "Bamenyam",
 34968,
 "nic-nun",
 "Latn",
}
m["bcf"] = {
 "Bamu",
 3503788,
 "paa-kiw",
 "Latn",
}
m["bcg"] = {
 "Baga Pokur",
 31172660,
 "alv-nal",
 "Latn",
}
m["bch"] = {
 "Bariai",
 2884502,
 "poz-ocw",
 "Latn",
}
m["bci"] = {
 "Baoule",
 35107,
 "alv-ctn",
 "Latn",
}
m["bcj"] = {
 "Bardi",
 3913852,
 "aus-nyu",
 "Latn",
}
m["bck"] = {
 "Bunaba",
 580923,
 "aus-bub",
 "Latn",
}
m["bcl"] = {
 "Bikol Central",
 33284,
 "phi",
 "Latn",
}
m["bcm"] = {
 "Banoni",
 2882857,
 "poz-ocw",
 "Latn",
}
m["bcn"] = {
 "Bibaali",
 34892,
 "alv-mye",
 "Latn",
}
m["bco"] = {
 "Kaluli",
 6354586,
 "ngf",
 "Latn",
}
m["bcp"] = {
 "Bali",
 3515074,
 "bnt-kbi",
 "Latn",
}
m["bcq"] = {
 "Bench",
 35108,
 "omv",
 "Latn",
}
m["bcr"] = {
 "Babine-Witsuwit'en",
 27864,
 "ath-nor",
 "Latn",
}
m["bcs"] = {
 "Kohumono",
 35590,
 "nic-ucn",
 "Latn",
}
m["bct"] = {
 "Bendi",
 8836662,
 "csu-mle",
 "Latn",
}
m["bcu"] = {
 "Biliau",
 2874658,
 "poz-ocw",
 "Latn",
}
m["bcv"] = {
 "Shoo-Minda-Nye",
 36548,
 "nic-jkn",
 "Latn",
}
m["bcw"] = {
 "Bana",
 56272,
 "cdc-cbm",
 "Latn",
}
m["bcy"] = {
 "Bacama",
 56274,
 "cdc-cbm",
 "Latn",
}
m["bcz"] = {
 "Bainouk-Gunyaamolo",
 35506,
 "alv-bny",
 "Latn",
}
m["bda"] = {
 "Bayot",
 35019,
 "alv-jol",
 "Latn",
}
m["bdb"] = {
 "Basap",
 3504208,
 "poz-bnn",
 "Latn",
}
m["bdc"] = {
 "Emberá-Baudó",
 11173166,
 "sai-chc",
 "Latn",
}
m["bdd"] = {
 "Bunama",
 4997416,
 "poz-ocw",
 "Latn",
}
m["bde"] = {
 "Bade",
 56239,
 "cdc-wst",
 "Latn",
}
m["bdf"] = {
 "Biage",
 48037487,
 "ngf",
 "Latn",
}
m["bdg"] = {
 "Bonggi",
 2910053,
 "poz-bnn",
 "Latn",
}
m["bdh"] = {
 "Tara Baka",
 2880165,
 "csu-bbk",
 "Latn",
}
m["bdi"] = {
 "Burun",
 35040,
 "sdv-niw",
 "Latn",
}
m["bdj"] = {
 "Bai",
 34894,
 "nic-ser",
 "Latn",
}
m["bdk"] = {
 "Budukh",
 35397,
 "cau-ssm",
 "Cyrl",
 translit = "cau-nec-translit",
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
}
m["bdl"] = {
 "Indonesian Bajau",
 2880038,
 "poz",
 "Latn",
}
m["bdm"] = {
 "Buduma",
 56287,
 "cdc-cbm",
 "Latn",
}
m["bdn"] = {
 "Baldemu",
 56280,
 "cdc-cbm",
 "Latn",
}
m["bdo"] = {
 "Morom",
 759770,
 "csu-bgr",
 "Latn",
}
m["bdp"] = {
 "Bende",
 8836490,
 "bnt",
 "Latn",
}
m["bdq"] = {
 "Bahnar",
 32924,
 "mkh-ban",
 "Latn",
}
m["bdr"] = {
 "West Coast Bajau",
 2880037,
 "poz-sbj",
 "Latn",
}
m["bds"] = {
 "Burunge",
 56617,
 "cus-sou",
 "Latn",
}
m["bdt"] = {
 "Bokoto",
 4938812,
 "alv-gbw",
 "Latn",
}
m["bdu"] = {
 "Oroko",
 36278,
 "bnt-saw",
 "Latn",
}
m["bdv"] = {
 "Bodo Parja",
 8845881,
 "inc-eas",
 "Orya",
 ancestors = "pra-mag",
}
m["bdw"] = {
 "Baham",
 3513309,
 "paa",
 "Latn",
}
m["bdx"] = {
 "Budong-Budong",
 4985158,
 "poz-ssw",
 "Latn",
}
m["bdy"] = {
 "Bandjalang",
 2980386,
 "aus-pam",
 "Latn",
}
m["bdz"] = {
 "Badeshi",
 33028,
 "inc-wes",
 ancestors = "noe",
}
m["bea"] = {
 "Beaver",
 20826,
 "ath-nor",
 "Latn",
}
m["beb"] = {
 "Bebele",
 34976,
 "bnt-btb",
 "Latn",
}
m["bec"] = {
 "Iceve-Maci",
 35449,
 "nic-tvc",
 "Latn",
}
m["bed"] = {
 "Bedoanas",
 4879330,
 "poz-hce",
 "Latn",
}
m["bee"] = {
 "Byangsi",
 56904,
 "sit-alm",
 "Deva",
}
m["bef"] = {
 "Benabena",
 2895638,
 "paa-kag",
 "Latn",
}
m["beg"] = {
 "Belait",
 2894198,
 "poz-swa",
 "Latn",
}
m["beh"] = {
 "Biali",
 34961,
 "nic-eov",
 "Latn",
}
m["bei"] = {
 "Bekati'",
 3441683,
 "day",
 "Latn",
}
m["bej"] = {
 "Beja",
 33025,
 "cus",
 "Arab, Latn",
}
m["bek"] = {
 "Bebeli",
 4878430,
 "poz-ocw",
 "Latn",
}
m["bem"] = {
 "Bemba",
 33052,
 "bnt-sbi",
 "Latn",
}
m["beo"] = {
 "Beami",
 3504079,
 "paa",
 "Latn",
}
m["bep"] = {
 "Besoa",
 8840465,
 "poz-kal",
 "Latn",
}
m["beq"] = {
 "Beembe",
 3196320,
 "bnt-kng",
 "Latn",
}
m["bes"] = {
 "Besme",
 289832,
 "alv-kim",
 "Latn",
}
m["bet"] = {
 "Guiberoua Bété",
 11019185,
 "kro-bet",
 "Latn",
}
m["beu"] = {
 "Blagar",
 4923846,
 "ngf",
 "Latn",
}
m["bev"] = {
 "Daloa Bété",
 11155819,
 "kro-bet",
 "Latn",
}
m["bew"] = {
 "Betawi",
 33014,
 "crp",
 "Latn",
 ancestors = "ms",
}
m["bex"] = {
 "Jur Modo",
 56682,
 "csu-bbk",
 "Latn",
}
m["bey"] = {
 "Akuwagel",
 3504170,
 "qfa-tor",
 "Latn",
}
m["bez"] = {
 "Kibena",
 2502949,
 "bnt-bki",
 "Latn",
}
m["bfa"] = {
 "Bari",
 35042,
 "sdv-bri",
 "Latn",
}
m["bfb"] = {
 "Pauri Bareli",
 7155462,
 "inc-bhi",
 "Deva",
}
m["bfc"] = {
 "Northern Bai",
 12642165,
 "zhx-gba",
 "Hani, Latn",
 sort_key = {Hani = "Hani-sortkey"},
}
m["bfd"] = {
 "Bafut",
 34888,
 "nic-nge",
 "Latn",
}
m["bfe"] = {
 "Betaf",
 4897329,
 "paa-tkw",
 "Latn",
}
m["bff"] = {
 "Bofi",
 34914,
 "alv-gbf",
 "Latn",
}
m["bfg"] = {
 "Busang Kayan",
 9231909,
 "poz",
 "Latn",
}
m["bfh"] = {
 "Blafe",
 12628007,
 "paa",
 "Latn",
}
m["bfi"] = {
 "British Sign Language",
 33000,
 "sgn",
 "Latn", -- when documented
}
m["bfj"] = {
 "Bafanji",
 34890,
 "nic-nun",
 "Latn",
}
m["bfk"] = {
 "Ban Khor Sign Language",
 3441103,
 "sgn",
}
m["bfl"] = {
 "Banda-Ndélé",
 34850,
 "bad-cnt",
 "Latn",
}
m["bfm"] = {
 "Mmen",
 36132,
 "nic-rnc",
 "Latn",
}
m["bfn"] = {
 "Bunak",
 35101,
 "ngf",
 "Latn",
}
m["bfo"] = {
 "Malba Birifor",
 11150710,
 "nic-mre",
 "Latn",
}
m["bfp"] = {
 "Beba",
 35050,
 "nic-nge",
 "Latn",
}
m["bfq"] = {
 "Badaga",
 33205,
 "dra",
 "Knda",
 translit = "kn-translit",
}
m["bfr"] = {
 "Bazigar",
 8829558,
 "dra",
}
m["bfs"] = {
 "Southern Bai",
 12952250,
 "zhx-gba",
 "Hani, Latn",
 sort_key = {Hani = "Hani-sortkey"},
}
m["bft"] = {
 "Balti",
 33086,
 "sit-lab",
 "fa-Arab, Deva, Tibt",
 translit = {
  Tibt = "Tibt-translit",
 },
 override_translit = true,
 display_text = {Tibt = s["Tibt-displaytext"]},
 entry_name = {Tibt = s["Tibt-entryname"]},
 sort_key = {Tibt = "Tibt-sortkey"},
}
m["bfu"] = {
 "Gahri",
 5516952,
 "sit-whm",
 "Takr, Tibt",
 translit = {Tibt = "Tibt-translit"},
 override_translit = true,
 display_text = {Tibt = s["Tibt-displaytext"]},
 entry_name = {Tibt = s["Tibt-entryname"]},
 sort_key = {Tibt = "Tibt-sortkey"},
}
m["bfw"] = {
 "Bondo",
 2567942,
 "mun",
 "Orya",
}
m["bfx"] = {
 "Bantayanon",
 16837866,
 "phi",
 "Latn",
}
m["bfy"] = {
 "Bagheli",
 2356364,
 "inc-hie",
 "Deva",
 ancestors = "inc-pra",
 translit = "hi-translit",
}
m["bfz"] = {
 "Mahasu Pahari",
 6733460,
 "him",
 "Deva",
 translit = "hi-translit",
}
m["bga"] = {
 "Gwamhi-Wuri",
 6707102,
 "nic-knn",
 "Latn",
}
m["bgb"] = {
 "Bobongko",
 4935896,
 "poz-slb",
 "Latn",
}
m["bgc"] = {
 "Haryanvi",
 33410,
 "inc-cen",
 "Deva",
 ancestors = "inc-ohi",
 translit = "hi-translit",
}
m["bgd"] = {
 "Rathwi Bareli",
 7295692,
 "inc-bhi",
 "Deva",
}
m["bge"] = {
 "Bauria",
 4873579,
 "inc-bhi",
 "Deva",
}
m["bgf"] = {
 "Bangandu",
 34938,
 "alv-gbs",
 "Latn",
}
m["bgg"] = {
 "Bugun",
 3514220,
 "sit-khb",
 "Latn",
}
m["bgi"] = {
 "Giangan",
 4842057,
 "phi",
 "Latn",
}
m["bgj"] = {
 "Bangolan",
 34862,
 "nic-nun",
 "Latn",
}
m["bgk"] = {
 "Bit",
 2904868,
 "mkh-pal",
 "Latn", -- also Hani?
}
m["bgl"] = {
 "Bo",
 8845514,
 "mkh-vie",
}
m["bgo"] = {
 "Baga Koga",
 35695,
 "alv-bag",
 "Latn",
}
m["bgq"] = {
 "Bagri",
 2426319,
 "inc-wes",
 "Deva",
 ancestors = "raj",
}
m["bgr"] = {
 "Bawm Chin",
 56765,
 "tbq-kuk",
 "Latn",
}
m["bgs"] = {
 "Tagabawa",
 7675121,
 "mno",
 "Latn",
}
m["bgt"] = {
 "Bughotu",
 2927723,
 "poz-sls",
 "Latn",
}
m["bgu"] = {
 "Mbongno",
 36141,
 "nic-mmb",
 "Latn",
}
m["bgv"] = {
 "Warkay-Bipim",
 4915439,
 "ngf",
 "Latn",
}
m["bgw"] = {
 "Bhatri",
 8841054,
 "inc-eas",
 "Deva",
 ancestors = "pra-mag",
}
m["bgx"] = {
 "Balkan Gagauz Turkish",
 2360396,
 "trk-ogz",
 "Latn",
 ancestors = "trk-oat",
}
m["bgy"] = {
 "Benggoi",
 4887742,
 "poz-cma",
 "Latn",
}
m["bgz"] = {
 "Banggai",
 3441692,
 "poz-slb",
 "Latn",
}
m["bha"] = {
 "Bharia",
 4901287,
 "dra",
 "Deva",
}
m["bhb"] = {
 "Bhili",
 33229,
 "inc-bhi",
 "Deva",
}
m["bhc"] = {
 "Biga",
 2902375,
 "poz-hce",
 "Latn",
}
m["bhd"] = {
 "Bhadrawahi",
 4900565,
 "him",
 "Arab, Deva",
 translit = {Deva = "hi-translit"},
}
m["bhe"] = {
 "Bhaya",
 8841168,
 "inc-wes",
 ancestors = "raj",
}
m["bhf"] = {
 "Odiai",
 56690,
 "paa-kwm",
 "Latn",
}
m["bhg"] = {
 "Binandere",
 3503802,
 "ngf",
 "Latn",
}
m["bhh"] = {
 "Bukhari",
 56469,
 "ira-swi",
 "Cyrl, Hebr, Latn, fa-Arab",
 ancestors = "tg",
}
m["bhi"] = {
 "Bhilali",
 4901729,
 "inc-bhi",
 "Deva",
}
m["bhj"] = {
 "Bahing",
 56442,
 "sit-kiw",
 "Deva, Latn",
}
m["bhl"] = {
 "Bimin",
 4913743,
 "ngf-okk",
 "Latn",
}
m["bhm"] = {
 "Bathari",
 2586893,
 "sem-sar",
 "Arab, Latn",
}
m["bhn"] = {
 "Bohtan Neo-Aramaic",
 33230,
 "sem-nna",
}
m["bho"] = {
 "Bhojpuri",
 33268,
 "inc-hie",
 "Deva, Kthi",
 ancestors = "bh",
 translit = {
  Deva = "bho-translit",
  Kthi = "bho-Kthi-translit",
 },
}
m["bhp"] = {
 "Bima",
 2796873,
 "poz-cet",
 "Latn",
}
m["bhq"] = {
 "Tukang Besi South",
 12643975,
 "poz-mun",
 "Latn",
}
m["bhs"] = {
 "Buwal",
 3515065,
 "cdc-cbm",
 "Latn",
}
m["bht"] = {
 "Bhattiyali",
 4901452,
 "him",
 "Deva",
}
m["bhu"] = {
 "Bhunjia",
 8841766,
 "inc-eas",
 "Deva, Orya",
 ancestors = "pra-mag",
}
m["bhv"] = {
 "Bahau",
 3502039,
 "poz",
 "Latn",
}
m["bhw"] = {
 "Biak",
 1961488,
 "poz-hce",
 "Latn",
}
m["bhx"] = { -- spurious?
 "Bhalay",
 8840773,
 "inc",
}
m["bhy"] = {
 "Bhele",
 4901671,
 "bnt-kbi",
 "Latn",
}
m["bhz"] = {
 "Bada",
 4840520,
 "poz-kal",
 "Latn",
}
m["bia"] = {
 "Badimaya",
 3442745,
 "aus-psw",
 "Latn",
}
m["bib"] = {
 "Bissa",
 32934,
 "dmn-bbu",
 "Latn",
}
m["bic"] = {
 "Bikaru",
 56342,
 "paa-eng",
 "Latn",
}
m["bid"] = {
 "Bidiyo",
 56258,
 "cdc-est",
 "Latn",
}
m["bie"] = {
 "Bepour",
 4890914,
 "ngf-mad",
 "Latn",
}
m["bif"] = {
 "Biafada",
 35099,
 "alv-ten",
 "Latn",
}
m["big"] = {
 "Biangai",
 8842027,
 "paa",
 "Latn",
}
m["bij"] = {
 "Kwanka",
 35598,
 "nic-tar",
 "Latn",
}
m["bil"] = {
 "Bile",
 34987,
 "nic-jrn",
 "Latn",
}
m["bim"] = {
 "Bimoba",
 34971,
 "nic-grm",
 "Latn",
}
m["bin"] = {
 "Edo",
 35375,
 "alv-eeo",
 "Latn",
 entry_name = {remove_diacritics = c.acute .. c.grave .. c.macron .. c.dgrave},
 sort_key = {
  from = {"ẹ", "gb", "gh", "kh", "kp", "mw", "nw", "ny", "ọ", "rh", "rr", "vb"},
  to = {"e" .. p[1], "g" .. p[1], "g" .. p[2], "k" .. p[1], "k" .. p[2], "m" .. p[1], "n" .. p[1], "n" .. p[2], "o" .. p[1], "r" .. p[1], "r" .. p[1], "v" .. p[1]}
 },
}
m["bio"] = {
 "Nai",
 3508074,
 "paa-kwm",
 "Latn",
}
m["bip"] = {
 "Bila",
 2902626,
 "bnt-kbi",
 "Latn",
}
m["biq"] = {
 "Bipi",
 2904312,
 "poz-aay",
 "Latn",
}
m["bir"] = {
 "Bisorio",
 8844749,
 "paa-eng",
 "Latn",
}
m["bit"] = {
 "Berinomo",
 56447,
 "paa-spk",
 "Latn",
}
m["biu"] = {
 "Biete",
 4904687,
 "tbq-kuk",
 "Latn",
}
m["biv"] = {
 "Southern Birifor",
 32859745,
 "nic-mre",
 "Latn",
}
m["biw"] = {
 "Kol (Cameroon)",
 35582,
 "bnt-mka",
 "Latn",
}
m["bix"] = {
 "Bijori",
 3450686,
 "mun",
 "Deva",
}
m["biy"] = {
 "Birhor",
 3450469,
 "mun",
 "Deva",
}
m["biz"] = {
 "Baloi",
 3450590,
 "bnt-ngn",
 "Latn",
}
m["bja"] = {
 "Budza",
 3046889,
 "bnt-bun",
 "Latn",
}
m["bjb"] = {
 "Barngarla",
 3439071,
 "aus-pam",
 "Latn",
}
m["bjc"] = {
 "Bariji",
 4690919,
 "ngf",
 "Latn",
}
m["bje"] = {
 "Biao-Jiao Mien",
 3503800,
 "hmx-mie",
 "Hani, Latn",
 sort_key = {Hani = "Hani-sortkey"},
}
m["bjf"] = {
 "Barzani Jewish Neo-Aramaic",
 33234,
 "sem-nna",
 "Hebr", -- maybe others
}
m["bjg"] = {
 "Bidyogo",
 35365,
 "alv-bak",
 "Latn",
}
m["bjh"] = {
 "Bahinemo",
 56361,
 "paa-spk",
 "Latn",
}
m["bji"] = {
 "Burji",
 34999,
 "cus-hec",
 "Latn, Ethi",
}
m["bjj"] = {
 "Kannauji",
 2726867,
 "inc-cen",
 "Deva",
 ancestors = "inc-ohi",
}
m["bjk"] = {
 "Barok",
 2884743,
 "poz-ocw",
 "Latn",
}
m["bjl"] = {
 "Bulu (New Guinea)",
 4997162,
 "poz-ocw",
 "Latn",
}
m["bjm"] = {
 "Bajelani",
 4848866,
 "ira-zgr",
 "Latn, Arab",
 ancestors = "hac",
}
m["bjn"] = {
 "Banjarese",
 33151,
 "poz-mly",
 "Latn, Arab",
}
m["bjo"] = {
 "Mid-Southern Banda",
 42303990,
 "bad-cnt",
 "Latn",
}
m["bjp"] = {
 "Fanamaket",
 nil,
 "poz-oce",
 "Latn",
}
m["bjr"] = {
 "Binumarien",
 538364,
 "paa-kag",
 "Latn",
}
m["bjs"] = {
 "Bajan",
 2524014,
 "crp",
 "Latn",
 ancestors = "en",
}
m["bjt"] = {
 "Balanta-Ganja",
 19359034,
 "alv-bak",
 "Arab, Latn",
}
m["bju"] = {
 "Busuu",
 35046,
 "nic-fru",
 "Latn",
}
m["bjv"] = {
 "Bedjond",
 8829831,
 "csu-sar",
 "Latn",
}
m["bjw"] = {
 "Bakwé",
 34899,
 "kro-ekr",
 "Latn",
}
m["bjx"] = {
 "Banao Itneg",
 12627559,
 "phi",
 "Latn",
}
m["bjy"] = {
 "Bayali",
 4874263,
 "aus-pam",
 "Latn",
}
m["bjz"] = {
 "Baruga",
 2886189,
 "ngf",
 "Latn",
}
m["bka"] = {
 "Kyak",
 35653,
 "alv-bwj",
 "Latn",
}
m["bkc"] = {
 "Baka",
 34905,
 "nic-nkb",
 "Latn",
}
m["bkd"] = {
 "Binukid",
 4914553,
 "mno",
 "Latn",
}
m["bkf"] = {
 "Beeke",
 3441375,
 "bnt-kbi",
 "Latn",
}
m["bkg"] = {
 "Buraka",
 35066,
 "nic-nkg",
 "Latn",
}
m["bkh"] = {
 "Bakoko",
 34866,
 "bnt-bsa",
 "Latn",
}
m["bki"] = {
 "Baki",
 11024697,
 "poz-vnc",
 "Latn",
}
m["bkj"] = {
 "Pande",
 36263,
 "bnt-ngn",
 "Latn",
}
m["bkk"] = { -- written in Balti script
 "Brokskat",
 2925988,
 "inc-dar",
}
m["bkl"] = {
 "Berik",
 378743,
 "paa-tkw",
 "Latn",
}
m["bkm"] = {
 "Kom (Cameroon)",
 1656595,
 "nic-rnc",
 "Latn",
}
m["bkn"] = {
 "Bukitan",
 3446774,
 "poz-bnn",
 "Latn",
}
m["bko"] = {
 "Kwa'",
 35567,
 "bai",
 "Latn",
}
m["bkp"] = {
 "Iboko",
 35089,
 "bnt-ngn",
 "Latn",
}
m["bkq"] = {
 "Bakairí",
 56846,
 "sai-pek",
 "Latn",
}
m["bkr"] = {
 "Bakumpai",
 3436626,
 "poz-brw",
 "Latn",
}
m["bks"] = {
 "Masbate Sorsogon",
 16113356,
 "phi",
 "Latn",
}
m["bkt"] = {
 "Boloki",
 4144560,
 "bnt-zbi",
 "Latn",
 ancestors = "lse",
}
m["bku"] = {
 "Buhid",
 1002956,
 "phi",
 "Buhd",
}
m["bkv"] = {
 "Bekwarra",
 34954,
 "nic-ben",
 "Latn",
}
m["bkw"] = {
 "Bekwel",
 34950,
 "bnt-bek",
 "Latn",
}
m["bkx"] = {
 "Baikeno",
 11200640,
 "poz-tim",
 "Latn",
}
m["bky"] = {
 "Bokyi",
 35087,
 "nic-ben",
 "Latn",
}
m["bkz"] = {
 "Bungku",
 2928207,
 "poz-btk",
 "Latn",
}
m["bla"] = {
 "Blackfoot",
 33060,
 "alg",
 "Latn, Cans",
}
m["blb"] = {
 "Bilua",
 35003,
 "ngf",
 "Latn",
}
m["blc"] = {
 "Bella Coola",
 977808,
 "sal",
 "Latn",
}
m["bld"] = {
 "Bolango",
 3450578,
 "phi",
 "Latn",
}
m["ble"] = {
 "Balanta-Kentohe",
 56789,
 "alv-bak",
 "Latn",
}
m["blf"] = {
 "Buol",
 2928278,
 "phi",
 "Latn",
}
m["blg"] = {
 "Balau",
 4850134,
 "poz-mly",
 "Latn",
}
m["blh"] = {
 "Kuwaa",
 35579,
 "kro",
 "Latn",
}
m["bli"] = {
 "Bolia",
 34910,
 "bnt-mon",
 "Latn",
}
m["blj"] = {
 "Bolongan",
 9229310,
 "poz",
 "Latn",
}
m["blk"] = {
 "Pa'o Karen",
 7121294,
 "kar",
 "Mymr",
}
m["bll"] = {
 "Biloxi",
 2903780,
 "sio-ohv",
 "Latn",
}
m["blm"] = {
 "Beli",
 56821,
 "csu-bbk",
 "Latn",
}
m["bln"] = {
 "Southern Catanduanes Bicolano",
 7569754,
 "phi",
 "Latn",
}
m["blo"] = {
 "Anii",
 34838,
 "alv-ntg",
 "Latn",
}
m["blp"] = {
 "Blablanga",
 2905245,
 "poz-ocw",
 "Latn",
}
m["blq"] = {
 "Baluan-Pam",
 2881675,
 "poz-aay",
 "Latn",
}
m["blr"] = {
 "Blang",
 4925096,
 "mkh-pal",
 "Latn, Tale, Lana, Thai",
 sort_key = { -- FIXME: This needs to be converted into the current standardized format.
  from = {"[%pᪧๆ]", "[᩠ᩳ-᩿]", "ᩔ", "ᩕ", "ᩖ", "ᩘ", "([ᨭ-ᨱ])ᩛ", "([ᨷ-ᨾ])ᩛ", "ᩤ", "[็-๎]", "([เแโใไ])([ก-ฮ])"},
  to = {"", "", "ᩈᩈ", "ᩁ", "ᩃ", "ᨦ", "%1ᨮ", "%1ᨻ", "ᩣ", "", "%2%1"}
 },
}
m["bls"] = {
 "Balaesang",
 4849796,
 "poz",
 "Latn",
}
m["blt"] = {
 "Tai Dam",
 56407,
 "tai-swe",
 "Tavt, Latn",
 --translit = "Tavt-translit",
 sort_key = {
  Tavt = {
   from = {"[꪿ꫀ꫁ꫂ]", "([ꪵꪶꪹꪻꪼ])([ꪀ-ꪯ])"},
   to = {"", "%2%1"}
  },
 },
}
m["blv"] = {
 "Kibala",
 4939959,
 "bnt-kmb",
 "Latn",
}
m["blw"] = {
 "Balangao",
 4850033,
 "phi",
 "Latn",
}
m["blx"] = {
 "Mag-Indi Ayta",
 1931221,
 "phi",
 "Latn",
}
m["bly"] = {
 "Notre",
 11009194,
 "nic-wov",
 "Latn",
}
m["blz"] = {
 "Balantak",
 4850053,
 "poz-slb",
 "Latn",
}
m["bma"] = {
 "Lame",
 3913997,
 "nic-jrn",
 "Latn",
}
m["bmb"] = {
 "Bembe",
 4885023,
 "bnt-lgb",
 "Latn",
}
m["bmc"] = {
 "Biem",
 4904523,
 "poz-ocw",
 "Latn",
}
m["bmd"] = {
 "Baga Manduri",
 35815,
 "alv-bag",
 "Latn",
}
m["bme"] = {
 "Limassa",
 11004666,
 "nic-nkb",
 "Latn",
}
m["bmf"] = {
 "Bom",
 35088,
 "alv-mel",
 "Latn",
}
m["bmg"] = {
 "Bamwe",
 34867,
 "bnt-bun",
 "Latn",
}
m["bmh"] = {
 "Kein",
 6383764,
 "ngf-mad",
 "Latn",
}
m["bmi"] = {
 "Bagirmi",
 34903,
 "csu-bgr",
 "Latn",
}
m["bmj"] = {
 "Bote-Majhi",
 9229570,
 "inc-eas",
 "Deva",
 ancestors = "bh",
}
m["bmk"] = {
 "Ghayavi",
 5555976,
 "poz-ocw",
 "Latn",
}
m["bml"] = {
 "Bomboli",
 35055,
 "bnt-ngn",
 "Latn",
}
m["bmn"] = {
 "Bina",
 8843664,
 "poz-ocw",
 "Latn",
}
m["bmo"] = {
 "Bambalang",
 34868,
 "nic-nun",
 "Latn",
}
m["bmp"] = {
 "Bulgebi",
 4996380,
 "ngf-fin",
 "Latn",
}
m["bmq"] = {
 "Bomu",
 35065,
 "nic-bwa",
 "Latn",
}
m["bmr"] = {
 "Muinane",
 3027894,
 "sai-bor",
 "Latn",
}
m["bmt"] = {
 "Biao Mon",
 8842159,
 "hmx-mie",
}
m["bmu"] = {
 "Somba-Siawari",
 5000983,
 "ngf",
 "Latn",
}
m["bmv"] = {
 "Bum",
 35058,
 "nic-rnc",
 "Latn",
}
m["bmw"] = {
 "Bomwali",
 34984,
 "bnt-ndb",
 "Latn",
}
m["bmx"] = {
 "Baimak",
 3450546,
 "ngf-mad",
 "Latn",
}
m["bmz"] = {
 "Baramu",
 4858315,
 "ngf",
 "Latn",
}
m["bna"] = {
 "Bonerate",
 4941729,
 "poz-mun",
 "Latn",
}
m["bnb"] = {
 "Bookan",
 4943150,
 "poz-san",
 "Latn",
}
m["bnd"] = {
 "Banda",
 3504147,
 "poz-cma",
 "Latn",
}
m["bne"] = {
 "Bintauna",
 4914533,
 "phi",
 "Latn",
}
m["bnf"] = {
 "Masiwang",
 6783305,
 "poz-cma",
 "Latn",
}
m["bng"] = {
 "Benga",
 34952,
 "bnt-saw",
 "Latn",
}
m["bni"] = {
 "Bangi",
 34936,
 "bnt-bmo",
 "Latn",
}
m["bnj"] = {
 "Eastern Tawbuid",
 18757427,
 "phi",
 "Latn",
}
m["bnk"] = {
 "Bierebo",
 2902029,
 "poz-vnc",
 "Latn",
}
m["bnl"] = {
 "Boon",
 56616,
 "cus-eas",
 "Latn",
}
m["bnm"] = {
 "Batanga",
 34979,
 "bnt-saw",
 "Latn",
}
m["bnn"] = {
 "Bunun",
 56505,
 "map",
 "Latn",
}
m["bno"] = {
 "Asi",
 29490,
 "phi",
 "Latn",
}
m["bnp"] = {
 "Bola",
 4938876,
 "poz-ocw",
 "Latn",
}
m["bnq"] = {
 "Bantik",
 2883521,
 "poz",
 "Latn",
}
m["bnr"] = {
 "Butmas-Tur",
 2928942,
 "poz-vnc",
 "Latn",
}
m["bns"] = {
 "Bundeli",
 56399,
 "inc-cen",
 "Deva",
 ancestors = "inc-ohi",
 translit = "hi-translit",
}
m["bnu"] = {
 "Bentong",
 4890644,
 "poz-ssw",
 "Latn",
}
m["bnv"] = {
 "Beneraf",
 4941733,
 "paa-tkw",
 "Latn",
}
m["bnw"] = {
 "Bisis",
 56356,
 "paa-spk",
 "Latn",
}
m["bnx"] = {
 "Bangubangu",
 3438330,
 "bnt-lbn",
 "Latn",
}
m["bny"] = {
 "Bintulu",
 3450775,
 "poz-swa",
 "Latn",
}
m["bnz"] = {
 "Beezen",
 35083,
 "nic-ykb",
 "Latn",
}
m["boa"] = {
 "Bora",
 2375468,
 "sai-bor",
 "Latn",
}
m["bob"] = {
 "Aweer",
 56526,
 "cus-som",
 "Latn",
}
m["boe"] = {
 "Mundabli",
 36127,
 "nic-beb",
 "Latn",
}
m["bof"] = {
 "Bolon",
 3913301,
 "dmn-emn",
 "Latn",
}
m["bog"] = {
 "Bamako Sign Language",
 4853284,
 "sgn",
}
m["boh"] = {
 "North Boma",
 35080,
 "bnt-bdz",
 "Latn",
}
m["boi"] = {
 "Barbareño",
 56391,
 "nai-chu",
 "Latn",
}
m["boj"] = {
 "Anjam",
 3504136,
 "ngf-mad",
 "Latn",
}
m["bok"] = {
 "Bonjo",
 34942,
 "alv",
 "Latn",
}
m["bol"] = {
 "Bole",
 3436680,
 "cdc-wst",
 "Latn",
}
m["bom"] = {
 "Berom",
 35013,
 "nic-beo",
 "Latn",
}
m["bon"] = {
 "Bine",
 4914077,
 "paa",
 "Latn",
}
m["boo"] = {
 "Tiemacèwè Bozo",
 12643582,
 "dmn-snb",
 "Latn", -- and others?
}
m["bop"] = {
 "Bonkiman",
 4942134,
 "ngf-fin",
 "Latn",
}
m["boq"] = {
 "Bogaya",
 7207578,
 "ngf",
 "Latn",
}
m["bor"] = {
 "Borôro",
 32986,
 "sai-mje",
 "Latn",
}
m["bot"] = {
 "Bongo",
 2910067,
 "csu-bbk",
 "Latn",
}
m["bou"] = {
 "Bondei",
 4941378,
 "bnt-seu",
 "Latn",
}
m["bov"] = {
 "Tuwuli",
 36974,
 "alv-ktg",
 "Latn",
}
m["bow"] = {
 "Rema",
 7311502,
 "paa",
 "Latn",
}
m["box"] = {
 "Buamu",
 35157,
 "nic-bwa",
 "Latn",
}
m["boy"] = {
 "Bodo (Central Africa)",
 4936715,
 "bnt-leb",
 "Latn",
}
m["boz"] = {
 "Tiéyaxo Bozo",
 32860401,
 "dmn-snb",
 "Latn",
}
m["bpa"] = {
 "Dakaka",
 1157729,
 "poz-vnc",
 "Latn",
}
m["bpd"] = {
 "Banda-Banda",
 3450674,
 "bad-cnt",
 "Latn",
}
m["bpg"] = {
 "Bonggo",
 4941860,
 "poz-ocw",
 "Latn",
}
m["bph"] = {
 "Botlikh",
 56560,
 "cau-and",
 "Cyrl",
 translit = "cau-nec-translit",
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
}
m["bpi"] = {
 "Bagupi",
 3450697,
 "ngf-mad",
 "Latn",
}
m["bpj"] = {
 "Binji",
 4914403,
 "bnt-lbn",
 "Latn",
}
m["bpk"] = {
 "Orowe",
 7103905,
 "poz-cln",
 "Latn",
}
m["bpl"] = {
 "Broome Pearling Lugger Pidgin",
 4975277,
 "crp",
 "Latn",
 ancestors = "ms",
}
m["bpm"] = {
 "Biyom",
 4919327,
 "ngf-mad",
 "Latn",
}
m["bpn"] = {
 "Dzao Min",
 3042189,
 "hmx-mie",
}
m["bpo"] = {
 "Anasi",
 11207813,
 "paa-egb",
 "Latn",
}
m["bpp"] = {
 "Kaure",
 20526532,
 "paa",
 "Latn",
}
m["bpq"] = {
 "Banda Malay",
 12473442,
 "crp",
 "Latn",
 ancestors = "ms",
}
m["bpr"] = {
 "Koronadal Blaan",
 16115430,
 "phi",
 "Latn",
}
m["bps"] = {
 "Sarangani Blaan",
 16117272,
 "phi",
 "Latn",
}
m["bpt"] = {
 "Barrow Point",
 2567916,
 "aus-pmn",
 "Latn",
}
m["bpu"] = {
 "Bongu",
 4941930,
 "ngf-mad",
 "Latn",
}
m["bpv"] = {
 "Bian Marind",
 8841889,
 "ngf",
 "Latn",
}
m["bpx"] = {
 "Palya Bareli",
 7128872,
 "inc-bhi",
 "Deva",
 ancestors = "pra-sau",
 translit = "hi-translit",
}
m["bpy"] = {
 "Bishnupriya Manipuri",
 37059,
 "inc-eas",
 "Beng",
 ancestors = "inc-obn",
}
m["bpz"] = {
 "Bilba",
 8843362,
 "poz-tim",
 "Latn",
}
m["bqa"] = {
 "Tchumbuli",
 11008162,
 "alv-ctn",
 "Latn",
 ancestors = "ak",
}
m["bqb"] = {
 "Bagusa",
 4842178,
 "paa-tkw",
 "Latn",
}
m["bqc"] = {
 "Boko",
 34983,
 "dmn-bbu",
 "Latn",
}
m["bqd"] = {
 "Bung",
 3436612,
 "nic-bdn",
 "Latn",
}
m["bqf"] = {
 "Baga Kaloum",
 3502293,
 "alv-bag",
 "Latn",
}
m["bqg"] = {
 "Bago-Kusuntu",
 34878,
 "nic-gne",
}
m["bqh"] = {
 "Baima",
 674990,
 "sit-qia",
}
m["bqi"] = {
 "Bakhtiari",
 257829,
 "ira-swi",
 "fa-Arab",
 ancestors = "pal",
}
m["bqj"] = {
 "Bandial",
 34872,
 "alv-jol",
 "Latn",
}
m["bqk"] = {
 "Banda-Mbrès",
 3450724,
 "bad-cnt",
 "Latn",
}
m["bql"] = {
 "Bilakura",
 4907504,
 "ngf-mad",
 "Latn",
}
m["bqm"] = {
 "Wumboko",
 37051,
 "bnt-kpw",
 "Latn",
}
m["bqn"] = {
 "Bulgarian Sign Language",
 3438325,
 "sgn",
}
m["bqo"] = {
 "Balo",
 34865,
 "nic-grs",
 "Latn",
}
m["bqp"] = {
 "Busa",
 35185,
 "dmn-bbu",
 "Latn",
}
m["bqq"] = {
 "Biritai",
 56382,
 "paa-lkp",
 "Latn",
}
m["bqr"] = {
 "Burusu",
 5001028,
 "poz-san",
 "Latn",
}
m["bqs"] = {
 "Bosngun",
 56838,
 "paa",
 "Latn",
}
m["bqt"] = {
 "Bamukumbit",
 35078,
 "nic-nge",
 "Latn",
}
m["bqu"] = {
 "Boguru",
 3438444,
 "bnt-boa",
 "Latn",
}
m["bqv"] = {
 "Begbere-Ejar",
 7194098,
 "nic-plc",
 "Latn",
}
m["bqw"] = {
 "Buru (Nigeria)",
 1017152,
 "nic-bds",
 "Latn",
}
m["bqx"] = {
 "Baangi",
 3450648,
 "nic-kam",
 "Latn",
}
m["bqy"] = {
 "Bengkala Sign Language",
 3322119,
 "sgn",
}
m["bqz"] = {
 "Bakaka",
 34855,
 "bnt-mne",
 "Latn",
}
m["bra"] = {
 "Braj",
 35243,
 "inc-cen",
 "Deva",
 ancestors = "inc-ohi",
 translit = "hi-translit",
}
m["brb"] = {
 "Lave",
 4957737,
 "mkh-ban",
}
m["brc"] = {
 "Berbice Creole Dutch",
 35215,
 "crp",
 "Latn",
 ancestors = "nl",
}
m["brd"] = {
 "Baraamu",
 56804,
 "sit-new",
 "Deva",
}
m["brf"] = {
 "Bera",
 2896850,
 "bnt-kbi",
 "Latn",
}
m["brg"] = {
 "Baure",
 2839722,
 "awd",
 "Latn",
}
m["brh"] = {
 "Brahui",
 33202,
 "dra",
 "Arab, Latn",
}
m["bri"] = {
 "Mokpwe",
 36428,
 "bnt-kpw",
 "Latn",
}
m["brj"] = {
 "Bieria",
 4904607,
 "poz-vnc",
 "Latn",
}
m["brk"] = {
 "Birgid",
 56823,
 "nub",
 "Latn",
}
m["brl"] = {
 "Birwa",
 3501019,
 "bnt-sts",
 "Latn",
}
m["brm"] = {
 "Barambu",
 34893,
 "znd",
 "Latn",
}
m["brn"] = {
 "Boruca",
 4946773,
 "cba",
 "Latn",
}
m["bro"] = {
 "Brokkat",
 56605,
 "sit-tib",
 "Tibt, Latn",
 translit = {Tibt = "Tibt-translit"},
 override_translit = true,
 display_text = {Tibt = s["Tibt-displaytext"]},
 entry_name = {Tibt = s["Tibt-entryname"]},
 sort_key = {Tibt = "Tibt-sortkey"},
}
m["brp"] = {
 "Barapasi",
 56995,
 "paa-egb",
 "Latn",
}
m["brq"] = {
 "Breri",
 4961835,
 "paa",
 "Latn",
}
m["brr"] = {
 "Birao",
 2904383,
 "poz-sls",
 "Latn",
}
m["brs"] = {
 "Baras",
 8827053,
 "poz",
 "Latn",
}
m["brt"] = {
 "Bitare",
 34946,
 "nic-tvn",
 "Latn",
}
m["bru"] = {
 "Eastern Bru",
 16115463,
 "mkh-kat",
 "Latn, Laoo, Thai",
 sort_key = {
  Laoo = "Laoo-sortkey",
  Thai = "Thai-sortkey",
 },
}
m["brv"] = {
 "Western Bru",
 16113806,
 "mkh-kat",
 "Latn, Laoo, Thai",
 sort_key = {
  Laoo = "Laoo-sortkey",
  Thai = "Thai-sortkey",
 },
}
m["brw"] = {
 "Bellari",
 4883496,
 "dra",
 "Knda, Mlym",
 translit = {
  Knda = "kn-translit",
  Mlym = "ml-translit",
 },
}
m["brx"] = {
 "Bodo (India)",
 33223,
 "tbq-bdg",
 "Deva, Latn",
 translit = {Deva = "brx-translit"},
}
m["bry"] = {
 "Burui",
 5000976,
 "paa-spk",
 "Latn",
}
m["brz"] = {
 "Bilbil",
 4907473,
 "poz-ocw",
 "Latn",
}
m["bsa"] = {
 "Abinomn",
 56648,
 "qfa-iso",
 "Latn",
}
m["bsb"] = {
 "Brunei Bisaya",
 3450611,
 "poz-san",
 "Latn",
}
m["bsc"] = {
 "Bassari",
 35098,
 "alv-ten",
 "Latn",
}
m["bse"] = {
 "Wushi",
 36973,
 "nic-rnn",
 "Latn",
}
m["bsf"] = {
 "Bauchi",
 34974,
 "nic-shi",
 "Latn",
}
m["bsg"] = {
 "Bashkardi",
 33030,
 "ira-swi",
 "fa-Arab, Latn",
}
m["bsh"] = {
 "Kamkata-viri",
 2605045,
 "nur-nor",
 "Latn, Arab",
}
m["bsi"] = {
 "Bassossi",
 34940,
 "bnt-mne",
 "Latn",
}
m["bsj"] = {
 "Bangwinji",
 3446631,
 "alv-wjk",
 "Latn",
}
m["bsk"] = {
 "Burushaski",
 216286,
 "qfa-iso",
 "Arab",
}
m["bsl"] = {
 "Basa-Gumna",
 4866150,
 "nic-bas",
 "Latn",
}
m["bsm"] = {
 "Busami",
 5001255,
 "poz-hce",
 "Latn",
}
m["bsn"] = {
 "Barasana",
 2883843,
 "sai-tuc",
 "Latn",
}
m["bso"] = {
 "Buso",
 3441370,
 "cdc-est",
 "Latn",
}
m["bsp"] = {
 "Baga Sitemu",
 36466,
 "alv-bag",
 "Latn",
}
m["bsq"] = {
 "Bassa",
 34949,
 "kro-wkr",
 "Latn, Bass",
}
m["bsr"] = {
 "Bassa-Kontagora",
 4866152,
 "nic-bas",
 "Latn",
}
m["bss"] = {
 "Akoose",
 34806,
 "bnt-mne",
 "Latn",
}
m["bst"] = {
 "Basketo",
 56531,
 "omv-ome",
 "Ethi",
}
m["bsu"] = {
 "Bahonsuai",
 2879298,
 "poz-btk",
 "Latn",
}
m["bsv"] = {
 "Baga Sobané",
 3450433,
 "alv-bag",
 "Latn",
}
m["bsw"] = {
 "Baiso",
 56615,
 "cus-som",
 "Latn",
}
m["bsx"] = {
 "Yangkam",
 36922,
 "nic-tar",
 "Latn",
}
m["bsy"] = {
 "Sabah Bisaya",
 12641557,
 "poz-san",
 "Latn",
}
m["bta"] = {
 "Bata",
 56254,
 "cdc-cbm",
 "Latn",
}
m["btc"] = {
 "Bati (Cameroon)",
 34944,
 "nic-mbw",
 "Latn",
}
m["btd"] = {
 "Dairi Batak",
 2891045,
 "btk",
 "Latn, Batk",
}
m["bte"] = {
 "Gamo-Ningi",
 5520366,
 "nic-jer",
 "Latn",
}
m["btf"] = {
 "Birgit",
 56302,
 "cdc-est",
 "Latn",
}
m["btg"] = {
 "Gagnoa Bété",
 11005602,
 "kro-bet",
 "Latn",
}
m["bth"] = {
 "Biatah Bidayuh",
 2900881,
 "day",
 "Latn",
}
m["bti"] = {
 "Burate",
 56900,
 "paa-egb",
 "Latn",
}
m["btj"] = {
 "Bacanese Malay",
 8828608,
 "poz-mly",
 "Latn",
}
m["btm"] = {
 "Mandailing Batak",
 2891049,
 "btk",
 "Latn, Batk",
}
m["btn"] = {
 "Ratagnon",
 13197,
 "phi",
 "Latn",
}
m["bto"] = {
 "Iriga Bicolano",
 12633026,
 "phi",
 "Latn",
}
m["btp"] = {
 "Budibud",
 4985086,
 "poz-ocw",
 "Latn",
}
m["btq"] = {
 "Batek",
 860315,
 "mkh-asl",
 "Latn",
}
m["btr"] = {
 "Baetora",
 2878874,
 "poz-vnc",
 "Latn",
}
m["bts"] = {
 "Simalungun Batak",
 2891054,
 "btk",
 "Latn, Batk",
}
m["btt"] = {
 "Bete-Bendi",
 4887064,
 "nic-ben",
 "Latn",
}
m["btu"] = {
 "Batu",
 34964,
 "nic-tvn",
 "Latn",
}
m["btv"] = {
 "Bateri",
 3812564,
 "inc-dar",
 "Deva",
}
m["btw"] = {
 "Butuanon",
 5003156,
 "phi",
 "Latn",
}
m["btx"] = {
 "Karo Batak",
 33012,
 "btk",
 "Latn, Batk",
}
m["bty"] = {
 "Bobot",
 3446788,
 "poz-cma",
 "Latn",
}
m["btz"] = {
 "Alas-Kluet Batak",
 2891042,
 "btk",
 "Latn, Batk",
}
m["bua"] = {
 "Buryat",
 33120,
 "xgn-cen",
 "Cyrl, Mong, Latn",
 wikimedia_codes = "bxr",
 ancestors = "cmg",
 translit = {
  Cyrl = "bua-translit",
  Mong = "Mong-translit",
 },
 override_translit = true,
 display_text = {Mong = s["Mong-displaytext"]},
 entry_name = {
  Cyrl = {remove_diacritics = c.grave .. c.acute},
  Mong = s["Mong-entryname"],
 },
 sort_key = {
  Cyrl = {
   from = {"ё", "ө", "ү", "һ"},
   to = {"е" .. p[1], "о" .. p[1], "у" .. p[1], "х" .. p[1]}
  },
 },
}
m["bub"] = {
 "Bua",
 32928,
 "alv-bua",
 "Latn",
}
m["bud"] = {
 "Ntcham",
 36266,
 "nic-grm",
 "Latn",
}
m["bue"] = {
 "Beothuk",
 56234,
 nil,
 "Latn",
}
m["buf"] = {
 "Bushoong",
 3449964,
 "bnt-bsh",
 "Latn",
}
m["bug"] = {
 "Buginese",
 33190,
 "poz-ssw",
 "Bugi, Latn",
}
m["buh"] = {
 "Younuo Bunu",
 56299,
 "hmn",
 "Latn",
}
m["bui"] = {
 "Bongili",
 35084,
 "bnt-ngn",
 "Latn",
}
m["buj"] = {
 "Basa-Gurmana",
 6432515,
 "nic-bas",
 "Latn",
}
m["buk"] = {
 "Bukawa",
 35043,
 "poz-ocw",
 "Latn",
}
m["bum"] = {
 "Bulu (Cameroon)",
 35028,
 "bnt-btb",
 "Latn",
}
m["bun"] = {
 "Sherbro",
 36339,
 "alv-mel",
 "Latn",
}
m["buo"] = {
 "Terei",
 56831,
 "paa-sbo",
 "Latn",
}
m["bup"] = {
 "Busoa",
 5002001,
 "poz",
 "Latn",
}
m["buq"] = {
 "Brem",
 4960502,
 "ngf",
 "Latn",
}
m["bus"] = {
 "Bokobaru",
 9228931,
 "dmn-bbu",
 "Latn",
}
m["but"] = {
 "Bungain",
 3450623,
 "qfa-tor",
 "Latn",
}
m["buu"] = {
 "Budu",
 3450207,
 "bnt-nya",
 "Latn",
}
m["buv"] = {
 "Bun",
 56351,
 "paa-yua",
 "Latn",
}
m["buw"] = {
 "Bubi",
 35017,
 "bnt-tso",
 "Latn",
}
m["bux"] = {
 "Boghom",
 3440412,
 "cdc-wst",
 "Latn",
}
m["buy"] = {
 "Mmani",
 35061,
 "alv-mel",
 "Latn",
}
m["bva"] = {
 "Barein",
 56285,
 "cdc-est",
 "Latn",
}
m["bvb"] = {
 "Bube",
 35110,
 "nic-bds",
 "Latn",
}
m["bvc"] = {
 "Baelelea",
 2878833,
 "poz-sls",
 "Latn",
}
m["bvd"] = {
 "Baeggu",
 2878850,
 "poz-sls",
 "Latn",
}
m["bve"] = {
 "Berau Malay",
 3915770,
 "poz-mly",
 "Latn",
}
m["bvf"] = {
 "Boor",
 56250,
 "cdc-est",
 "Latn",
}
m["bvg"] = {
 "Bonkeng",
 34958,
 "bnt-bbo",
 "Latn",
}
m["bvh"] = {
 "Bure",
 56294,
 "cdc-wst",
 "Latn",
}
m["bvi"] = {
 "Belanda Viri",
 35247,
 "nic-ser",
 "Latn",
}
m["bvj"] = {
 "Baan",
 3515067,
 "nic-ogo",
 "Latn",
}
m["bvk"] = {
 "Bukat",
 4986814,
 "poz-bnn",
 "Latn",
}
m["bvl"] = {
 "Bolivian Sign Language",
 1783590,
 "sgn",
 "Latn", -- when documented
}
m["bvm"] = {
 "Bamunka",
 34882,
 "nic-rnn",
 "Latn",
}
m["bvn"] = {
 "Buna",
 3450516,
 "qfa-tor",
 "Latn",
}
m["bvo"] = {
 "Bolgo",
 35038,
 "alv-bua",
 "Latn",
}
m["bvp"] = {
 "Bumang",
 4997235,
 "mkh-pal",
}
m["bvq"] = {
 "Birri",
 56514,
 "csu-bkr",
 "Latn",
}
m["bvr"] = {
 "Burarra",
 4998124,
 "aus-arn",
 "Latn",
}
m["bvt"] = {
 "Bati (Indonesia)",
 4869253,
 "poz-cma",
 "Latn",
}
m["bvu"] = {
 "Bukit Malay",
 9230148,
 "poz-mly",
 "Latn",
}
m["bvv"] = {
 "Baniva",
 3515198,
 "awd",
 "Latn",
}
m["bvw"] = {
 "Boga",
 56262,
 "cdc-cbm",
 "Latn",
}
m["bvx"] = {
 "Babole",
 35180,
 "bnt-ngn",
 "Latn",
}
m["bvy"] = {
 "Baybayanon",
 16839275,
 "phi",
 "Latn",
}
m["bvz"] = {
 "Bauzi",
 56360,
 "paa-egb",
 "Latn",
}
m["bwa"] = {
 "Bwatoo",
 9232446,
 "poz-cln",
 "Latn",
}
m["bwb"] = {
 "Namosi-Naitasiri-Serua",
 3130290,
 "poz-occ",
 "Latn",
}
m["bwc"] = {
 "Bwile",
 3447440,
 "bnt-sbi",
 "Latn",
}
m["bwd"] = {
 "Bwaidoka",
 2929111,
 "poz-ocw",
 "Latn",
}
m["bwe"] = {
 "Bwe Karen",
 56994,
 "kar",
}
m["bwf"] = {
 "Boselewa",
 4947229,
 "poz-ocw",
 "Latn",
}
m["bwg"] = {
 "Barwe",
 8826802,
 "bnt-sna",
 "Latn",
}
m["bwh"] = {
 "Bishuo",
 34973,
 "nic-fru",
 "Latn",
}
m["bwi"] = {
 "Baniwa",
 3501735,
 "awd-nwk",
 "Latn",
}
m["bwj"] = {
 "Láá Láá Bwamu",
 11017275,
 "nic-bwa",
 "Latn",
}
m["bwk"] = {
 "Bauwaki",
 4873607,
 "ngf",
 "Latn",
}
m["bwl"] = {
 "Bwela",
 5003678,
 "bnt-bun",
 "Latn",
}
m["bwm"] = {
 "Biwat",
 56352,
 "paa-yua",
 "Latn",
}
m["bwn"] = {
 "Wunai Bunu",
 56452,
 "hmn",
}
m["bwo"] = {
 "Shinasha",
 56260,
 "omv-gon",
 "Latn",
}
m["bwp"] = {
 "Mandobo Bawah",
 12636155,
 "ngf",
 "Latn",
}
m["bwq"] = {
 "Southern Bobo",
 11001714,
 "dmn-snb",
 "Latn",
}
m["bwr"] = {
 "Bura",
 56552,
 "cdc-cbm",
 "Latn",
}
m["bws"] = {
 "Bomboma",
 9229429,
 "bnt-bun",
 "Latn",
}
m["bwt"] = {
 "Bafaw",
 34853,
 "bnt-bbo",
 "Latn",
}
m["bwu"] = {
 "Buli (Ghana)",
 35085,
 "nic-buk",
 "Latn",
}
m["bww"] = {
 "Bwa",
 3515058,
 "bnt-bta",
 "Latn",
}
m["bwx"] = {
 "Bu-Nao Bunu",
 56411,
 "hmn",
 "Latn",
}
m["bwy"] = {
 "Cwi Bwamu",
 11150714,
 "nic-bwa",
 "Latn",
}
m["bwz"] = {
 "Bwisi",
 35067,
 "bnt-sir",
 "Latn",
}
m["bxa"] = {
 "Bauro",
 2892068,
 "poz-sls",
 "Latn",
}
m["bxb"] = {
 "Belanda Bor",
 56678,
 "sdv-lon",
 "Latn",
}
m["bxc"] = {
 "Molengue",
 13345,
 "bnt-kel",
 "Latn",
}
m["bxd"] = {
 "Pela",
 57000,
 "tbq-brm",
}
m["bxe"] = {
 "Ongota",
 36344,
 nil,
 "Latn",
}
m["bxf"] = {
 "Bilur",
 2903788,
 "poz-ocw",
 "Latn",
}
m["bxg"] = {
 "Bangala",
 34989,
 "bnt-bmo",
 "Latn",
}
m["bxh"] = {
 "Buhutu",
 4986329,
 "poz-ocw",
 "Latn",
}
m["bxi"] = {
 "Pirlatapa",
 10632195,
 "aus-kar",
 "Latn",
}
m["bxj"] = {
 "Bayungu",
 10427485,
 "aus-psw",
 "Latn",
}
m["bxk"] = {
 "Bukusu",
 32930,
 "bnt-msl",
 "Latn",
}
m["bxl"] = {
 "Jalkunan",
 11009787,
 "dmn-jje",
 "Latn",
}
m["bxn"] = {
 "Burduna",
 4998313,
 "aus-psw",
 "Latn",
}
m["bxo"] = {
 "Barikanchi",
 3450802,
 "crp",
 "Latn",
 ancestors = "ha",
}
m["bxp"] = {
 "Bebil",
 34941,
 "bnt-btb",
 "Latn",
}
m["bxq"] = {
 "Beele",
 56238,
 "cdc-wst",
 "Latn",
}
m["bxs"] = {
 "Busam",
 35189,
 "nic-grs",
 "Latn",
}
m["bxv"] = {
 "Berakou",
 56796,
 "csu-bgr",
 "Latn",
}
m["bxw"] = {
 "Banka",
 3438402,
 "dmn-smg",
 "Latn",
}
m["bxz"] = {
 "Binahari",
 4913840,
 "ngf",
 "Latn",
}
m["bya"] = {
 "Palawan Batak",
 3450443,
 "phi",
 "Tagb",
}
m["byb"] = {
 "Bikya",
 33257,
 "nic-fru",
 "Latn",
}
m["byc"] = {
 "Ubaghara",
 36625,
 "nic-ucn",
 "Latn",
}
m["byd"] = {
 "Benyadu'",
 11173588,
 "day",
 "Latn",
}
m["bye"] = {
 "Pouye",
 7235814,
 "paa-spk",
 "Latn",
}
m["byf"] = {
 "Bete",
 32932,
 "nic-ykb",
 "Latn",
}
m["byg"] = {
 "Baygo",
 56836,
 "sdv-daj",
 "Latn",
}
m["byh"] = {
 "Bujhyal",
 56317,
 "sit-gma",
 "Deva",
}
m["byi"] = {
 "Buyu",
 5003401,
 "bnt-nyb",
 "Latn",
}
m["byj"] = {
 "Binawa",
 4913807,
 "nic-kau",
 "Latn",
}
m["byk"] = {
 "Biao",
 4902547,
 "qfa-tak",
 "Latn", -- also Hani?
}
m["byl"] = {
 "Bayono",
 3503856,
 "ngf",
 "Latn",
}
m["bym"] = {
 "Bidyara",
 8842355,
 "aus-pam",
 "Latn",
}
m["byn"] = {
 "Blin",
 56491,
 "cus-cen",
 "Ethi, Latn",
 translit = {Ethi = "Ethi-translit"},
}
m["byo"] = {
 "Biyo",
 56848,
 "tbq-lol",
 "Latn, Hani",
 sort_key = {Hani = "Hani-sortkey"},
}
m["byp"] = {
 "Bumaji",
 4997234,
 "nic-ben",
 "Latn",
}
m["byq"] = {
 "Basay",
 716647,
 "map",
 "Latn",
}
m["byr"] = {
 "Baruya",
 3450812,
 "ngf",
 "Latn",
}
m["bys"] = {
 "Burak",
 4998097,
 "alv-bwj",
 "Latn",
}
m["byt"] = {
 "Berti",
 35008,
 "ssa-sah",
 "Latn",
}
m["byv"] = {
 "Medumba",
 36019,
 "bai",
 "Latn",
}
m["byw"] = {
 "Belhariya",
 32961,
 "sit-kie",
 "Deva",
}
m["byx"] = {
 "Qaqet",
 3503009,
 "paa-bng",
 "Latn",
}
m["byz"] = {
 "Banaro",
 56858,
 "paa",
 "Latn",
}
m["bza"] = {
 "Bandi",
 34912,
 "dmn-msw",
 "Latn",
}
m["bzb"] = {
 "Andio",
 4754487,
 "poz-slb",
 "Latn",
}
m["bzd"] = {
 "Bribri",
 28400,
 "cba",
 "Latn",
}
m["bze"] = {
 "Jenaama Bozo",
 10950633,
 "dmn-snb",
 "Latn",
}
m["bzf"] = {
 "Boikin",
 56829,
 "paa-spk",
 "Latn",
}
m["bzg"] = {
 "Babuza",
 716615,
 "map",
}
m["bzh"] = {
 "Mapos Buang",
 2927370,
 "poz-ocw",
 "Latn",
}
m["bzi"] = {
 "Bisu",
 56852,
 "tbq-lol",
 "Latn, Thai",
 sort_key = {Thai = "Thai-sortkey"},
}
m["bzj"] = {
 "Belizean Creole",
 1363055,
 "crp",
 "Latn",
 ancestors = "en",
}
m["bzk"] = {
 "Nicaraguan Creole",
 3504097,
 "crp",
 "Latn",
 ancestors = "en",
}
m["bzl"] = {  -- supposedly also called "Bolano", but I can find no evidence of that
 "Boano (Sulawesi)",
 4931258,
 "poz",
 "Latn",
}
m["bzm"] = {
 "Bolondo",
 35071,
 "bnt-bun",
 "Latn",
}
m["bzn"] = {
 "Boano (Maluku)",
 4931255,
 "poz-cma",
 "Latn",
}
m["bzo"] = {
 "Bozaba",
 4952785,
 "bnt-ngn",
 "Latn",
}
m["bzp"] = {
 "Kemberano",
 12634399,
 "ngf-sbh",
 "Latn",
}
m["bzq"] = {
 "Buli (Indonesia)",
 2927952,
 "poz-hce",
 "Latn",
}
m["bzr"] = {
 "Biri",
 4087011,
 "aus-pam",
 "Latn",
}
m["bzs"] = {
 "Brazilian Sign Language",
 3436689,
 "sgn",
 "Latn",
}
m["bzu"] = {
 "Burmeso",
 56746,
 "paa-wpa",
 "Latn",
}
m["bzv"] = {
 "Bebe",
 34977,
 "nic-bbe",
 "Latn",
}
m["bzw"] = {
 "Basa",
 34898,
 "nic-bas",
 "Latn",
}
m["bzx"] = {
 "Hainyaxo Bozo",
 11159536,
 "dmn-snb",
 "Latn",
}
m["bzy"] = {
 "Obanliku",
 36276,
 "nic-ben",
 "Latn",
}
m["bzz"] = {
 "Evant",
 35259,
 "nic-tvc",
 "Latn",
}
m["caa"] = {
 "Ch'orti'",
 35177,
 "myn",
 "Latn",
}
m["cab"] = {
 "Garifuna",
 35490,
 "awd-taa",
 "Latn",
}
m["cac"] = {
 "Chuj",
 35233,
 "myn",
 "Latn",
}
m["cad"] = {
 "Caddo",
 56756,
 "cdd",
 "Latn",
}
m["cae"] = {
 "Laalaa",
 35564,
 "alv-cng",
 "Latn",
}
m["caf"] = {
 "Southern Carrier",
 12953426,
 "ath-nor",
 "Latn",
}
m["cag"] = {
 "Nivaclé",
 3182557,
 "sai-mtc",
 "Latn",
}
m["cah"] = {
 "Cahuarano",
 2933175,
 "sai-zap",
 "Latn",
}
m["caj"] = {
 "Chané",
 56721,
 "awd",
 "Latn",
}
m["cak"] = {
 "Kaqchikel",
 35115,
 "myn",
 "Latn",
}
m["cal"] = {
 "Carolinian",
 28427,
 "poz-mic",
 "Latn",
}
m["cam"] = {
 "Cemuhî",
 3009690,
 "poz-cln",
 "Latn",
}
m["can"] = {
 "Chambri",
 5069707,
 "paa-lsp",
 "Latn",
}
m["cao"] = {
 "Chácobo",
 2591202,
 "sai-pan",
 "Latn",
}
m["cap"] = {
 "Chipaya",
 35235,
 "sai-ucp",
 "Latn",
}
m["caq"] = {
 "Car Nicobarese",
 35156,
 "aav-nic",
 "Latn",
}
m["car"] = {
 "Galibi Carib",
 56611,
 "sai-gui",
 "Latn",
}
m["cas"] = {
 "Tsimané",
 35950,
 "qfa-iso",
 "Latn",
}
m["cav"] = {
 "Cavineña",
 524102,
 "sai-tac",
 "Latn",
}
m["caw"] = {
 "Callawalla",
 266417,
 "qfa-mix",
 "Latn",
}
m["cax"] = {
 "Chiquitano",
 1844993,
 "qfa-iso",
 "Latn",
}
m["cay"] = {
 "Cayuga",
 32967,
 "iro-nor",
 "Latn",
}
m["caz"] = {
 "Canichana",
 2936374,
 "qfa-iso",
 "Latn",
}
m["cbb"] = {
 "Cabiyarí",
 3450660,
 "awd-nwk",
 "Latn",
}
m["cbc"] = {
 "Carapana",
 924405,
 "sai-tuc",
 "Latn",
}
m["cbd"] = {
 "Carijona",
 3446655,
 "sai-tar",
 "Latn",
}
m["cbg"] = {
 "Chimila",
 2963680,
 "cba",
 "Latn",
}
m["cbi"] = {
 "Chachi",
 2591329,
 "sai-bar",
 "Latn",
}
m["cbj"] = {
 "Ede Cabe",
 33112829,
 "alv-ede",
 "Latn",
}
m["cbk"] = {
 "Chavacano",
 33281,
 "crp",
 "Latn",
    ancestors = "es",
 entry_name = {Latn = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.diaer}},
 sort_key = {
  Latn = {
   from = {"ch", "ll", "ñ", "r"},
   to = {"c" .. p[1], "l" .. p[1], "n" .. p[1], "r" .. p[1]}
  },
 },
 standardChars = {
  Latn = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnÑñOoPpQqRrSsTtUuVvWwXxYyZz",
  c.punc
 },
}
m["cbl"] = {
 "Bualkhaw Chin",
 9229830,
 "tbq-kuk",
 "Latn",
}
m["cbn"] = {
 "Nyah Kur",
 116849,
 "mkh-mnc",
 "Thai",
 ancestors = "omx",
 sort_key = "Thai-sortkey",
}
m["cbo"] = {
 "Izora",
 3915454,
 "nic-jer",
 "Latn",
}
m["cbq"] = {
 "Shuba",
 nil,
 "nic-knj",
 "Latn",
 ancestors = "lan",
}
m["cbr"] = {
 "Cashibo-Cacataibo",
 5359560,
 "sai-pan",
 "Latn",
}
m["cbs"] = {
 "Cashinahua",
 2591230,
 "sai-pan",
 "Latn",
}
m["cbt"] = {
 "Chayahuita",
 1526525,
 "sai-cah",
 "Latn",
}
m["cbu"] = {
 "Candoshi-Shapra",
 642843,
 "qfa-iso",
 "Latn",
}
m["cbv"] = {
 "Cacua",
 3192052,
 "sai-nad",
 "Latn",
 ancestors = "mbr",
}
m["cbw"] = {
 "Kinabalian",
 6410324,
 "phi",
 "Latn",
}
m["cby"] = {
 "Carabayo",
 3441762,
 "sai-tyu",
 "Latn",
}
m["cca"] = {
 "Cauca",
 5054242,
 "sai-chc",
 "Latn",
}
m["ccc"] = {
 "Chamicuro",
 2155119,
 "awd",
 "Latn",
}
m["ccd"] = {
 "Cafundó",
 3331506,
 "roa-ibe",
 "Latn",
 ancestors = "pt",
}
m["cce"] = {
 "Chopi",
 3437616,
 "bnt-bso",
 "Latn",
}
m["ccg"] = {
 "Chamba Daka",
 33120805,
 "nic-dak",
 "Latn",
}
m["cch"] = {
 "Atsam",
 34794,
 "nic-kne",
 "Latn",
}
m["ccj"] = {
 "Kasanga",
 35542,
 "alv-nyn",
 "Latn",
}
m["ccl"] = {
 "Cutchi-Swahili",
 5196729,
 "crp",
 "Latn",
 ancestors = "sw",
}
m["ccm"] = {
 "Malaccan Creole Malay",
 12636092,
 "crp",
 "Latn",
 ancestors = "ms",
}
m["cco"] = {
 "Comaltepec Chinantec",
 2963735,
 "omq-chi",
 "Latn",
}
m["ccp"] = {
 "Chakma",
 32952,
 "inc-eas",
 "Cakm, Beng, Latn",
 ancestors = "inc-obn",
 translit = {
  Cakm = "Cakm-translit",
  --Beng = "Beng-translit",
 },
}
m["ccr"] = {
 "Cacaopera",
 3438338,
 "nai-min",
 "Latn",
}
m["cda"] = {
 "Choni",
 2964447,
 "sit-tib",
}
m["cde"] = {
 "Chenchu",
 32981,
 "dra",
 "Telu",
 ancestors = "te",
}
m["cdf"] = {
 "Chiru",
 5102016,
 "tbq-kuk",
 "Latn, Beng",
}
m["cdh"] = {
 "Chambeali",
 12953424,
 "him",
 "Deva, Takr",
 translit = {Deva = "hi-translit"},
}
m["cdi"] = {
 "Chodri",
 5103788,
 "inc-bhi",
 "Gujr",
}
m["cdj"] = {
 "Churahi",
 12629039,
 "him",
 "Deva, Takr",
 translit = {Deva = "hi-translit"},
}
m["cdm"] = {
 "Chepang",
 5091700,
 "sit-gma",
 "Deva",
}
m["cdn"] = {
 "Chaudangsi",
 5088056,
 "sit-alm",
}
m["cdo"] = {
 "Min Dong",
 36455,
 "zhx-min-hai",
 "Hani, Hant, Hans",
 generate_forms = "zh-generateforms",
 translit = "zh-translit",
 sort_key = "Hani-sortkey",
}
m["cdr"] = {
 "Cinda-Regi-Tiyal",
 35596,
 "nic-kmk",
 "Latn",
}
m["cds"] = {
 "Chadian Sign Language",
 10322099,
 "sgn",
 "Latn", -- when documented
}
m["cdy"] = {
 "Chadong",
 926742,
 "qfa-kms",
}
m["cdz"] = {
 "Koda",
 6425038,
 "mun",
 "Beng",
}
m["cea"] = {
 "Lower Chehalis",
 6693377,
 "sal",
 "Latn",
}
m["ceb"] = {
 "Cebuano",
 33239,
 "phi",
 "Latn, Tglg",
 translit = {
  Tglg = "ceb-translit"
 },
 override_translit = true,
 entry_name = {
   Latn = {
    remove_diacritics = c.grave .. c.acute .. c.circ
  }
 },
 standardChars = {
  Latn = "AaBbKkDdEeGgHhIiLlMmNnOoPpRrSsTtUuWwYy",
  c.punc
 },
 sort_key = {Latn = "tl-sortkey"},
}
m["ceg"] = {
 "Chamacoco",
 3436637,
 "sai-zam",
 "Latn",
}
m["cen"] = {
 "Cen",
 12628777,
 "nic-plc",
 "Latn",
 ancestors = "izr",
}
m["cet"] = {
 "Centúúm",
 33608,
 "qfa-iso",
 "Latn",
}
m["cfa"] = {
 "Dijim-Bwilim",
 3438350,
 "alv-wjk",
 "Latn",
}
m["cfd"] = {
 "Cara",
 35048,
 "nic-beo",
 "Latn",
}
m["cfg"] = {
 "Como Karim",
 35304,
 "nic-jkn",
 "Latn",
}
m["cfm"] = {
 "Falam Chin",
 56815,
 "tbq-kuk",
 "Beng, Latn",
}
m["cga"] = {
 "Changriwa",
 5072105,
 "paa-yua",
 "Latn",
}
m["cgc"] = {
 "Kagayanen",
 6346422,
 "mno",
 "Latn",
}
m["cgg"] = {
 "Rukiga",
 3270727,
 "bnt-nyg",
 "Latn",
}
m["cgk"] = {
 "Chocangaca",
 56604,
 "sit-tib",
 "Tibt",
 ancestors = "xct",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["chb"] = {
 "Chibcha",
 2356431,
 "cba",
}
m["chc"] = {
 "Catawba",
 5051602,
 "nai-cat",
 "Latn",
}
m["chd"] = {
 "Highland Oaxaca Chontal",
 2964457,
 "nai-tqn",
 "Latn",
}
m["chf"] = {
 "Tabasco Chontal",
 35175,
 "myn",
 "Latn",
}
m["chg"] = {
 "Chagatai",
 36831,
 "trk-kar",
 "Arab",
 entry_name = {
  remove_diacritics = c.kashida .. c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun .. c.superalef,
  from = {u(0x0671)},
  to   = {u(0x0627)}
 },
}
m["chh"] = {
 "Chinook",
 6693380,
 "nai-ckn",
 "Latn",
}
m["chj"] = {
 "Ojitlán Chinantec",
 5100110,
 "omq-chi",
 "Latn",
}
m["chk"] = {
 "Chuukese",
 33161,
 "poz-mic",
 "Latn",
}
m["chl"] = {
 "Cahuilla",
 56438,
 "azc-cup",
 "Latn",
 entry_name = {remove_diacritics = c.acute .. c.macron},
}
-- chm "Mari" is not recognized as a language, but it is a family code
m["chn"] = {
 "Chinook Jargon",
 35173,
 "crp",
 "Latn, Dupl",
 ancestors = "chh, nuk",
}
m["cho"] = {
 "Choctaw",
 32979,
 "nai-mus",
 "Latn",
 sort_key = {remove_diacritics = c.macronbelow .. "-"},
 entry_name = {remove_diacritics = c.acute .. c.dotbelow},
}
m["chp"] = {
 "Chipewyan",
 27692,
 "ath-nor",
 "Latn, Cans",
}
m["chq"] = {
 "Quiotepec Chinantec",
 5758709,
 "omq-chi",
 "Latn",
}
m["chr"] = {
 "Cherokee",
 33388,
 "iro",
 "Cher",
 translit = "Cher-translit",
}
m["cht"] = {
 "Cholón",
 2591243,
 nil,
 "Latn",
}
m["chw"] = {
 "Chuabo",
 5118412,
 "bnt-mak",
 "Latn",
}
m["chx"] = {
 "Chantyal",
 4926344,
 "sit-tam",
 "Deva",
}
m["chy"] = {
 "Cheyenne",
 33265,
 "alg",
 "Latn",
 sort_key = {remove_diacritics = c.grave .. c.acute .. c.macron .. c.dotabove .. "-"},
 standardChars = "AaÁáÀàĀāȦȧEeÉéÈèĒēĖėHhKkMmNnOoÓóÒòŌōȮȯPpSsŠšTtVvXx" .. c.punc, --umlaut and circumflex not allowed
}
m["chz"] = {
 "Ozumacín Chinantec",
 5100111,
 "omq-chi",
 "Latn",
}
m["cia"] = {
 "Cia-Cia",
 35284,
 "poz-mun",
 "Hang, Latn, Arab",
}
m["cib"] = {
 "Ci Gbe",
 12952445,
 "alv-gbe",
 "Latn",
}
m["cic"] = {
 "Chickasaw",
 33192,
 "nai-mus",
 "Latn",
}
m["cid"] = {
 "Chimariko",
 1294251,
 "qfa-iso",
 "Latn",
}
m["cie"] = {
 "Cineni",
 56243,
 "cdc-cbm",
 "Latn",
}
m["cih"] = {
 "Chinali",
 11855245,
 "inc",
 "Deva",
 ancestors = "sa",
}
m["cik"] = {
 "Chitkuli Kinnauri",
 15615982,
 "sit-kin",
}
m["cim"] = {
 "Cimbrian",
 37053,
 "gmw",
 "Latn",
 ancestors = "bar",
 sort_key = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.diaer .. c.ringabove .. c.caron},
}
m["cin"] = {
 "Cinta Larga",
 5121095,
 "tup",
 "Latn",
}
m["cip"] = {
 "Chiapanec",
 3364475,
 "omq",
 "Latn",
}
m["cir"] = {
 "Tiri",
 7862281,
 "poz-cln",
 "Latn",
}
m["ciy"] = {
 "Chaima",
 12628867,
 "sai-ven",
 "Latn",
}
m["cja"] = {
 "Western Cham",
 12645578,
 "cmc",
 "Latn, Arab, Khmr", -- Western Cham script is not yet available. Also, Arabic script is missing some glyphs.
}
m["cje"] = {
 "Chru",
 2967321,
 "cmc",
 "Latn",
}
m["cjh"] = {
 "Upper Chehalis",
 2962074,
 "sal",
 "Latn",
}
m["cji"] = {
 "Chamalal",
 56567,
 "cau-and",
 "Cyrl",
 translit = "cau-nec-translit",
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
}
m["cjk"] = {
 "Chokwe",
 2422065,
 "bnt-clu",
 "Latn",
}
m["cjm"] = {
 "Eastern Cham",
 2948019,
 "cmc",
 "Latn, Cham",
}
m["cjn"] = {
 "Chenapian",
 5091044,
 "paa-spk",
 "Latn",
}
m["cjo"] = {
 "Ashéninka Pajonal",
 3450481,
 "awd",
 "Latn",
}
m["cjp"] = {
 "Cabécar",
 27878,
 "cba",
 "Latn",
}
m["cjs"] = {
 "Shor",
 34139,
 "trk-sib",
 "Cyrl",
}
m["cjv"] = {
 "Chuave",
 5115226,
 "ngf",
 "Latn",
}
m["cjy"] = {
 "Jin",
 56479,
 "zhx",
 "Hani, Hant, Hans",
 ancestors = "ltc",
 generate_forms = "zh-generateforms",
 translit = "zh-translit",
 sort_key = "Hani-sortkey",
}
m["ckb"] = {
 "Central Kurdish",
 36811,
 "ku",
 "ku-Arab",
 translit = "ckb-translit",
 entry_name = {remove_diacritics = c.kasra .. c.sukun},
}
m["ckh"] = {
 "Chak",
 12628870,
 "sit-luu",
 "Latn",
 ancestors = "kdv",
}
m["ckl"] = {
 "Cibak",
 56279,
 "cdc-cbm",
 "Latn",
}
m["ckn"] = {
 "Kaang Chin",
 6343432,
 "tbq-kuk",
 "Latn",
}
m["cko"] = {
 "Anufo",
 34845,
 "alv-ctn",
 "Latn",
}
m["ckq"] = {
 "Kajakse",
 3440422,
 "cdc-est",
 "Latn",
}
m["ckr"] = {
 "Kairak",
 3503002,
 "paa-bng",
 "Latn",
}
m["cks"] = {
 "Tayo",
 1133089,
 "crp",
 "Latn",
 ancestors = "fr",
 sort_key = s["roa-oil-sortkey"],
}
m["ckt"] = {
 "Chukchi",
 33170,
 "qfa-cka",
 "Cyrl",
 entry_name = {
  from = {"['’]"},
  to = {"ʼ"}
 },
 sort_key = {
  from = {"ё", "ӄ", "ԓ", "ӈ"},
  to = {"е" .. p[1], "к" .. p[1], "л" .. p[1], "н" .. p[1]}
 },
}
m["cku"] = {
 "Koasati",
 35162,
 "nai-mus",
 "Latn",
}
m["ckv"] = {
 "Kavalan",
 716627,
 "map",
 "Latn",
}
m["ckx"] = {
 "Caka",
 5018037,
 "nic-tvc",
 "Latn",
}
m["cky"] = {
 "Cakfem-Mushere",
 3441199,
 "cdc-wst",
 "Latn",
}
m["ckz"] = {
 "Cakchiquel-Quiché Mixed Language",
 5054550,
 "myn",
 "Latn",
}
m["cla"] = {
 "Ron",
 3440432,
 "cdc-wst",
 "Latn",
}
m["clc"] = {
 "Chilcotin",
 28535,
 "ath-nor",
 "Latn",
}
m["cld"] = {
 "Chaldean Neo-Aramaic",
 33236,
 "sem-are",
 "Syrc",
 entry_name = "Syrc-entryname",
}
m["cle"] = {
 "Lealao Chinantec",
 6509365,
 "omq-chi",
 "Latn",
}
m["clh"] = {
 "Chilisso",
 3250629,
 "inc-dar",
}
m["cli"] = {
 "Chakali",
 35206,
 "nic-gnw",
 "Latn",
}
m["clj"] = {
 "Laitu Chin",
 6474196,
 "tbq-kuk",
}
m["clk"] = {
 "Idu",
 56412,
 "sit-gsi",
 "Tibt, Deva",
 translit = {Tibt = "Tibt-translit"},
 override_translit = true,
 display_text = {Tibt = s["Tibt-displaytext"]},
 entry_name = {Tibt = s["Tibt-entryname"]},
 sort_key = {Tibt = "Tibt-sortkey"},
}
m["cll"] = {
 "Chala",
 35190,
 "nic-gne",
 "Latn",
}
m["clm"] = {
 "Klallam",
 33404,
 "sal",
 "Latn",
}
m["clo"] = {
 "Lowland Oaxaca Chontal",
 2964450,
 "nai-tqn",
 "Latn",
}
m["clt"] = {
 "Lautu Chin",
 6502107,
 "tbq-kuk",
}
m["clu"] = {
 "Caluyanun",
 32964,
 "phi",
 "Latn",
}
m["clw"] = {
 "Chulym",
 33125,
 "trk-sib",
 "Latn, Cyrl",
}
m["cly"] = {
 "Eastern Highland Chatino",
 12642078,
 "omq-cha",
 "Latn",
}
m["cma"] = {
 "Maa",
 12953680,
 "mkh-ban",
 "Latn",
}
m["cme"] = {
 "Cerma",
 35074,
 "nic-gur",
 "Latn",
}
m["cmg"] = {
 "Classical Mongolian",
 5128303,
 "xgn-cen",
 "Mong, Soyo, Zanb",
 translit = {Mong = "Mong-translit"},
 display_text = {Mong = s["Mong-displaytext"]},
 entry_name = {Mong = s["Mong-entryname"]},
}
m["cmi"] = {
 "Emberá-Chamí",
 3052042,
 "sai-chc",
 "Latn",
}
m["cml"] = {
 "Campalagian",
 5027893,
 "poz-ssw",
 "Latn",
}
m["cmm"] = {
 "Michigamea",
 12636809,
 "sio-msv",
 "Latn",
}
m["cmn"] = {
 "Mandarin",
 9192,
 "zhx",
 "Hani, Hant, Hans, Latn, Bopo",
 wikimedia_codes = "zh",
 ancestors = "ltc",
 generate_forms = "zh-generateforms",
 translit = {
  Hani = "zh-translit",
  Bopo = "zh-translit",
 },
 sort_key = {
  Hani = "Hani-sortkey",
  Latn = {
   from = {
    -- Sort terms with tone numbers immediately after equivalent terms with diacritics.
    "[aeiouv][" .. c.circ .. c.diaer .. "]?[nr]?g?[0-5]",
    -- Add temporary breaks between syllables.
    "([aeiouvmn][" .. c.circ .. c.diaer .. "]?[" .. c.macron .. c.acute .. c.caron .. c.grave .. "]?n?ŋ?g?r?)([bpmfdtnlgkhjqxzcsywrv']h?[aeiouvmn ])", p[1] .. "([ngr])$", p[1] .. "([ngr][%s%-'" .. p[1] .. "])",
    -- Substitute diacritics for syllable-final tone numbers, and add tone 0 where necessary.
    c.macron, c.acute, c.caron, c.grave, "([1-4])([^%s%p" .. p[1] .. "]+)", "([^0-5])%f[%z%s%p" .. p[1] .. "]",
    -- Substitute "v" shorthand for "ü" for a temporary placeholder, so that the (very rare) "v" initial is not affected by the later shorthand substitutions.
    "([^ " .. p[1] .. "])v",
    -- Remove temporary breaks.
    p[1],
    -- Substitute shorthands for full forms, and sort them immediately after equivalent terms.
    "%S*[csz]" .. c.circ .. "%S*", "%S*[ŋ" .. p[2] .. "]%S*", "ĉ", "ŝ", "ŋ", p[2], "ẑ",
    -- "ê" comes after "e", "ü" comes after "u" and apostrophes are removed (as their function is replaced by tone numbers).
    "[" .. c.circ .. c.diaer .. "]", "'",
    -- Sort numbered tone 5 after tone 0.
    "5!"
   },
   to = {
    "%0!",
    "%1" .. p[1] .. "%2", "%1", "%1",
    "1", "2", "3", "4", "%2%1", "%10",
    "%1" .. p[2],
    "",
    "%0\"", "%0\"", "ch", "sh", "ng", "ü", "zh",
    p[1], "",
    "0!!"
   }
  },
 },
}
m["cmo"] = {
 "Central Mnong",
 33369881,
 "mkh-ban",
}
m["cmr"] = {
 "Mro Chin",
 16889978,
 "tbq-kuk",
}
m["cms"] = {
 "Messapic",
 36383,
 "ine",
 "Latn, Ital, Grek",
}
m["cmt"] = {
 "Camtho",
 10441336,
 "crp",
 "Latn",
 ancestors = "fly, zu"
}
m["cna"] = {
 "Changthang",
 12952322,
 "sit-lab",
 "Tibt",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["cnb"] = {
 "Chinbon Chin",
 12952327,
 "tbq-kuk",
}
m["cnc"] = {
 "Côông",
 5202780,
 "tbq-lol",
}
m["cng"] = {
 "Northern Qiang",
 56559,
 "sit-qia",
}
m["cnh"] = {
 "Lai",
 3250286,
 "tbq-kuk",
}
m["cni"] = {
 "Asháninka",
 3437230,
 "awd",
 "Latn",
}
m["cnk"] = {
 "Khumi Chin",
 56308,
 "tbq-kuk",
}
m["cnl"] = {
 "Lalana Chinantec",
 12953437,
 "omq-chi",
 "Latn",
}
m["cno"] = {
 "Con",
 3440883,
 "mkh-pal",
}
m["cns"] = {
 "Central Asmat",
 11732048,
 "ngf",
 "Latn",
}
m["cnt"] = {
 "Tepetotutla Chinantec",
 5100113,
 "omq-chi",
 "Latn",
}
m["cnu"] = {
 "Chenoua",
 33276,
 "ber",
}
m["cnw"] = {
 "Ngawn Chin",
 6583675,
 "tbq-kuk",
}
m["cnx"] = {
 "Middle Cornish",
 12642603,
 "cel-bry",
 "Latn",
 ancestors = "oco",
}
m["coa"] = {
 "Cocos Islands Malay",
 3441699,
 "crp",
 "Latn",
 ancestors = "ms",
}
m["cob"] = {
 "Chicomuceltec",
 3307204,
 "myn",
 "Latn",
}
m["coc"] = {
 "Cocopa",
 33044,
 "nai-yuc",
 "Latn",
}
m["cod"] = {
 "Cocama",
 33317,
 "tup",
 "Latn",
}
m["coe"] = {
 "Koreguaje",
 3198924,
 "sai-tuc",
 "Latn",
}
m["cof"] = {
 "Tsafiki",
 2567055,
 "sai-bar",
 "Latn",
}
m["cog"] = {
 "Chong",
 3914630,
 "mkh-pea",
 "Thai, Khmr",
 sort_key = {Thai = "Thai-sortkey"},
}
m["coh"] = {
 "Chichonyi-Chidzihana-Chikauma",
 12629011,
 "bnt-mij",
 "Latn",
}
m["coj"] = {
 "Cochimi",
 3915551,
 "nai-yuc",
 "Latn",
}
m["cok"] = {
 "Santa Teresa Cora",
 12641754,
 "azc",
 "Latn",
}
m["col"] = {
 "Columbia-Wenatchi",
 3324744,
 "sal",
 "Latn",
}
m["com"] = {
 "Comanche",
 32972,
 "azc-num",
 "Latn",
}
m["con"] = {
 "Cofán",
 2669254,
 "qfa-iso",
 "Latn",
}
m["coo"] = {
 "Comox",
 13583746,
 "sal",
 "Latn",
}
m["cop"] = {
 "Coptic",
 36155,
 "egx",
 "Copt",
 translit = "Copt-translit",
 ancestors = "egx-dem",
 entry_name = {remove_diacritics = c.grave .. c.macron .. c.overline .. c.diaer .. "ˋ"},
 sort_key = "cop-sortkey",
}
m["coq"] = {
 "Coquille",
 12953452,
 "ath-pco",
 "Latn",
}
m["cot"] = {
 "Caquinte",
 3915557,
 "awd",
 "Latn",
}
m["cou"] = {
 "Wamey",
 36935,
 "alv-ten",
 "Latn",
}
m["cov"] = {
 "Cao Miao",
 2936935,
 "qfa-tak",
}
m["cow"] = {
 "Cowlitz",
 3001877,
 "sal",
 "Latn",
}
m["cox"] = {
 "Nanti",
 15342275,
 "awd",
 "Latn",
}
m["coy"] = {
 "Coyaima",
 56450,
 "sai-car",
 "Latn",
}
m["coz"] = {
 "Chochotec",
 2964262,
 "omq-pop",
 "Latn",
}
m["cpa"] = {
 "Palantla Chinantec",
 5100112,
 "omq-chi",
 "Latn",
}
m["cpb"] = {
 "Ucayali-Yurúa Ashéninka",
 3501858,
 "awd",
 "Latn",
}
m["cpc"] = {
 "Ajyíninka Apurucayali",
 3327405,
 "awd",
 "Latn",
}
m["cpg"] = {
 "Cappadocian Greek",
 853414,
 "grk",
 "Grek, fa-Arab",
 ancestors = "gkm",
 translit = {Grek = "el-translit"},
 entry_name = {Grek = {remove_diacritics = c.caron .. c.diaerbelow .. c.brevebelow}},
 sort_key = {Grek = s["Grek-sortkey"]},
}
m["cpi"] = {
 "Chinese Pidgin English",
 3435078,
 "crp",
 "Latn, Hant",
 ancestors = "en",
 sort_key = {Hant = "Hani-sortkey"},
}
m["cpn"] = {
 "Cherepon",
 35181,
 "alv-gng",
 "Latn",
}
m["cpo"] = {
 "Kpee",
 6435722,
 "dmn-jje",
}
m["cps"] = {
 "Capiznon",
 2937525,
 "phi",
 "Latn",
}
m["cpu"] = {
 "Pichis Ashéninka",
 7190661,
 "awd",
 "Latn",
}
m["cpx"] = {
 "Puxian",
 56583,
 "zhx-min-hai",
 "Hani, Hant, Hans",
 generate_forms = "zh-generateforms",
 sort_key = "Hani-sortkey",
}
m["cpy"] = {
 "South Ucayali Ashéninka",
 3501868,
 "awd",
 "Latn",
}
m["cqd"] = {
 "Chuanqiandian Cluster Miao",
 3307894,
 "hmn",
 "Latn, Plrd",
}
m["cra"] = {
 "Chara",
 5073694,
 "omv",
 "Latn",
}
m["crb"] = {
 "Island Carib",
 3450735,
 "awd-taa",
 "Latn",
}
m["crc"] = {
 "Lonwolwol",
 3259216,
 "poz-oce",
 "Latn",
}
m["crd"] = {
 "Coeur d'Alene",
 32915,
 "sal",
 "Latn",
}
m["crf"] = {
 "Caramanta",
 3504195,
 "sai-chc",
 "Latn",
}
m["crg"] = {
 "Michif",
 13315,
 "qfa-mix",
 "Latn",
 ancestors = "cr, fr",
}
m["crh"] = {
 "Crimean Tatar",
 33357,
 "trk-kcu",
 "Latn, Cyrl",
 dotted_dotless_i = true,
 sort_key = {
  Latn = {
   from = {
    "[ıi]" .. c.breve, -- Convert ĭ into PUA so that the  decomposed form does not get caught by the next step. Also cover decomposed forms with ı and i, as decomposed Ĭ is converted to ı + ̆ due to the dotted dotless I logic).
    "i", -- Ensure "i" comes after "ı".
    "â", "ç", "ğ", "ı", p[3], "ñ", "ö", "ş", "ü"
   },
   to = {
    p[3],
    "i" .. p[1],
    "a", "c" .. p[1], "g" .. p[1], "i", "i" .. p[2], "n" .. p[1], "o" .. p[1], "s" .. p[1], "u" .. p[1],
   }
  },
  Cyrl = {
   from = {"гъ", "ё", "къ", "нъ", "дж"},
   to = {"г" .. p[1], "е" .. p[1], "к" .. p[1], "н" .. p[1], "ч" .. p[1]}
  },
 },
}
m["cri"] = {
 "Sãotomense",
 36536,
 "crp",
 "Latn",
 ancestors = "pt",
}
m["crj"] = {
 "Southern East Cree",
 12953464,
 "alg",
 "Cans",
 ancestors = "cr",
 translit = "cr-translit",
}
m["crk"] = {
 "Plains Cree",
 56699,
 "alg",
 "Cans, Latn",
 ancestors = "cr",
}
m["crl"] = {
 "Northern East Cree",
 12642195,
 "alg",
 "Cans",
 ancestors = "cr",
 translit = "cr-translit",
}
m["crm"] = {
 "Moose Cree",
 3446671,
 "alg",
 "Cans",
 ancestors = "cr",
}
m["crn"] = {
 "Cora",
 12953454,
 "azc",
 "Latn",
}
m["cro"] = {
 "Crow",
 1207611,
 "sio-mor",
 "Latn",
}
m["crq"] = {
 "Iyo'wujwa Chorote",
 3540927,
 "sai-mtc",
 "Latn",
}
m["crr"] = {
 "Carolina Algonquian",
 16113723,
 "alg-eas",
 "Latn",
}
m["crs"] = {
 "Seychellois Creole",
 34015,
 "crp",
 "Latn",
 ancestors = "fr",
 sort_key = s["roa-oil-sortkey"],
}
m["crt"] = {
 "Iyojwa'ja Chorote",
 3504118,
 "sai-mtc",
 "Latn",
}
m["crv"] = {
 "Chaura",
 2605680,
 "aav-nic",
}
m["crw"] = {
 "Chrau",
 5105629,
 "mkh-ban",
 "Latn",
}
m["crx"] = {
 "Carrier",
 12953431,
 "ath-nor",
 "Latn, Cans",
}
m["cry"] = {
 "Cori",
 35204,
 "nic-plc",
 "Latn",
}
m["crz"] = {
 "Cruzeño",
 2967636,
 "nai-chu",
 "Latn",
}
m["csa"] = {
 "Chiltepec Chinantec",
 12953435,
 "omq-chi",
 "Latn",
}
m["csb"] = {
 "Kashubian",
 33690,
 "zlw-pom",
 "Latn",
 ancestors = "zlw-pom-pro",
}
m["csc"] = {
 "Catalan Sign Language",
 35768,
 "sgn",
 "Latn", -- when documented
}
m["csd"] = {
 "Chiangmai Sign Language",
 5095211,
 "sgn",
}
m["cse"] = {
 "Czech Sign Language",
 5201809,
 "sgn",
 "Latn", -- when documented
}
m["csf"] = {
 "Cuban Sign Language",
 5192046,
 "sgn",
 "Latn", -- when documented
}
m["csg"] = {
 "Chilean Sign Language",
 3322112,
 "sgn",
 "Latn", -- when documented
}
m["csh"] = {
 "Asho Chin",
 12627282,
 "tbq-kuk",
}
m["csi"] = {
 "Coast Miwok",
 2981109,
 "nai-you",
 "Latn",
}
m["csj"] = {
 "Songlai Chin",
 7561280,
 "tbq-kuk",
}
m["csk"] = {
 "Jola-Kasa",
 3446622,
 "alv-jol",
 "Latn",
}
m["csl"] = {
 "Chinese Sign Language",
 1094190,
 "sgn",
}
m["csm"] = {
 "Central Sierra Miwok",
 2944443,
 "nai-you",
 "Latn",
}
m["csn"] = {
 "Colombian Sign Language",
 2748229,
 "sgn",
 "Latn", -- when documented
}
m["cso"] = {
 "Sochiapam Chinantec",
 7550388,
 "omq-chi",
 "Latn",
}
m["csq"] = {
 "Croatian Sign Language",
 3507506,
 "sgn",
}
m["csr"] = {
 "Costa Rican Sign Language",
 5174901,
 "sgn",
 "Latn", -- when documented
}
m["css"] = {
 "Southern Ohlone",
 25559664,
 "nai-you",
 "Latn",
}
m["cst"] = {
 "Northern Ohlone",
 25559666,
 "nai-you",
 "Latn",
}
m["csv"] = {
 "Sumtu Chin",
 7638087,
 "tbq-kuk",
}
m["csw"] = {
 "Swampy Cree",
 56696,
 "alg",
 "Latn, Cans",
 ancestors = "cr",
}
m["csy"] = {
 "Siyin Chin",
 7533375,
 "tbq-kuk",
}
m["csz"] = {
 "Coos",
 3126783,
 "nai-coo",
 "Latn",
}
m["cta"] = {
 "Tataltepec Chatino",
 7687853,
 "omq-cha",
 "Latn",
}
m["ctc"] = {
 "Chetco-Tolowa",
 12628946,
 "ath-pco",
 "Latn",
}
m["ctd"] = {
 "Tedim Chin",
 56357,
 "tbq-kuk",
 "Latn, Pauc",
}
m["cte"] = {
 "Tepinapa Chinantec",
 12953443,
 "omq-chi",
 "Latn",
}
m["ctg"] = {
 "Chittagonian",
 33173,
 "inc-eas",
 "Beng",
 ancestors = "inc-obn",
}
m["cth"] = {
 "Thaiphum Chin",
 16912048,
 "tbq-kuk",
}
m["ctl"] = {
 "Tlacoatzintepec Chinantec",
 12643657,
 "omq-chi",
 "Latn",
}
m["ctm"] = {
 "Chitimacha",
 1294227,
 "qfa-iso",
 "Latn",
}
m["ctn"] = {
 "Chhintange",
 32994,
 "sit-kie",
 "Deva",
}
m["cto"] = {
 "Emberá-Catío",
 3052039,
 "sai-chc",
 "Latn",
}
m["ctp"] = {
 "Western Highland Chatino",
 32861734,
 "omq-cha",
 "Latn",
 entry_name = {remove_diacritics = "¹²³⁴⁵"},
 sort_key = {remove_diacritics = c.acute},
}
m["cts"] = {
 "Northern Catanduanes Bicolano",
 7130477,
 "phi",
 "Latn",
}
m["ctt"] = {
 "Wayanad Chetti",
 7975850,
 "dra",
 "Taml",
}
m["ctu"] = {
 "Chol",
 35179,
 "myn",
 "Latn",
}
m["ctz"] = {
 "Zacatepec Chatino",
 8063754,
 "omq-cha",
 "Latn",
}
m["cua"] = {
 "Cua",
 3441115,
 "mkh-ban",
 "Latn",
}
m["cub"] = {
 "Cubeo",
 3006705,
 "sai-tuc",
 "Latn",
}
m["cuc"] = {
 "Usila Chinantec",
 7901979,
 "omq-chi",
 "Latn",
}
m["cug"] = {
 "Cung",
 35194,
 "nic-bbe",
 "Latn",
}
m["cuh"] = {
 "Chuka",
 12952344,
 "bnt-kka",
 "Latn",
}
m["cui"] = {
 "Cuiba",
 2980421,
 "sai-guh",
 "Latn",
}
m["cuj"] = {
 "Mashco Piro",
 3446596,
 "awd",
 "Latn",
}
m["cuk"] = {
 "Kuna",
 12953659,
 "cba",
 "Latn",
}
m["cul"] = {
 "Culina",
 2475442,
 "auf",
 "Latn",
}
m["cuo"] = {
 "Cumanagoto",
 5193784,
 "sai-cpc",
 "Latn",
}
m["cup"] = {
 "Cupeño",
 143130,
 "azc-cup",
 "Latn",
}
m["cuq"] = {
 "Cun",
 2475478,
 "qfa-lic",
 "Latn",
}
m["cur"] = {
 "Chhulung",
 5116126,
 "sit-kie",
 "Deva",
}
m["cut"] = {
 "Teutila Cuicatec",
 12953453,
 "omq-cui",
 "Latn",
}
m["cuu"] = {
 "Tai Ya",
 3441122,
 "qfa-tak",
 "Latn",
}
m["cuv"] = {
 "Cuvok",
 3515056,
 "cdc-cbm",
 "Latn",
}
m["cuw"] = {
 "Chukwa",
 12629033,
 "sit-kic",
}
m["cux"] = {
 "Tepeuxila Cuicatec",
 20527242,
 "omq-cui",
 "Latn",
}
m["cuy"] = {
 "Cuitlatec",
 2030998,
 "qfa-iso",
 "Latn",
}
m["cvg"] = {
 "Chug",
 47683644,
 "sit-khb",
}
m["cvn"] = {
 "Valle Nacional Chinantec",
 12953442,
 "omq-chi",
 "Latn",
}
m["cwa"] = {
 "Kabwa",
 6344537,
 "bnt-lok",
 "Latn",
}
m["cwb"] = {
 "Maindo",
 11002891,
 "bnt-mak",
 "Latn",
 ancestors = "chw",
}
m["cwd"] = {
 "Woods Cree",
 56305,
 "alg",
 "Latn, Cans",
 ancestors = "cr",
}
m["cwe"] = {
 "Kwere",
 779632,
 "bnt-ruv",
 "Latn",
}
m["cwg"] = {
 "Chewong",
 646718,
 "mkh-asl",
 "Latn",
}
m["cwt"] = {
 "Kuwaataay",
 35699,
 "alv-jol",
 "Latn",
}
m["cya"] = {
 "Nopala Chatino",
 15616302,
 "omq-cha",
 "Latn",
}
m["cyb"] = {
 "Cayubaba",
 3183382,
 "qfa-iso",
 "Latn",
}
m["cyo"] = {
 "Cuyunon",
 33153,
 "phi",
 "Latn",
}
m["czh"] = {
 "Huizhou",
 56546,
 "zhx",
 "Hani, Hant, Hans", -- ?
 ancestors = "ltc",
 generate_forms = "zh-generateforms",
 sort_key = "Hani-sortkey",
}
m["czk"] = {
 "Knaanic",
 56384,
 "zlw",
 "Hebr",
 ancestors = "zlw-ocs",
 entry_name = {Hebr = {remove_diacritics = u(0x0591) .. "-" .. u(0x05BD) .. u(0x05BF) .. "-" .. u(0x05C5) .. u(0x05C7) .. c.CGJ}},
}
m["czn"] = {
 "Zenzontepec Chatino",
 603106,
 "omq-cha",
 "Latn",
}
m["czo"] = {
 "Min Zhong",
 56435,
 "zhx-min-shn",
 "Hani, Hant, Hans",
 generate_forms = "zh-generateforms",
 sort_key = "Hani-sortkey",
}
m["czt"] = {
 "Zotung Chin",
 8074599,
 "tbq-kuk",
 "Latn",
}
m["daa"] = {
 "Dangaléat",
 942591,
 "cdc-est",
 "Latn",
}
m["dac"] = {
 "Dambi",
 12629491,
 "poz-ocw",
 "Latn",
}
m["dad"] = {
 "Marik",
 6763404,
 "poz-ocw",
 "Latn",
}
m["dae"] = {
 "Duupa",
 35263,
 "alv-dur",
 "Latn",
}
m["dag"] = {
 "Dagbani",
 32238,
 "nic-dag",
 "Latn",
}
m["dah"] = {
 "Gwahatike",
 5623246,
 "ngf-fin",
 "Latn",
}
m["dai"] = {
 "Day",
 35163,
 "alv-mbd",
 "Latn",
}
m["daj"] = {
 "Dar Fur Daju",
 56370,
 "sdv-daj",
 "Latn",
}
m["dak"] = {
 "Dakota",
 530384,
 "sio-dkt",
 "Latn",
}
m["dal"] = {
 "Dahalo",
 35143,
 "cus",
 "Latn",
}
m["dam"] = {
 "Damakawa",
 1158134,
 "nic-knn",
 "Latn",
}
m["dao"] = {
 "Daai Chin",
 860029,
 "tbq-kuk",
 "Latn",
}
m["daq"] = {
 "Dandami Maria",
 12952805,
 "dra",
 ancestors = "gon",
}
m["dar"] = {
 "Dargwa",
 32332,
 "cau-drg",
 "Cyrl, Latn, Arab",
 translit = {Cyrl = "dar-translit"},
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
 sort_key = {
  Cyrl = {
   from = {
    "къкъ", "хьхь", -- 4 chars
    "гъ", "гь", "гӏ", "ё", "къ", "кь", "кӏ", "пп", "пӏ", "сс", "тт", "тӏ", "хх", "хъ", "хь", "хӏ", "цц", "цӏ", "чч", "чӏ" -- 2 chars
   },
   to = {
    "к" .. p[2], "х" .. p[4],
    "г" .. p[1], "г" .. p[2], "г" .. p[3], "е" .. p[1], "к" .. p[1], "к" .. p[3], "к" .. p[4], "п" .. p[1], "п" .. p[2], "с" .. p[1], "т" .. p[1], "т" .. p[2], "х" .. p[1], "х" .. p[2], "х" .. p[3], "х" .. p[5], "ц" .. p[1], "ц" .. p[2], "ч" .. p[1], "ч" .. p[2]
   }
  },
 },
}
m["das"] = {
 "Daho-Doo",
 3915369,
 "kro-wee",
 "Latn",
}
m["dau"] = {
 "Dar Sila Daju",
 7514020,
 "sdv-daj",
 "Latn",
}
m["dav"] = {
 "Taita",
 2387274,
 "bnt-cht",
 "Latn",
}
m["daw"] = {
 "Davawenyo",
 5228174,
 "phi",
 "Latn",
}
m["dax"] = {
 "Dayi",
 10467281,
 "aus-yol",
 "Latn",
}
m["daz"] = {
 "Dao",
 5221513,
 "ngf",
 "Latn",
}
m["dba"] = {
 "Bangime",
 1982696,
 "qfa-iso",
 "Latn",
}
m["dbb"] = {
 "Deno",
 56275,
 "cdc-wst",
 "Latn",
}
m["dbd"] = {
 "Dadiya",
 3914436,
 "alv-wjk",
 "Latn",
}
m["dbe"] = {
 "Dabe",
 5207451,
 "paa-tkw",
 "Latn",
}
m["dbf"] = {
 "Edopi",
 12953516,
 "paa-lkp",
 "Latn",
}
m["dbg"] = {
 "Dogul Dom",
 3912880,
 "nic-npd",
 "Latn",
}
m["dbi"] = {
 "Doka",
 3913293,
 "nic-plc",
 "Latn",
}
m["dbj"] = {
 "Ida'an",
 3041552,
 "poz-san",
 "Latn",
}
m["dbl"] = {
 "Dyirbal",
 35465,
 "aus-dyb",
 "Latn",
}
m["dbm"] = {
 "Duguri",
 7194057,
 "nic-jrw",
 "Latn",
}
m["dbn"] = {
 "Duriankere",
 5316627,
 "ngf-sbh",
 "Latn",
}
m["dbo"] = {
 "Dulbu",
 5313310,
 "nic-jrn",
 "Latn",
}
m["dbp"] = {
 "Duwai",
 56301,
 "cdc-wst",
 "Latn",
}
m["dbq"] = {
 "Daba",
 3913342,
 "cdc-cbm",
 "Latn",
}
m["dbr"] = {
 "Dabarre",
 3447286,
 "cus-som",
}
m["dbt"] = {
 "Ben Tey",
 4886561,
 "nic-nwa",
 "Latn",
}
m["dbu"] = {
 "Bondum Dom Dogon",
 3912758,
 "nic-npd",
 "Latn",
}
m["dbv"] = {
 "Dungu",
 5315230,
 "nic-kau",
 "Latn",
}
m["dbw"] = {
 "Bankan Tey Dogon",
 4856243,
 "nic-nwa",
 "Latn",
}
m["dby"] = {
 "Dibiyaso",
 5272268,
 "ngf",
 "Latn",
}
m["dcc"] = {
 "Deccani",
 669431,
 "inc-hnd",
 "ur-Arab",
 ancestors = "ur",
}
m["dcr"] = {
 "Negerhollands",
 1815830,
 "crp",
 "Latn",
 ancestors = "nl",
}
m["dda"] = {
 "Dadi Dadi",
 nil,
 "aus-pam",
 "Latn",
}
m["ddd"] = {
 "Dongotono",
 56676,
 "sdv-lma",
}
m["dde"] = {
 "Doondo",
 11003401,
 "bnt-kng",
 "Latn",
}
m["ddg"] = {
 "Fataluku",
 35353,
 "qfa-tap",
 "Latn",
}
m["ddi"] = {
 "Diodio",
 3028668,
 "poz-ocw",
 "Latn",
}
m["ddj"] = {
 "Jaru",
 3162806,
 "aus-pam",
 "Latn",
}
m["ddn"] = {
 "Dendi",
 35164,
 "son",
 "Latn",
}
m["ddo"] = {
 "Tsez",
 34033,
 "cau-wts",
 "Cyrl",
 translit = "ddo-translit",
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
}
m["ddr"] = {
 "Dhudhuroa",
 5269842,
 "aus-pam",
 "Latn",
}
m["dds"] = {
 "Donno So Dogon",
 1234776,
 "nic-dge",
 "Latn",
}
m["ddw"] = {
 "Dawera-Daweloor",
 5242304,
 "poz-tim",
 "Latn",
}
m["dec"] = {
 "Dagik",
 35125,
 "alv-tal",
 "Latn",
}
m["ded"] = {
 "Dedua",
 5249850,
 "ngf",
 "Latn",
}
m["dee"] = {
 "Dewoin",
 3914892,
 "kro-wkr",
 "Latn",
}
m["def"] = {
 "Dezfuli",
 4115412,
 "ira-swi",
}
m["deg"] = {
 "Degema",
 35182,
 "alv-dlt",
 "Latn",
}
m["deh"] = {
 "Dehwari",
 5704314,
 "ira-swi",
 ancestors = "fa",
}
m["dei"] = {
 "Demisa",
 56380,
 "paa-egb",
 "Latn",
}
m["dek"] = { -- called "unattested alleged language" by Wikipedia
 "Dek",
 5252754,
 nil,
 "Latn",
}
m["dem"] = {
 "Dem",
 5254989,
 "paa",
 "Latn",
}
m["dep"] = {
 "Pidgin Delaware",
 nil,
 "crp",
 "Latn",
 ancestors = "unm",
}
-- deq is not included, see [[WT:LT]]
m["der"] = {
 "Deori",
 56478,
 "tbq-bdg",
 "Beng, Latn",
}
m["des"] = {
 "Desano",
 962392,
 "sai-tuc",
 "Latn",
}
m["dev"] = {
 "Domung",
 5291378,
 "ngf-fin",
 "Latn",
}
m["dez"] = {
 "Dengese",
 2909984,
 "bnt-tet",
 "Latn",
}
m["dga"] = {
 "Southern Dagaare",
 35159,
 "nic-mre",
 "Latn",
}
m["dgb"] = {
 "Bunoge",
 4985178,
 "nic-dgw",
 "Latn",
}
m["dgc"] = {
 "Casiguran Dumagat Agta",
 5313599,
 "phi",
 "Latn",
}
m["dgd"] = {
 "Dagaari Dioula",
 11153465,
 "nic-mre",
 "Latn",
}
m["dge"] = {
 "Degenan",
 5251770,
 "ngf-fin",
 "Latn",
}
m["dgg"] = {
 "Doga",
 3033726,
 "poz-ocw",
 "Latn",
}
m["dgh"] = {
 "Dghwede",
 56293,
 "cdc-cbm",
 "Latn",
}
m["dgi"] = {
 "Northern Dagara",
 11004218,
 "nic-mre",
 "Latn",
}
m["dgk"] = {
 "Dagba",
 12952357,
 "csu-sar",
 "Latn",
}
m["dgn"] = {
 "Dagoman",
 10465931,
 "aus-yng",
 "Latn",
}
m["dgo"] = {
 "Hindi Dogri",
 nil,
 "him",
 "Deva, Arab, Takr",
 ancestors = "doi",
}
m["dgr"] = {
 "Dogrib",
 20979,
 "ath-nor",
 "Latn",
}
m["dgs"] = {
 "Dogoso",
 35343,
 "nic-gur",
}
m["dgt"] = {
 "Ntra'ngith",
 6983809,
 "aus-pam",
 "Latn",
}
-- dgu is not a language; see [[w:Dhekaru]]
m["dgw"] = {
 "Daungwurrung",
 5228050,
 "aus-pam",
 "Latn",
}
m["dgx"] = {
 "Doghoro",
 12952392,
 "ngf",
 "Latn",
}
m["dgz"] = {
 "Daga",
 5208442,
 "ngf",
 "Latn",
}
m["dhg"] = {
 "Dhangu",
 5268960,
 "aus-yol",
 "Latn",
}
m["dhi"] = {
 "Dhimal",
 35229,
 "sit-dhi",
 "Deva",
}
m["dhl"] = {
 "Dhalandji",
 5268787,
 "aus-psw",
 "Latn",
}
m["dhm"] = {
 "Zemba",
 3502283,
 "bnt-swb",
 "Latn",
 ancestors = "hz",
}
m["dhn"] = {
 "Dhanki",
 5268992,
 "inc-bhi",
}
m["dho"] = {
 "Dhodia",
 5269658,
 "inc-bhi",
 "Deva",
}
m["dhr"] = {
 "Tharrgari",
 10470289,
 "aus-psw",
 "Latn",
}
m["dhs"] = {
 "Dhaiso",
 11001788,
 "bnt-kka",
 "Latn",
}
m["dhu"] = {
 "Dhurga",
 1285318,
 "aus-yuk",
 "Latn",
}
m["dhv"] = {
 "Drehu",
 3039319,
 "poz-cln",
 "Latn",
}
m["dhw"] = {
 "Danuwar",
 3522797,
 "inc-bhi",
 "Deva",
}
m["dhx"] = {
 "Dhungaloo",
 16960599,
 "aus-pam",
 "Latn",
}
m["dia"] = {
 "Dia",
 3446591,
 "qfa-tor",
 "Latn",
}
m["dib"] = {
 "South Central Dinka",
 35154,
 "sdv-dnu",
 "Latn",
 ancestors = "din",
}
m["dic"] = {
 "Lakota Dida",
 11001730,
 "kro-did",
 "Latn",
}
m["did"] = {
 "Didinga",
 56365,
 "sdv",
 "Latn",
}
m["dif"] = {
 "Dieri",
 25559563,
 "aus-kar",
 "Latn",
}
m["dig"] = {
 "Digo",
 3362072,
 "bnt-mij",
 "Latn",
}
-- "dih" IS SPLIT INTO nai-ipa, nai-kum, nai-tip, SEE WT:LT
m["dii"] = {
 "Dimbong",
 35196,
 "bnt-baf",
 "Latn",
}
m["dij"] = {
 "Dai",
 5209056,
 "poz-tim",
}
m["dik"] = {
 "Southwestern Dinka",
 36540,
 "sdv-dnu",
 "Latn",
 ancestors = "din",
}
m["dil"] = {
 "Dilling",
 35152,
 "nub-hil",
 "Latn",
}
m["dim"] = {
 "Dime",
 35311,
 "omv-aro",
}
m["din"] = {
 "Dinka",
 56466,
 "sdv-dnu",
 "Latn",
}
m["dio"] = {
 "Dibo",
 3914891,
 "alv-ngb",
 "Latn",
}
m["dip"] = {
 "Northeastern Dinka",
 36246,
 "sdv-dnu",
 "Latn",
 ancestors = "din",
}
m["dir"] = {
 "Dirim",
 11130804,
 "nic-dak",
 "Latn",
}
m["dis"] = {
 "Dimasa",
 56664,
 "tbq-bdg",
 "Latn, Beng",
}
m["diu"] = {
 "Gciriku",
 3780954,
 "bnt-kav",
 "Latn",
}
m["diw"] = {
 "Northwestern Dinka",
 36249,
 "sdv-dnu",
 "Latn",
 ancestors = "din",
}
m["dix"] = {
 "Dixon Reef",
 5284967,
 "poz-vnc",
 "Latn",
}
m["diy"] = {
 "Diuwe",
 5283765,
 "ngf",
}
m["diz"] = {
 "Ding",
 35202,
 "bnt-bdz",
 "Latn",
}
m["dja"] = {
 "Djadjawurrung",
 5285190,
 "aus-pam",
 "Latn",
}
m["djb"] = {
 "Djinba",
 5285351,
 "aus-yol",
 "Latn",
}
m["djc"] = {
 "Dar Daju Daju",
 5209890,
 "sdv-daj",
 "Latn",
}
m["djd"] = {
 "Jaminjung",
 6147825,
 "aus-mir",
 "Latn",
}
m["dje"] = {
 "Zarma",
 36990,
 "son",
 "Latn, Arab, Brai",
}
m["djf"] = {
 "Djangun",
 10474818,
 "aus-pmn",
 "Latn",
}
m["dji"] = {
 "Djinang",
 5285350,
 "aus-yol",
 "Latn",
}
m["djj"] = {
 "Ndjébbana",
 5285274,
 "aus-arn",
 "Latn",
}
m["djk"] = {
 "Aukan",
 2659044,
 "crp",
 "Latn, Afak",
 ancestors = "en",
}
m["djl"] = {
 "Djiwarli",
 nil,
 "aus-psw",
 "Latn",
}
m["djm"] = {
 "Jamsay",
 3913290,
 "nic-pld",
 "Latn",
}
m["djn"] = {
 "Djauan",
 13553748,
 "aus-gun",
 "Latn",
}
m["djo"] = {
 "Jangkang",
 12952388,
 "day",
}
m["djr"] = {
 "Djambarrpuyngu",
 3915679,
 "aus-yol",
 "Latn",
}
m["dju"] = {
 "Kapriman",
 6367199,
 "paa-spk",
 "Latn",
}
m["djw"] = {
 "Djawi",
 3913844,
 "aus-nyu",
 "Latn",
 ancestors = "bcj",
}
m["dka"] = {
 "Dakpa",
 3695189,
 "sit-ebo",
 "Tibt",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["dkk"] = {
 "Dakka",
 5209962,
 "poz-ssw",
}
m["dkr"] = {
 "Kuijau",
 13580777,
 "poz-bnn",
}
m["dks"] = {
 "Southeastern Dinka",
 36538,
 "sdv-dnu",
 "Latn",
 ancestors = "din",
}
m["dkx"] = {
 "Mazagway",
 6798209,
 "cdc-cbm",
 "Latn",
}
m["dlg"] = {
 "Dolgan",
 32878,
 "trk-sib",
 "Cyrl",
 sort_key = {
  from = {"ё", "һ", "ӈ", "ө", "ү"},
  to = {"е" .. p[1], "к" .. p[1], "н" .. p[1], "о" .. p[1], "у" .. p[1]}
 },
}
m["dlk"] = {
 "Dahalik",
 32260,
 "sem-eth",
 "Ethi",
 translit = "Ethi-translit",
}
m["dlm"] = {
 "Dalmatian",
 35527,
 "roa-itd",
 "Latn",
}
m["dln"] = {
 "Darlong",
 5224029,
 "tbq-kuk",
 "Latn",
}
m["dma"] = {
 "Duma",
 35319,
 "bnt-nze",
 "Latn",
}
m["dmb"] = {
 "Mombo Dogon",
 6897074,
 "nic-dgw",
 "Latn",
}
m["dmc"] = {
 "Gavak",
 5277406,
 "ngf-mad",
 "Latn",
}
m["dmd"] = {
 "Madhi Madhi",
 6727353,
 "aus-pam",
 "Latn",
}
m["dme"] = {
 "Dugwor",
 56313,
 "cdc-cbm",
 "Latn",
}
m["dmf"] = {
 "Medefaidrin",
 1519764,
 "art",
 "Medf",
 type = "appendix-constructed",
}
m["dmg"] = {
 "Upper Kinabatangan",
 16109975,
 "poz-san",
 "Latn",
}
m["dmk"] = {
 "Domaaki",
 32900,
 "inc-dar",
}
m["dml"] = {
 "Dameli",
 32288,
 "inc-dar",
}
m["dmm"] = {
 "Dama (Nigeria)",
 5211865,
 "alv-mbm",
 "Latn",
}
m["dmo"] = {
 "Kemezung",
 35562,
 "nic-bbe",
 "Latn",
}
m["dmr"] = {
 "East Damar",
 5328200,
 "poz-cet",
 "Latn",
}
m["dms"] = {
 "Dampelas",
 5212928,
 "poz-tot",
 "Latn",
}
m["dmu"] = {
 "Dubu",
 7692059,
 "paa-pau",
 "Latn",
}
m["dmv"] = {
 "Dumpas",
 12953512,
 "poz-san",
 "Latn",
}
m["dmw"] = {
 "Mudburra",
 6931573,
 "aus-pam",
 "Latn",
}
m["dmx"] = {
 "Dema",
 3553423,
 "bnt-sho",
 "Latn",
}
m["dmy"] = {
 "Demta",
 14466283,
 "paa-sen",
 "Latn",
}
m["dna"] = {
 "Upper Grand Valley Dani",
 12952361,
 "ngf",
 "Latn",
}
m["dnd"] = {
 "Daonda",
 5221528,
 "paa-brd",
 "Latn",
}
m["dne"] = {
 "Ndendeule",
 6983725,
 "bnt-mbi",
 "Latn",
}
m["dng"] = {
 "Dungan",
 33050,
 "zhx",
 "Cyrl, Hani, Hant, Hans, Arab",
 ancestors = "cmn",
 generate_forms = "zh-generateforms",
 translit = {Cyrl = "dng-translit"},
 sort_key = {
  Cyrl = {
   from = {"ё", "ә", "җ", "ң", "ў", "ү"},
   to = {"е" .. p[1], "е" .. p[2], "ж" .. p[1], "н" .. p[1], "у" .. p[1], "у" .. p[2]}
  },
  Hani = "Hani-sortkey",
 },
}
m["dni"] = {
 "Lower Grand Valley Dani",
 12635807,
 "ngf",
 "Latn",
}
m["dnj"] = {
 "Dan",
 1158971,
 "dmn-mda",
 "Latn",
}
m["dnk"] = {
 "Dengka",
 5256954,
 "poz-tim",
 "Latn",
}
m["dnn"] = {
 "Dzuun",
 10973260,
 "dmn-smg",
}
m["dno"] = {
 "Ndrulo",
 60785094,
 "csu-lnd",
}
m["dnr"] = {
 "Danaru",
 5214932,
 "ngf-mad",
 "Latn",
}
m["dnt"] = {
 "Mid Grand Valley Dani",
 12952359,
 "ngf",
 "Latn",
}
m["dnu"] = {
 "Danau",
 5013745,
 "mkh-pal",
}
m["dnv"] = {
 "Danu",
 5221251,
 "tbq-brm",
 ancestors = "obr",
}
m["dnw"] = {
 "Western Dani",
 7987774,
 "ngf",
 "Latn",
}
m["dny"] = {
 "Dení",
 56562,
 "auf",
 "Latn",
}
m["doa"] = {
 "Dom",
 5289770,
 "ngf",
 "Latn",
}
m["dob"] = {
 "Dobu",
 952133,
 "poz-ocw",
 "Latn",
}
m["doc"] = {
 "Northern Kam",
 17195499,
 "qfa-tak",
 "Latn",
}
m["doe"] = {
 "Doe",
 5288055,
 "bnt-ruv",
 "Latn",
}
m["dof"] = {
 "Domu",
 5291375,
 "ngf",
 "Latn",
}
m["doh"] = {
 "Dong",
 3438405,
 "nic-dak",
 "Latn",
}
m["doi"] = {
 "Dogri",
 32730,
 "him",
 "Deva, Takr, fa-Arab, Dogr",
 translit = {
  Deva = "hi-translit",
  Dogr = "Dogr-translit",
 },
}
m["dok"] = {
 "Dondo",
 5295571,
 "poz-tot",
 "Latn",
}
m["dol"] = {
 "Doso",
 4167202,
 "paa",
 "Latn",
}
m["don"] = {
 "Doura",
 7829037,
 "poz-ocw",
 "Latn",
}
m["doo"] = {
 "Dongo",
 35303,
 "nic-mbc",
 "Latn",
}
m["dop"] = {
 "Lukpa",
 3258739,
 "nic-gne",
 "Latn",
}
m["doq"] = {
 "Dominican Sign Language",
 5290820,
 "sgn",
 "Latn", -- when documented
}
m["dor"] = {
 "Dori'o",
 3037084,
 "poz-sls",
 "Latn",
}
m["dos"] = {
 "Dogosé",
 3913314,
 "nic-gur",
 "Latn",
}
m["dot"] = {
 "Dass",
 3441293,
 "cdc-wst",
 "Latn",
}
m["dov"] = {
 "Toka-Leya",
 11001779,
 "bnt-bot",
 "Latn",
 ancestors = "toi",
}
m["dow"] = {
 "Doyayo",
 35299,
 "alv-dur",
 "Latn",
}
m["dox"] = {
 "Bussa",
 35123,
 "cus-eas",
 "Latn",
}
m["doy"] = {
 "Dompo",
 35270,
 "alv-gng",
 "Latn",
}
m["doz"] = {
 "Dorze",
 56336,
 "omv-nom",
 "Latn",
}
m["dpp"] = {
 "Papar",
 7132487,
 "poz-san",
 "Latn",
}
m["drb"] = {
 "Dair",
 12952360,
 "nub-hil",
 "Latn",
}
m["drc"] = {
 "Minderico",
 6863806,
 "roa-ibe",
 "Latn",
 ancestors = "pt",
}
m["drd"] = {
 "Darmiya",
 5224058,
 "sit-alm",
}
m["drg"] = {
 "Rungus",
 6897407,
 "poz-san",
 "Latn",
}
m["dri"] = {
 "Lela",
 3914004,
 "nic-knn",
 "Latn",
}
m["drl"] = {
 "Baagandji",
 5223941,
 "aus-pam",
 "Latn",
}
m["drn"] = {
 "West Damar",
 3450459,
 "poz-tim",
 "Latn",
}
m["dro"] = {
 "Daro-Matu Melanau",
 5224156,
 "poz-bnn",
 "Latn",
}
m["drq"] = {
 "Dura",
 3449842,
 "sit-gma",
}
m["drs"] = {
 "Gedeo",
 56622,
 "cus-hec",
 "Ethi",
}
m["dru"] = {
 "Rukai",
 49232,
 "map",
 "Latn",
 ancestors = "dru-pro",
}
m["dry"] = {
 "Darai",
 46995026,
 "inc-bhi",
 "Deva",
}
m["dsb"] = {
 "Lower Sorbian",
 13286,
 "wen",
 "Latn",
 sort_key = s["wen-sortkey"],
 standardChars = "AaBbCcČčĆćDdEeĚěFfGgHhIiJjKkŁłLlMmNnŃńOoÓóPpRrŔŕSsŠšŚśTtUuWwYyZzŽžŹź" .. c.punc,
}
m["dse"] = {
 "Dutch Sign Language",
 2201099,
 "sgn",
 "Latn", -- when documented
}
m["dsh"] = {
 "Daasanach",
 56637,
 "cus-eas",
 "Latn",
}
m["dsi"] = {
 "Disa",
 3914455,
 "csu-bgr",
 "Latn",
}
m["dsl"] = {
 "Danish Sign Language",
 2605298,
 "sgn",
 "Latn", -- when documented
}
m["dsn"] = {
 "Dusner",
 5316948,
 "poz-hce",
 "Latn",
}
m["dso"] = {
 "Desiya",
 12629755,
 "inc-eas",
 "Orya",
 ancestors = "or",
}
m["dsq"] = {
 "Tadaksahak",
 36568,
 "son",
 "Arab, Latn",
}
m["dta"] = {
 "Daur",
 32430,
 "xgn",
 "Latn, Hani, Cyrl, Mong",
 translit = {Mong = "Mong-translit"},
 display_text = {Mong = s["Mong-displaytext"]},
 entry_name = {Mong = s["Mong-entryname"]},
 sort_key = {Hani = "Hani-sortkey"},
}
m["dtb"] = {
 "Labuk-Kinabatangan Kadazan",
 5330240,
 "poz-san",
 "Latn",
}
m["dtd"] = {
 "Ditidaht",
 13728042,
 "wak",
 "Latn",
}
m["dth"] = { -- contrast 'rrt'
 "Adithinngithigh",
 4683034,
 "aus-pmn",
 "Latn",
}
m["dti"] = {
 "Ana Tinga Dogon",
 4750346,
 "qfa-dgn",
 "Latn",
}
m["dtk"] = {
 "Tene Kan Dogon",
 11018863,
 "nic-pld",
 "Latn",
}
m["dtm"] = {
 "Tomo Kan Dogon",
 11137719,
 "nic-pld",
 "Latn",
}
m["dto"] = {
 "Tommo So",
 47012992,
 "nic-dge",
 "Latn",
}
m["dtp"] = {
 "Central Dusun",
 5317225,
 "poz-san",
 "Latn",
}
m["dtr"] = {
 "Lotud",
 6685078,
 "poz-san",
 "Latn",
}
m["dts"] = {
 "Toro So Dogon",
 11003311,
 "nic-dge",
 "Latn",
}
m["dtt"] = {
 "Toro Tegu Dogon",
 3913924,
 "nic-pld",
 "Latn",
}
m["dtu"] = {
 "Tebul Ure Dogon",
 7692089,
 "qfa-dgn",
 "Latn",
}
m["dty"] = {
 "Doteli",
 18415595,
 "inc-pah",
 "Deva",
 translit = "ne-translit",
 ancestors = "ne",
}
m["dua"] = {
 "Duala",
 33013,
 "bnt-saw",
 "Latn",
}
m["dub"] = {
 "Dubli",
 5310792,
 "inc-bhi",
}
m["duc"] = {
 "Duna",
 5314039,
 "paa",
 "Latn",
}
m["due"] = {
 "Umiray Dumaget Agta",
 7881585,
 "phi",
 "Latn",
}
m["duf"] = {
 "Dumbea",
 6983819,
 "poz-cln",
 "Latn",
}
m["dug"] = {
 "Chiduruma",
 35614,
 "bnt-mij",
 "Latn",
}
m["duh"] = {
 "Dungra Bhil",
 12953513,
 "inc-bhi",
 "Deva, Gujr",
}
m["dui"] = {
 "Dumun",
 5314004,
 "ngf-mad",
 "Latn",
}
m["duk"] = {
 "Uyajitaya",
 7904085,
 "ngf-mad",
 "Latn",
}
m["dul"] = {
 "Alabat Island Agta",
 3399709,
 "phi",
 "Latn",
}
m["dum"] = {
 "Middle Dutch",
 178806,
 "gmw",
 "Latn",
 ancestors = "odt",
 entry_name = {remove_diacritics = c.circ .. c.macron .. c.diaer},
}
m["dun"] = {
 "Dusun Deyah",
 2784033,
 "poz-bre",
 "Latn",
}
m["duo"] = {
 "Dupaningan Agta",
 5315912,
 "phi",
 "Latn",
}
m["dup"] = {
 "Duano",
 3040468,
 "poz-mly",
 "Latn",
}
m["duq"] = {
 "Dusun Malang",
 3041711,
 "poz-bre",
 "Latn",
}
m["dur"] = {
 "Dii",
 nil,
 "alv-dur",
 "Latn",
}
m["dus"] = {
 "Dumi",
 56315,
 "sit-kiw",
 "Deva",
}
m["duu"] = {
 "Drung",
 56406,
 "sit-nng",
}
m["duv"] = {
 "Duvle",
 56364,
 "paa-lkp",
 "Latn",
}
m["duw"] = {
 "Dusun Witu",
 2381310,
 "poz-bre",
 "Latn",
}
m["dux"] = {
 "Duun",
 3914880,
 "dmn-smg",
 "Latn",
}
m["duy"] = {
 "Dicamay Agta",
 5272321,
 "phi",
 "Latn",
}
m["duz"] = {
 "Duli",
 5313405,
 "alv-ada",
 "Latn",
}
m["dva"] = {
 "Duau",
 5310448,
 "poz-ocw",
 "Latn",
}
m["dwa"] = {
 "Diri",
 56286,
 "cdc-wst",
 "Latn",
}
m["dwr"] = {
 "Dawro",
 12629647,
 "omv-nom",
 "Ethi, Latn",
}
m["dwu"] = {
 "Dhuwal",
 nil,
 "aus-yol",
 "Latn",
}
m["dww"] = {
 "Dawawa",
 5242286,
 "poz-ocw",
 "Latn",
}
m["dwy"] = {
 "Dhuwaya",
 nil,
 "aus-yol",
 "Latn",
}
m["dwz"] = {
 "Dewas Rai",
 62663667,
 "inc-bhi",
}
m["dya"] = {
 "Dyan",
 35340,
 "nic-gur",
 "Latn",
}
m["dyb"] = {
 "Dyaberdyaber",
 5285185,
 "aus-nyu",
 "Latn",
}
m["dyd"] = {
 "Dyugun",
 3913785,
 "aus-nyu",
 "Latn",
}
m["dyg"] = {
 "Villa Viciosa Agta",
 12626611,
 "phi",
 "Latn",
}
m["dyi"] = {
 "Djimini",
 35336,
 "alv-tdj",
 "Latn",
}
m["dym"] = {
 "Yanda Dogon",
 8048316,
 "qfa-dgn",
 "Latn",
}
m["dyn"] = {
 "Dyangadi",
 3913820,
 "aus-cww",
 "Latn",
}
m["dyo"] = {
 "Jola-Fonyi",
 3507832,
 "alv-jol",
 "Latn",
}
m["dyu"] = {
 "Dyula",
 32706,
 "dmn-man",
 "Latn",
}
m["dyy"] = {
 "Dyaabugay",
 2591320,
 "aus-pmn",
 "Latn",
}
m["dza"] = {
 "Tunzu",
 3915845,
 "nic-jer",
 "Latn",
}
m["dzg"] = {
 "Dazaga",
 35244,
 "ssa-sah",
 "Latn",
}
m["dzl"] = {
 "Dzala",
 56607,
 "sit-ebo",
 "Tibt",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["dzn"] = {
 "Dzando",
 5319622,
 "bnt-bun",
 "Latn",
}
m["ebg"] = {
 "Ebughu",
 35294,
 "nic-lcr",
 "Latn",
}
m["ebk"] = {
 "Eastern Bontoc",
 nil,
 "phi",
 "Latn",
}
m["ebr"] = {
 "Ebrié",
 36644,
 "alv-ptn",
 "Latn",
}
m["ebu"] = {
 "Embu",
 35318,
 "bnt-kka",
 "Latn",
}
m["ecr"] = {
 "Eteocretan",
 35461,
 nil,
 "Grek",
 sort_key = s["Grek-sortkey"],
}
m["ecs"] = {
 "Ecuadorian Sign Language",
 3436769,
 "sgn",
 "Latn", -- when documented
}
m["ecy"] = {
 "Eteocypriot",
 35309,
 nil,
 "Cprt",
}
m["eee"] = {
 "E",
 35386,
 "qfa-mix",
 "Hani, Latn",
 sort_key = {Hani = "Hani-sortkey"},
}
m["efa"] = {
 "Efai",
 3813297,
 "nic-ief",
 "Latn",
}
m["efe"] = {
 "Efe",
 56354,
 "csu-mle",
 "Latn",
}
m["efi"] = {
 "Efik",
 35377,
 "nic-ief",
 "Latn",
}
m["ega"] = {
 "Ega",
 3914927,
 "alv",
 "Latn",
}
m["egl"] = {
 "Emilian",
 1057898,
 "roa-git",
 "Latn",
 wikimedia_codes = "eml",
}
m["ego"] = {
 "Eggon",
 35300,
 "nic-pls",
 "Latn",
}
m["egy"] = {
 "Egyptian",
 50868,
 "egx",
 "Latnx, Egyp, Egyd",
 sort_key = {
  remove_diacritics = "'%-%s",
  from = {"ꜣ", "j", "y", "ꜥ", "w", "b", "p", "f", "m", "n", "r", "ḥ", "ḫ", "ẖ", "h", "z", "š", "s", "q", "k", "g", "ṯ", "t", "ḏ", "d", "%."},
  to = {p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9], p[10], p[11], p[13], p[14], p[15], p[12], p[16], p[18], p[17], p[19], p[20], p[21], p[23], p[22], p[25], p[24], p[26]}
 },
}
m["ehu"] = {
 "Ehueun",
 3441392,
 "alv-nwd",
 "Latn",
}
m["eip"] = {
 "Eipomek",
 5349839,
 "ngf",
 "Latn",
}
m["eit"] = {
 "Eitiep",
 5350030,
 "qfa-tor",
 "Latn",
}
m["eiv"] = {
 "Askopan",
 56324,
 "paa-nbo",
 "Latn",
}
m["eja"] = {
 "Ejamat",
 6269820,
 "alv-jfe",
 "Latn",
}
m["eka"] = {
 "Ekajuk",
 35250,
 "nic-eko",
 "Latn",
}
m["eke"] = {
 "Ekit",
 3509628,
 "nic-ief",
 "Latn",
}
m["ekg"] = {
 "Ekari",
 5350305,
 "ngf",
 "Latn",
}
m["eki"] = {
 "Eki",
 5350418,
 "nic-ief",
 "Latn",
}
m["ekl"] = {
 "Kolhe",
 6426945,
 "mun",
 "Latn",
}
m["ekm"] = {
 "Elip",
 12952414,
 "nic-ymb",
 "Latn",
}
m["eko"] = {
 "Koti",
 29930,
 "bnt-mak",
 "Latn",
}
m["ekp"] = {
 "Ekpeye",
 35254,
 "alv-igb",
 "Latn",
}
m["ekr"] = {
 "Yace",
 36901,
 "alv-ido",
 "Latn",
}
m["eky"] = {
 "Eastern Kayah",
 25559417,
 "kar",
 "Kali",
}
m["ele"] = {
 "Elepi",
 5359444,
 "qfa-tor",
 "Latn",
}
m["elh"] = {
 "El Hugeirat",
 5351410,
 "nub-hil",
 "Latn",
}
m["eli"] = {
 "Nding",
 36176,
 "alv-tal",
 "Latn",
}
m["elk"] = {
 "Elkei",
 5364210,
 "qfa-tor",
 "Latn",
}
m["elm"] = {
 "Eleme",
 3914427,
 "nic-ogo",
 "Latn",
}
m["elo"] = {
 "El Molo",
 56719,
 "cus-eas",
 "Latn",
}
m["elu"] = {
 "Elu",
 3364594,
 "poz-aay",
 "Latn",
}
m["elx"] = {
 "Elamite",
 35470,
 "qfa-iso",
 "Xsux",
}
m["ema"] = {
 "Emai",
 35428,
 "alv-eeo",
 "Latn",
}
m["emb"] = {
 "Embaloh",
 5369424,
 "poz",
 "Latn",
}
m["eme"] = {
 "Emerillon",
 3588942,
 "tup-gua",
 "Latn",
}
m["emg"] = {
 "Eastern Meohang",
 12952840,
 "sit-kie",
 "Deva",
}
m["emi"] = {
 "Mussau-Emira",
 6943093,
 "poz-ocw",
 "Latn",
}
m["emk"] = {
 "Eastern Maninkakan",
 11002130,
 "dmn-mnk",
 "Latn, Arab, Nkoo",
}
m["emm"] = {
 "Mamulique",
 3285082,
 "nai-pak",
 "Latn",
}
m["emn"] = {
 "Eman",
 5368975,
 "nic-tvc",
 "Latn",
}
m["emp"] = {
 "Northern Emberá",
 2391297,
 "sai-chc",
 "Latn",
}
m["ems"] = {
 "Alutiiq",
 27992,
 "ypk",
 "Latn",
}
m["emu"] = {
 "Eastern Muria",
 12952883,
 "dra",
 ancestors = "gon",
}
m["emw"] = {
 "Emplawas",
 5374265,
 "poz-tim",
 "Latn",
}
m["emx"] = {
 "Erromintxela",
 1122188,
 "qfa-mix",
 "Latn",
 ancestors = "eu, rom",
}
m["emy"] = {
 "Epigraphic Mayan",
 301355,
 "myn",
 "Latn, Maya",
}
m["ena"] = {
 "Apali",
 3504201,
 "ngf-mad",
 "Latn",
}
m["enb"] = {
 "Markweeta",
 56874,
 "sdv-nma",
 "Latn",
}
m["enc"] = {
 "En",
 3504110,
 "qfa-buy",
 "Latn",
}
m["end"] = {
 "Ende",
 2067656,
 "poz-cet",
 "Latn",
}
m["enf"] = {
 "Forest Enets",
 30249597,
 "syd",
 "Cyrl",
}
m["enh"] = {
 "Tundra Enets",
 25559411,
 "syd",
 "Cyrl",
}
m["enl"] = {
 "Enlhet",
 15462671,
 "sai-mas",
 "Latn",
}
m["enm"] = {
 "Middle English",
 36395,
 "gmw",
 "Latn",
 ancestors = "ang",
 entry_name = {remove_diacritics = c.acute .. c.macron .. c.dotabove},
}
m["enn"] = {
 "Engenni",
 3915365,
 "alv-dlt",
 "Latn",
}
m["eno"] = {
 "Enggano",
 2669164,
 "poz",
 "Latn",
}
m["enq"] = {
 "Enga",
 1143040,
 "paa-eng",
 "Latn",
}
m["enr"] = {
 "Emem",
 5370369,
 "paa-pau",
}
m["enu"] = {
 "Enu",
 5380858,
 "tbq-lol",
}
m["env"] = {
 "Enwan",
 3438334,
 "alv-yek",
 "Latn",
}
m["enw"] = {
 "Enwang",
 11134434,
 "nic-lcr",
 "Latn",
}
m["enx"] = {
 "Enxet",
 15462609,
 "sai-mas",
 "Latn",
}
m["eot"] = {
 "Eotile",
 3915347,
 "alv-ptn",
 "Latn",
}
m["epi"] = {
 "Epie",
 35291,
 "alv-dlt",
 "Latn",
}
m["era"] = {
 "Eravallan",
 5385061,
 "dra",
}
m["erg"] = {
 "Sie",
 426254,
 "poz-occ",
 "Latn",
}
m["erh"] = {
 "Eruwa",
 3441244,
 "alv-swd",
 "Latn",
}
m["eri"] = {
 "Ogea",
 7079984,
 "ngf-mad",
 "Latn",
}
m["erk"] = {
 "South Efate",
 3449070,
 "poz-vnc",
 "Latn",
}
m["ero"] = {
 "Horpa",
 56854,
 "sit-rgy",
}
m["err"] = {
 "Erre",
 10488401,
 "qfa-iso",
 "Latn",
}
m["ers"] = {
 "Ersu",
 12952417,
 "sit-qia",
 "Latn", -- also Ersu Shaba
}
m["ert"] = {
 "Eritai",
 56376,
 "paa-lkp",
 "Latn",
}
m["erw"] = {
 "Erokwanas",
 5395296,
 "poz-hce",
 "Latn",
}
m["ese"] = {
 "Ese Ejja",
 2980381,
 "sai-tac",
 "Latn",
}
m["esh"] = {
 "Eshtehardi",
 12952418,
 "xme-ttc",
 "fa-Arab, Latn",
 ancestors = "xme-ttc-sou",
}
-- "esi" and "esk" moved to etymology-only per [[WT:LT]] and [[Wiktionary:Beer_parlour/2023/August#Issues_regarding_the_Inuit_languages]]
m["esl"] = {
 "Egyptian Sign Language",
 5348443,
 "sgn",
}
m["esm"] = {
 "Esuma",
 16927555,
 "alv-kwa",
 "Latn",
}
m["esn"] = {
 "Salvadoran Sign Language",
 7406492,
 "sgn",
 "Latn", -- when documented
}
m["eso"] = {
 "Estonian Sign Language",
 3196221,
 "sgn",
 "Latn", -- when documented
}
m["esq"] = {
 "Esselen",
 1294243,
 "qfa-iso",
 "Latn",
}
m["ess"] = {
 "Central Siberian Yupik",
 27993,
 "ypk",
 "Cyrl",
}
m["esu"] = {
 "Yup'ik",
 21117,
 "ypk",
 "Latn",
}
m["esy"] = {
 "Eskayan",
 867086,
 "art",
 "Latn", -- also its own native script
}
m["etb"] = {
 "Etebi",
 11002851,
 "nic-ief",
 "Latn",
}
m["etc"] = {
 "Etchemin",
 5402493,
 "alg-eas",
 "Latn",
}
m["eth"] = {
 "Ethiopian Sign Language",
 3501903,
 "sgn",
}
m["etn"] = {
 "Eton (Vanuatu)",
 3059362,
 "poz-oce",
 "Latn",
}
m["eto"] = {
 "Eton (Cameroon)",
 35317,
 "bnt-btb",
 "Latn",
}
m["etr"] = {
 "Edolo",
 5340184,
 "ngf",
 "Latn",
}
m["ets"] = {
 "Yekhee",
 3915848,
 "alv-yek",
 "Latn",
}
m["ett"] = {
 "Etruscan",
 35726,
 "qfa-tyn",
 "Ital",
 translit = "Ital-translit",
}
m["etu"] = {
 "Ejagham",
 35296,
 "nic-eko",
 "Latn",
}
m["etx"] = {
 "Eten",
 3915392,
 "nic-beo",
 "Latn",
}
m["etz"] = {
 "Semimi",
 10950308,
 "paa-mai",
 "Latn",
}
m["eve"] = {
 "Even",
 29960,
 "tuw",
 "Cyrl, Latn",
 translit = {Cyrl = "eve-translit"},
 entry_name = {remove_diacritics = c.macron .. c.dotabove .. c.dotbelow},
 sort_key = {
  Cyrl = {
   from = {
    "ӫ", -- 2 chars
    "ё", "ӈ", "ө" -- 1 char
   },
   to = {
    "о" .. p[2],
    "е" .. p[1], "н" .. p[1], "о" .. p[1]
   },
  },
 },
}
m["evh"] = {
 "Uvbie",
 3441344,
 "alv-swd",
 "Latn",
}
m["evn"] = {
 "Evenki",
 30004,
 "tuw",
 "Cyrl",
 translit = "evn-translit",
 entry_name = {remove_diacritics = c.macron .. c.dotabove .. c.dotbelow},
 sort_key = {
  from = {"ё", "ӈ"},
  to = {"е" .. p[1], "н" .. p[1]}
 },
}
m["ewo"] = {
 "Ewondo",
 35459,
 "bnt-btb",
 "Latn",
}
m["ext"] = {
 "Extremaduran",
 30007,
 "roa-ibe",
 "Latn",
}
m["eya"] = {
 "Eyak",
 27480,
 "xnd",
 "Latn",
}
m["eyo"] = {
 "Keiyo",
 56856,
 "sdv-nma",
 "Latn",
}
m["eza"] = {
 "Ezaa",
 11921436,
 "alv-igb",
 "Latn",
 ancestors = "izi",
}
m["eze"] = {
 "Uzekwe",
 3502244,
 "nic-ucn",
 "Latn",
}
m["faa"] = {
 "Fasu",
 3446687,
 "paa-kut",
 "Latn",
}
m["fab"] = {
 "Annobonese",
 34992,
 "crp",
 "Latn",
 ancestors = "pt",
}
m["fad"] = {
 "Wagi",
 7959569,
 "ngf-mad",
 "Latn",
}
m["faf"] = {
 "Fagani",
 3063759,
 "poz-sls",
 "Latn",
}
m["fag"] = {
 "Finongan",
 3450761,
 "ngf-fin",
 "Latn",
}
m["fah"] = {
 "Baissa Fali",
 3446632,
 "nic-bco",
 "Latn",
}
m["fai"] = {
 "Faiwol",
 3501773,
 "ngf-okk",
 "Latn",
}
m["faj"] = {
 "Faita",
 976953,
 "ngf-mad",
 "Latn",
}
m["fak"] = {
 "Fang (Beboid)",
 5433811,
 "nic-beb",
 "Latn",
}
m["fal"] = {
 "South Fali",
 15637351,
 "alv-fli",
 "Latn",
}
m["fam"] = {
 "Fam",
 35290,
 "nic-mmb",
 "Latn",
}
m["fan"] = {
 "Fang (Bantu)",
 33484,
 "bnt-btb",
 "Latn",
}
m["fap"] = {
 "Palor",
 36318,
 "alv-cng",
 "Latn",
}
m["far"] = {
 "Fataleka",
 3067168,
 "poz-sls",
 "Latn",
}
-- "fat" IS TREATED AS "ak", SEE WT:LT
m["fau"] = {
 "Fayu",
 5439113,
 "paa-lkp",
 "Latn",
}
m["fax"] = {
 "Fala",
 300402,
 "roa-ibe",
 "Latn",
 ancestors = "roa-opt",
}
m["fay"] = {
 "Southwestern Fars",
 5228140,
 "ira-swi",
}
m["faz"] = {
 "Northwestern Fars",
 7060307,
 "ira-swi",
}
m["fbl"] = {
 "West Albay Bikol",
 18603801,
 "phi",
 "Latn",
}
m["fcs"] = {
 "Quebec Sign Language",
 13193,
 "sgn",
 "Latn", -- when documented
}
m["fer"] = {
 "Feroge",
 35287,
 "nic-ser",
 "Latn",
}
m["ffi"] = {
 "Foia Foia",
 8564176,
 "ngf",
 "Latn",
}
-- "ffm" IS TREATED AS "ff", SEE WT:LT
m["fgr"] = {
 "Fongoro",
 3437645,
 "csu",
 "Latn",
}
m["fia"] = {
 "Nobiin",
 36503,
 "nub",
 "Latn, Arab, Copt",
 ancestors = "onw",
 translit = {
  Copt = "Copt-translit",
 },
}
m["fie"] = {
 "Fyer",
 56273,
 "cdc-wst",
 "Latn",
}
-- "fil" IS TREATED AS "tl", SEE WT:LT
m["fip"] = {
 "Fipa",
 667747,
 "bnt-mwi",
 "Latn",
}
m["fir"] = {
 "Firan",
 3915847,
 "nic-plc",
 "Latn",
}
m["fit"] = {
 "Meänkieli",
 13357,
 "urj-fin",
 "Latn",
 ancestors = "fi",
}
m["fiw"] = {
 "Fiwaga",
 5456292,
 "paa-kut",
 "Latn",
}
m["fkk"] = {
 "Kirya-Konzel",
 6416310,
 "cdc-cbm",
 "Latn",
}
m["fkv"] = {
 "Kven",
 165795,
 "urj-fin",
 "Latn",
 ancestors = "fi",
}
m["fla"] = {
 "Montana Salish",
 3111983,
 "sal",
 "Latn",
}
m["flh"] = {
 "Foau",
 5463819,
 "paa-lkp",
 "Latn",
}
m["fli"] = {
 "Fali",
 56244,
 "cdc-cbm",
 "Latn",
}
m["fll"] = {
 "North Fali",
 12952419,
 "alv-fli",
 "Latn",
}
m["fln"] = {
 "Flinders Island",
 3915702,
 "aus-pmn",
 "Latn",
}
m["flr"] = {
 "Fuliiru",
 7166821,
 "bnt-shh",
 "Latn",
}
m["fly"] = {
 "Tsotsitaal",
 12643960,
 "crp",
 "Latn",
 ancestors = "af",
}
m["fmp"] = {
 "Fe'fe'",
 35276,
 "bai",
 "Latn",
}
m["fmu"] = {
 "Far Western Muria",
 42589412,
 "dra",
 ancestors = "gon",
}
m["fng"] = {
 "Fanagalo",
 35727,
 "crp",
 "Latn",
 ancestors = "zu",
}
m["fni"] = {
 "Fania",
 317642,
 "alv-bua",
 "Latn",
}
m["fod"] = {
 "Foodo",
 5465566,
 "alv-gng",
 "Latn",
}
m["foi"] = {
 "Foi",
 5464146,
 "paa-kut",
 "Latn",
}
m["fom"] = {
 "Foma",
 5464911,
 "bnt-ske",
 "Latn",
 ancestors = "khy",
}
m["fon"] = {
 "Fon",
 33291,
 "alv-gbe",
 "Latn",
}
m["for"] = {
 "Fore",
 3077126,
 "paa-kag",
 "Latn",
}
m["fos"] = {
 "Siraya",
 716604,
 "map",
 "Latn",
}
m["fpe"] = {
 "Pichinglis",
 35288,
 "crp",
 "Latn",
 ancestors = "en",
}
m["fqs"] = {
 "Fas",
 56320,
 "paa",
 "Latn",
}
-- "frc" IS TREATED AS "fr" (or as etymology-only), SEE WT:LT
m["frd"] = {
 "Fordata",
 5468035,
 "poz",
 "Latn",
}
m["frm"] = {
 "Middle French",
 1473289,
 "roa-oil",
 "Latn",
 ancestors = "fro",
 sort_key = s["roa-oil-sortkey"],
}
m["fro"] = {
 "Old French",
 35222,
 "roa-oil",
 "Latn, Hebr",
 sort_key = {Latn = s["roa-oil-sortkey"]},
}
m["frp"] = {
 "Franco-Provençal",
 15087,
 "roa",
 "Latn",
 sort_key = {
  remove_diacritics = c.grave .. c.acute .. c.circ .. c.diaer .. c.cedilla .. "'",
  from = {"æ", "œ"},
  to = {"ae", "oe"}
 },
}
m["frq"] = {
 "Forak",
 5467173,
 "ngf-fin",
 "Latn",
}
m["frr"] = {
 "North Frisian",
 28224,
 "gmw-fri",
 "Latn",
}
-- "frs" IS NOT USED, SEE WT:LT
m["frt"] = {
 "Fortsenal",
 2666835,
 "poz-vnc",
 "Latn",
}
m["fse"] = {
 "Finnish Sign Language",
 33225,
 "sgn",
 "Latn", -- when documented
}
m["fsl"] = {
 "French Sign Language",
 33302,
 "sgn-fsl",
 "Latn", -- when documented
}
m["fss"] = {
 "Finnish-Swedish Sign Language",
 5450448,
 "sgn",
 "Latn", -- when documented
}
-- "fub" IS TREATED AS "ff", SEE WT:LT
-- "fuc" IS TREATED AS "ff", SEE WT:LT
m["fud"] = {
 "East Futuna",
 35334,
 "poz-pnp",
 "Latn",
}
-- "fue" IS TREATED AS "ff", SEE WT:LT
-- "fuf" IS TREATED AS "ff", SEE WT:LT
-- "fuh" IS TREATED AS "ff", SEE WT:LT
-- "fui" IS TREATED AS "ff", SEE WT:LT
m["fuj"] = {
 "Ko",
 35693,
 "alv-hei",
 "Latn",
}
m["fum"] = {
 "Fum",
 11011870,
 "nic-nka",
 "Latn",
}
m["fun"] = {
 "Fulniô",
 774441,
 "qfa-iso",
 "Latn",
}
-- "fuq" IS TREATED AS "ff", SEE WT:LT
m["fur"] = {
 "Friulian",
 33441,
 "roa-rhe",
 "Latn",
}
m["fut"] = {
 "Futuna-Aniwa",
 3064409,
 "poz-pnp",
 "Latn",
}
m["fuu"] = {
 "Furu",
 3441160,
 "csu-bkr",
 "Latn",
}
-- "fuv" IS TREATED AS "ff", SEE WT:LT
m["fuy"] = {
 "Fuyug",
 3073472,
 "ngf",
 "Latn",
}
m["fvr"] = {
 "Fur",
 33364,
 "ssa-fur",
 "Latn",
}
m["fwa"] = {
 "Fwâi",
 3091331,
 "poz-cln",
 "Latn",
}
m["fwe"] = {
 "Fwe",
 5511159,
 "bnt-bot",
 "Latn",
}
m["gaa"] = {
 "Ga",
 33287,
 "alv-gda",
 "Latn",
}
m["gab"] = {
 "Gabri",
 3441237,
 "cdc-est",
 "Latn",
}
m["gac"] = {
 "Mixed Great Andamanese",
 nil,
 "qfa-adn",
 "Latn",
}
m["gad"] = { -- not to be confused with gdk, gdg
 "Gaddang",
 3438830,
 "phi",
 "Latn",
}
m["gae"] = {
 "Warekena",
 1091095,
 "awd-nwk",
 "Latn",
}
m["gaf"] = {
 "Gende",
 3100425,
 "paa-kag",
 "Latn",
}
m["gag"] = {
 "Gagauz",
 33457,
 "trk-ogz",
 "Latn, Cyrl",
 ancestors = "trk-oat",
 dotted_dotless_i = true,
 sort_key = {
  Latn = {
   from = {
    "i", -- Ensure "i" comes after "ı".
    "ä", "ç", "ê", "ı", "ö", "ş", "ţ", "ü"
   },
   to = {
    "i" .. p[1],
    "a" .. p[1], "c" .. p[1], "e" .. p[1], "i", "o" .. p[1], "s" .. p[1], "t" .. p[1], "u" .. p[1]
   }
  },
 },
}
m["gah"] = {
 "Alekano",
 3441595,
 "paa-kag",
 "Latn",
}
m["gai"] = {
 "Borei",
 6799756,
 "paa",
 "Latn",
}
m["gaj"] = {
 "Gadsup",
 5516467,
 "paa-kag",
 "Latn",
}
m["gak"] = {
 "Gamkonora",
 5520226,
 "paa-nha",
 "Latn",
}
m["gal"] = {
 "Galoli",
 35322,
 "poz-tim",
 "Latn",
}
m["gam"] = {
 "Kandawo",
 6361369,
 "ngf",
 "Latn",
}
m["gan"] = {
 "Gan",
 33475,
 "zhx",
 "Hani, Hant, Hans",
 ancestors = "ltc",
 generate_forms = "zh-generateforms",
 translit = "zh-translit",
 sort_key = "Hani-sortkey",
}
m["gao"] = {
 "Gants",
 5521529,
 "ngf-mad",
 "Latn",
}
m["gap"] = {
 "Gal",
 5517742,
 "ngf-mad",
 "Latn",
}
m["gaq"] = {
 "Gata'",
 3501920,
 "mun",
}
m["gar"] = {
 "Galeya",
 5518509,
 "poz-ocw",
 "Latn",
}
m["gas"] = {
 "Adiwasi Garasia",
 12953522,
 "inc-bhi",
 ancestors = "bhb",
}
m["gat"] = {
 "Kenati",
 4219330,
 "paa-kag",
 "Latn",
}
m["gau"] = {
 "Kondekor",
 12952433,
 "dra",
}
m["gaw"] = {
 "Nobonob",
 11732205,
 "paa",
 "Latn",
}
m["gay"] = {
 "Gayo",
 33286,
 "poz-nws",
 "Latn",
}
m["gba"] = {
 "Gbaya",
 3099986,
 "alv-gba",
 "Latn",
}
m["gbb"] = {
 "Kaytetye",
 6380709,
 "aus-rnd",
 "Latn",
}
m["gbd"] = {
 "Karadjeri",
 3913837,
 "aus-pam",
 "Latn",
}
m["gbe"] = {
 "Niksek",
 56375,
 "paa",
 "Latn",
}
m["gbf"] = {
 "Gaikundi",
 5517032,
 "paa-spk",
 "Latn",
}
m["gbg"] = {
 "Gbanziri",
 35306,
 "nic-nkg",
 "Latn",
}
m["gbh"] = {
 "Defi Gbe",
 12952446,
 "alv-gbe",
 "Latn",
}
m["gbi"] = {
 "Galela",
 3094570,
 "paa-nha",
 "Latn",
}
m["gbj"] = {
 "Bodo Gadaba",
 3347070,
 "mun",
 "Orya",
}
m["gbk"] = {
 "Gaddi",
 17455500,
 "him",
 "Deva, Takr",
 translit = {Deva = "hi-translit"},
}
m["gbl"] = {
 "Gamit",
 2731717,
 "inc-bhi",
 "Deva, Gujr",
}
m["gbm"] = {
 "Garhwali",
 33459,
 "inc-pah",
 "Deva",
 translit = "hi-translit",
}
m["gbn"] = {
 "Mo'da",
 12755683,
 "csu-bbk",
 "Latn",
}
m["gbo"] = {
 "Northern Grebo",
 11157042,
 "kro-grb",
 "Latn",
 ancestors = "grb",
}
m["gbp"] = {
 "Gbaya-Bossangoa",
 11011295,
 "alv-gbw",
 "Latn",
}
m["gbq"] = {
 "Gbaya-Bozoum",
 4952879,
 "alv-gbw",
 "Latn",
}
m["gbr"] = {
 "Gbagyi",
 11015105,
 "alv-ngb",
 "Latn",
}
m["gbs"] = {
 "Gbesi Gbe",
 12952448,
 "alv-pph",
 "Latn",
}
m["gbu"] = {
 "Gagadu",
 35677,
 "aus-arn",
 "Latn",
}
m["gbv"] = {
 "Gbanu",
 3914945,
 "alv-gbf",
 "Latn",
}
m["gbw"] = {
 "Gabi",
 5515391,
 "aus-pam",
 "Latn",
}
m["gbx"] = {
 "Eastern Xwla Gbe",
 18379975,
 "alv-pph",
 "Latn",
}
m["gby"] = {
 "Gbari",
 3915451,
 "alv-ngb",
 "Latn",
}
m["gcc"] = {
 "Mali",
 6743338,
 "paa-bng",
 "Latn",
}
m["gcd"] = {
 "Ganggalida",
 3913765,
 "aus-tnk",
 "Latn",
}
m["gce"] = {
 "Galice",
 20711,
 "ath-pco",
 "Latn",
}
m["gcf"] = {
 "Antillean Creole",
 3006280,
 "crp",
 "Latn",
 ancestors = "fr",
 sort_key = s["roa-oil-sortkey"],
}
m["gcl"] = {
 "Grenadian Creole English",
 4252500,
 "crp",
 "Latn",
 ancestors = "en",
}
m["gcn"] = {
 "Gaina",
 11732195,
 "ngf",
 "Latn",
}
m["gcr"] = {
 "Guianese Creole",
 1363072,
 "crp",
 "Latn",
 ancestors = "fr",
 sort_key = s["roa-oil-sortkey"],
}
m["gct"] = {
 "Colonia Tovar German",
 1138351,
 "gmw",
 "Latn",
 ancestors = "gsw",
}
m["gdb"] = {
 "Ollari",
 33906,
 "dra",
 "Orya, Telu",
 translit = {
  Telu = "te-translit"
 },
}
m["gdc"] = {
 "Gugu Badhun",
 10510360,
 "aus-pam",
 "Latn",
}
m["gdd"] = {
 "Gedaged",
 35292,
 "poz-ocw",
 "Latn",
}
m["gde"] = {
 "Gude",
 3441230,
 "cdc-cbm",
 "Latn",
}
m["gdf"] = {
 "Guduf-Gava",
 3441350,
 "cdc-cbm",
 "Latn",
}
m["gdg"] = { -- not to be confused with gad, gdk
 "Ga'dang",
 5515189,
 "phi",
}
m["gdh"] = {
 "Gadjerawang",
 3913817,
 "aus-jar",
 "Latn",
}
m["gdi"] = {
 "Gundi",
 11137851,
 "nic-nkb",
 "Latn",
}
m["gdj"] = {
 "Kurtjar",
 5619931,
 "aus-pmn",
 "Latn",
}
m["gdk"] = { -- not to be confused with gad, gdg
 "Gadang",
 56256,
 "cdc-est",
 "Latn",
}
m["gdl"] = {
 "Dirasha",
 56809,
 "cus-eas",
 "Ethi",
}
m["gdm"] = {
 "Laal",
 33436,
 nil,
 "Latn",
}
m["gdn"] = {
 "Umanakaina",
 7881084,
 "ngf",
 "Latn",
}
m["gdo"] = {
 "Godoberi",
 56515,
 "cau-and",
 "Cyrl",
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
}
m["gdq"] = {
 "Mehri",
 13361,
 "sem-sar",
 "Arab, Latn",
}
m["gdr"] = {
 "Wipi",
 8026711,
 "paa",
 "Latn",
}
m["gds"] = {
 "Ghandruk Sign Language",
 15971577,
 "sgn",
}
m["gdt"] = {
 "Kungardutyi",
 6444517,
 "aus-kar",
 "Latn",
}
m["gdu"] = {
 "Gudu",
 3441172,
 "cdc-cbm",
 "Latn",
}
m["gdx"] = {
 "Godwari",
 3540922,
 "inc-wes",
 ancestors = "mwr",
}
m["gea"] = {
 "Geruma",
 3438789,
 "cdc-wst",
 "Latn",
}
m["geb"] = {
 "Kire",
 11129733,
 "paa",
 "Latn",
}
m["gec"] = {
 "Gboloo Grebo",
 11019342,
 "kro-grb",
 "Latn",
 ancestors = "grb",
}
m["ged"] = {
 "Gade",
 3914459,
 "alv-nup",
 "Latn",
}
m["geg"] = {
 "Gengle",
 3438345,
 "alv-mye",
 "Latn",
 ancestors = "kow",
}
m["geh"] = {
 "Hutterisch",
 33385,
 "gmw",
 "Latn",
 ancestors = "bar",
}
m["gei"] = {
 "Gebe",
 3100032,
 "poz-hce",
 "Latn",
}
m["gej"] = {
 "Gen",
 33450,
 "alv-gbe",
 "Latn",
}
m["gek"] = {
 "Gerka",
 3441277,
 "cdc-wst",
 "Latn",
}
m["gel"] = {
 "Fakkanci",
 36627,
 "nic-knn",
 "Latn",
}
m["geq"] = {
 "Geme",
 3915851,
 "znd",
 "Latn",
}
m["ges"] = {
 "Geser-Gorom",
 5553579,
 "poz-cma",
 "Latn",
}
m["gev"] = {
 "Viya",
 7937974,
 "bnt-tso",
 "Latn",
}
m["gew"] = {
 "Gera",
 3438725,
 "cdc-wst",
 "Latn",
}
m["gex"] = {
 "Garre",
 56618,
 "cus-som",
 "Latn",
}
m["gey"] = {
 "Enya",
 5381452,
 "bnt-mbe",
 "Latn",
}
m["gez"] = {
 "Ge'ez",
 35667,
 "sem-eth",
 "Ethi",
 translit = "Ethi-translit",
}
m["gfk"] = {
 "Patpatar",
 3368846,
 "poz-ocw",
 "Latn",
}
m["gft"] = {
 "Gafat",
 56910,
 "sem-eth",
 "Ethi, Latn",
}
m["gga"] = {
 "Gao",
 3095228,
 "poz-ocw",
 "Latn",
}
m["ggb"] = {
 "Gbii",
 3914390,
 "kro-wkr",
 "Latn",
}
m["ggd"] = {
 "Gugadj",
 5615186,
 "aus-pmn",
 "Latn",
}
m["gge"] = {
 "Guragone",
 5619801,
 "aus-arn",
 "Latn",
}
m["ggg"] = {
 "Gurgula",
 5620032,
 "inc-wes",
 "Arab",
 ancestors = "mwr",
}
m["ggk"] = {
 "Kungarakany",
 6444516,
 "aus-arn",
 "Latn",
}
m["ggl"] = {
 "Ganglau",
 5521140,
 "ngf-mad",
 "Latn",
}
m["ggn"] = {
 "Eastern Gurung",
 12952472,
 "sit-tam",
 "Deva, Latn",
}
m["ggt"] = {
 "Gitua",
 3107865,
 "poz-ocw",
 "Latn",
}
m["ggu"] = {
 "Gban",
 3913317,
 "dmn-nbe",
 "Latn",
}
m["ggw"] = {
 "Gogodala",
 3512161,
 "paa-pag",
 "Latn",
}
m["gha"] = {
 "Ghadames",
 56747,
 "ber",
 "Latn", -- and other scripts?
}
m["ghe"] = {
 "Southern Ghale",
 12952453,
 "sit-tam",
 "Deva",
}
m["ghh"] = {
 "Northern Ghale",
 22662104,
 "sit-tam",
 "Deva",
}
m["ghk"] = {
 "Geko Karen",
 5530317,
 "kar",
}
m["ghl"] = {
 "Ghulfan",
 16885737,
 "nub-hil",
 "Latn", -- and others?
}
m["ghn"] = {
 "Ghanongga",
 3104772,
 "poz-ocw",
 "Latn",
}
m["gho"] = {
 "Ghomara",
 35315,
 "ber",
 "Tfng, Latn",
 translit = {Tfng = "Tfng-translit"},
}
m["ghr"] = {
 "Ghera",
 22808992,
 "inc-hiw",
}
m["ghs"] = {
 "Guhu-Samane",
 11732219,
 "ngf",
 "Latn",
}
m["ght"] = {
 "Kutang Ghale",
 6448337,
 "sit-tam",
 "Tibt",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["gia"] = {
 "Kitja",
 1284877,
 "aus-jar",
 "Latn",
}
m["gib"] = {
 "Gibanawa",
 12953530,
 "crp",
 "Latn",
 ancestors = "ha",
}
m["gid"] = {
 "Gidar",
 35265,
 "cdc-cbm",
 "Latn",
}
m["gie"] = {
 "Guébie",
 nil,
 "kro-did",
 "Latn",
}
m["gig"] = {
 "Goaria",
 33269,
 "inc-wes",
 "Arab",
 ancestors = "mwr",
}
m["gih"] = {
 "Githabul",
 nil,
 "aus-pam",
 "Latn",
}
m["gii"] = {
 "Girirra",
 5564288,
 "cus-som",
}
m["gil"] = {
 "Gilbertese",
 30898,
 "poz-mic",
 "Latn",
}
m["gim"] = {
 "Gimi (Goroka)",
 11732209,
 "paa",
 "Latn",
}
m["gin"] = {
 "Hinukh",
 33283,
 "cau-wts",
 "Cyrl",
 translit = "gin-translit",
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
}
m["gio"] = {
 "Gelao",
 56401,
 "qfa-tak",
}
m["gip"] = {
 "Gimi (Austronesian)",
 12952457,
 "poz-ocw",
}
m["giq"] = {
 "Green Gelao",
 12953525,
 "qfa-gel",
}
m["gir"] = {
 "Red Gelao",
 3100264,
 "qfa-gel",
}
m["gis"] = {
 "North Giziga",
 3515084,
 "cdc-cbm",
}
m["git"] = {
 "Gitxsan",
 3107862,
 "nai-tsi",
}
m["giu"] = {
 "Mulao",
 11092831,
 "qfa-gel",
}
m["giw"] = {
 "White Gelao",
 8843040,
 "qfa-gel",
}
m["gix"] = {
 "Gilima",
 10977716,
 "nic-nkm",
 "Latn",
}
m["giy"] = {
 "Giyug",
 5565906,
}
m["giz"] = {
 "South Giziga",
 3502232,
 "cdc-cbm",
}
m["gji"] = {
 "Geji",
 3914890,
 "cdc-wst",
 "Latn",
}
m["gjk"] = {
 "Kachi Koli",
 12953646,
 "inc-wes",
}
m["gjm"] = {
 "Gunditjmara",
 6448731,
 "aus-pam",
}
m["gjn"] = {
 "Gonja",
 35267,
 "alv-gng",
 "Latn",
}
m["gju"] = {
 "Gojri",
 3241731,
 "inc-wes",
 "ur-Arab, Deva, Takr",
 ancestors = "raj",
 entry_name = {
  ["ur-Arab"] = {
   remove_diacritics = c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun .. c.nunghunna .. c.smallv,
   from = {"ڵ", "ݩ"},
   to = {"ل", "ن"}
  },
 },
}
m["gka"] = {
 "Guya",
 11732221,
 "ngf-fin",
 "Latn",
}
m["gkd"] = {
 "Magɨ",
 nil,
 "ngf-mad",
 "Latn",
}
m["gke"] = {
 "Ndai",
 6983667,
 "alv-mbm",
}
m["gkn"] = {
 "Gokana",
 3075137,
 "nic-ogo",
 "Latn",
}
m["gko"] = {
 "Kok-Nar",
 6426526,
 "aus-pmn",
 "Latn",
}
m["gkp"] = {
 "Guinea Kpelle",
 11052867,
 "dmn-msw",
 ancestors = "kpe",
}
m["glc"] = {
 "Bon Gula",
 289816,
 "alv-bua",
}
m["gld"] = {
 "Nanai",
 13303,
 "tuw",
 "Cyrl",
 entry_name = {remove_diacritics = c.macron},
 sort_key = {
  from = {"ё", "ӈ"},
  to = {"е" .. p[1], "н" .. p[1]}
 },
}
m["glh"] = {
 "Northwest Pashayi",
 23713532,
 "inc-dar",
}
m["glj"] = {
 "Kulaal",
 33360,
 "alv-bua",
}
m["glk"] = {
 "Gilaki",
 33657,
 "ira-csp",
 "fa-Arab",
}
m["glo"] = {
 "Galambu",
 2598797,
 "cdc-wst",
 "Latn",
}
m["glr"] = {
 "Glaro-Twabo",
 3915313,
 "kro-wee",
}
m["glu"] = {
 "Gula",
 5617176,
 "csu-bgr",
}
m["glw"] = {
 "Glavda",
 3441285,
 "cdc-cbm",
 "Latn",
}
m["gly"] = {
 "Gule",
 3120736,
 "ssa-kom",
}
m["gma"] = {
 "Gambera",
 10502327,
 "aus-wor",
}
m["gmb"] = {
 "Gula'alaa",
 3120733,
 "poz-sls",
 "Latn",
}
m["gmd"] = {
 "Mághdì",
 3914475,
 "alv-bwj",
}
m["gmg"] = {
 "Magiyi",
 16926155,
 "ngf-mad",
 "Latn",
}
m["gmh"] = {
 "Middle High German",
 837985,
 "gmw",
 "Latn",
 ancestors = "goh",
 entry_name = {
  remove_diacritics = c.circ .. c.macron,
  from = {"[ƷȤ]", "[ʒȥ]"},
  to = {"Z", "z"}
 },
}
m["gml"] = {
 "Middle Low German",
 505674,
 "gmw",
 "Latn",
 ancestors = "osx",
 entry_name = {remove_diacritics = c.circ .. c.macron .. c.diaer},
}
m["gmm"] = {
 "Gbaya-Mbodomo",
 6799713,
 "alv-gbf",
 "Latn",
}
m["gmn"] = {
 "Gimnime",
 11016905,
 "alv-dur",
}
m["gmu"] = {
 "Gumalu",
 5618027,
 "ngf-mad",
}
m["gmv"] = {
 "Gamo",
 16116386,
 "omv-nom",
 "Latn, Ethi",
}
m["gmx"] = {
 "Magoma",
 16939552,
 "bnt-bki",
}
m["gmy"] = {
 "Mycenaean Greek",
 668366,
 "grk",
 "Linb",
 translit = "Linb-translit",
 override_translit = true,
}
m["gmz"] = {
 "Mgbo",
 6826835,
 "alv-igb",
 ancestors = "izi",
}
m["gna"] = {
 "Kaansa",
 56802,
 "nic-gur",
}
m["gnb"] = {
 "Gangte",
 12952442,
 "tbq-kuk",
}
m["gnc"] = {
 "Guanche",
 35762,
 "ber",
}
m["gnd"] = {
 "Zulgo-Gemzek",
 56800,
 "cdc-cbm",
 "Latn",
}
m["gne"] = {
 "Ganang",
 nil,
 "nic-plc",
 ancestors = "izr",
}
m["gng"] = {
 "Ngangam",
 35888,
 "nic-grm",
}
m["gnh"] = {
 "Lere",
 3915319,
 "nic-jer",
}
m["gni"] = {
 "Gooniyandi",
 2669219,
 "aus-bub",
 "Latn",
}
m["gnj"] = {
 "Ngen",
 nil,
 "dmn-nbe",
 "Latn",
}
m["gnk"] = {
 "ǁGana",
 1975199,
 "khi-kal",
}
m["gnl"] = {
 "Gangulu",
 4916329,
 "aus-pam",
}
m["gnm"] = {
 "Ginuman",
 11732210,
 "ngf",
}
m["gnn"] = {
 "Gumatj",
 10510745,
 "aus-yol",
 "Latn",
}
m["gnq"] = {
 "Gana",
 5520523,
 "poz-san",
}
m["gnr"] = {
 "Gureng Gureng",
 5619998,
 "aus-pam",
}
m["gnt"] = {
 "Guntai",
 12952475,
 "paa",
}
m["gnu"] = {
 "Gnau",
 3915810,
 "qfa-tor",
}
m["gnw"] = {
 "Western Bolivian Guaraní",
 3775037,
 "tup-gua",
 "Latn",
 ancestors = "gn",
}
m["gnz"] = {
 "Ganzi",
 11137942,
 "nic-nkb",
 "Latn",
}
m["goa"] = {
 "Guro",
 35251,
 "dmn-mda",
 "Latn",
}
m["gob"] = {
 "Playero",
 3027923,
 "sai-guh",
}
m["goc"] = {
 "Gorakor",
 12952463,
 "poz-ocw",
 "Latn",
}
m["god"] = {
 "Godié",
 3914412,
 "kro-bet",
}
m["goe"] = {
 "Gongduk",
 2669221,
 "sit",
}
m["gof"] = {
 "Gofa",
 12631584,
 "omv-nom",
 "Latn, Ethi",
}
m["gog"] = {
 "Gogo",
 3272630,
 "bnt-ruv",
 "Latn",
}
m["goh"] = {
 "Old High German",
 35218,
 "gmw",
 "Latn, Runr",
 entry_name = {
  remove_diacritics = c.circ .. c.macron .. c.diaer,
  from = {"[ƷȤ]", "[ʒȥ]"},
  to = {"Z", "z"}
 },
 translit = {
  Runr = "Runr-translit",
 },
}
m["goi"] = {
 "Gobasi",
 5575414,
 "ngf",
 "Latn",
}
m["goj"] = {
 "Gowlan",
 12953532,
 "inc-sou",
}
-- gok is a spurious language, see [[w:Spurious languages]]
m["gol"] = {
 "Gola",
 35482,
 "alv",
}
m["gon"] = {
 "Gondi",
 1775361,
 "dra",
 "Telu, Gonm, Gong",
 translit = {
  Telu = "te-translit",
  Gong = "gon-Gong-translit",
  Gonm = "gon-Gonm-translit",
 },
}
m["goo"] = {
 "Gone Dau",
 3110470,
 "poz-occ",
 "Latn",
}
m["gop"] = {
 "Yeretuar",
 8052565,
 "poz-hce",
 "Latn",
}
m["goq"] = {
 "Gorap",
 3110816,
 "crp",
 ancestors = "ms",
}
m["gor"] = {
 "Gorontalo",
 2501174,
 "phi",
 "Latn",
}
m["got"] = {
 "Gothic",
 35722,
 "gme",
 "Goth, Runr, Latn",
 translit = {Goth = "Goth-translit"},
 link_tr = true,
 entry_name = {Latn = {remove_diacritics = c.macron}},
}
m["gou"] = {
 "Gavar",
 3441180,
 "cdc-cbm",
}
m["gov"] = {
 "Goo",
 16927208,
 "dmn",
 "Latn",
}
m["gow"] = {
 "Gorowa",
 3437626,
 "cus-sou",
}
m["gox"] = {
 "Gobu",
 7194986,
 "bad-cnt",
}
m["goy"] = {
 "Goundo",
 317636,
 "alv-kim",
}
m["goz"] = {
 "Gozarkhani",
 5590235,
 "xme-ttc",
 ancestors = "xme-ttc-eas",
}
m["gpa"] = {
 "Gupa-Abawa",
 3915352,
 "alv-ngb",
}
m["gpn"] = {
 "Taiap",
 56237,
 "paa",
}
m["gqa"] = {
 "Ga'anda",
 56245,
 "cdc-cbm",
 "Latn",
}
m["gqi"] = {
 "Guiqiong",
 3120647,
 "sit-qia",
}
m["gqn"] = { -- a variety of 'ter'
 "Kinikinao",
 nil,
 "awd",
}
m["gqr"] = {
 "Gor",
 759992,
 "csu-sar",
}
m["gqu"] = {
 "Qau",
 17284874,
 "qfa-gel",
}
m["gra"] = {
 "Rajput Garasia",
 21041529,
 "inc-bhi",
 "Deva, Gujr",
 ancestors = "bhb",
}
m["grb"] = {
 "Grebo",
 35257,
 "kro-grb",
 "Latn",
}
m["grc"] = {
 "Ancient Greek",
 35497,
 "grk",
 "Polyt, Cprt",
 translit = {
  Polyt = "grc-translit",
  Cprt = "Cprt-translit",
 },
 override_translit = true,
 entry_name = {
  Polyt = {
   remove_diacritics = c.macron .. c.breve .. c.dbrevebelow,
   from = {"[" .. c.RSQuo .. c.psili .. c.coronis .. "]"},
   to = {"'"}
  },
 },
 sort_key = {
  Polyt = s["Grek-sortkey"],
 },
 standardChars = {
  Polyt = "ΑΆἈἉἊἋἌἍἎἏᾈᾉᾊᾋᾌᾍᾎᾏᾸᾹᾺᾼΒΓΔΕΈἘἙἚἛἜἝῈΖΗΉἨἩἪἫἬἭἮἯᾘᾙᾚᾛᾜᾝᾞᾟῊῌΘΙΊΪἸἹἺἻἼἽἾἿῘῙῚΚΛΜΝΞΟΌὈὉὊὋὌὍΠΡῬΣΤΥΎΫὙὛὝὟῨῩῪΦΧΨΩΏὨὩὪὫὬὭὮὯᾨᾩᾪᾫᾬᾭᾮᾯῸῺῼαάἀἁἂἃἄἅἆἇὰᾀᾁᾂᾃᾄᾅᾆᾇᾰᾱᾲᾳᾴᾶᾷβγδεέἐἑἒἓἔἕὲζηήἠἡἢἣἤἥἦἧὴᾐᾑᾒᾓᾔᾕᾖᾗῂῃῄῆῇθιίϊΐἰἱἲἳἴἵἶἷὶῐῑῒῖῗκλμνξοόὀὁὂὃὄὅὸπρῤῥςστυύϋΰὐὑὒὓὔὕὖὗὺῠῡῢῦῧφχψωώὠὡὢὣὤὥὦὧὼᾠᾡᾢᾣᾤᾥᾦᾧῲῳῴῶῷ·ͺ΄΅᾽᾿῀῁῍῎῏῝῞῟῭`´῾",
  Cprt = "𐠀𐠁𐠂𐠃𐠄𐠅𐠈𐠊𐠋𐠌𐠍𐠎𐠏𐠐𐠑𐠒𐠓𐠔𐠕𐠖𐠗𐠘𐠙𐠚𐠛𐠜𐠝𐠞𐠟𐠠𐠡𐠢𐠣𐠤𐠥𐠦𐠧𐠨𐠩𐠪𐠫𐠬𐠭𐠮𐠯𐠰𐠱𐠲𐠳𐠴𐠵𐠷𐠸𐠼𐠿",
  c.punc
 },
}
m["grd"] = {
 "Guruntum",
 3441272,
 "cdc-wst",
 "Latn",
}
m["grg"] = {
 "Madi",
 6727664,
 "ngf-fin",
 "Latn",
}
m["grh"] = {
 "Gbiri-Niragu",
 3913936,
 "nic-kau",
 "Latn",
}
m["gri"] = {
 "Ghari",
 3104782,
 "poz-sls",
 "Latn",
}
m["grj"] = {
 "Southern Grebo",
 3914444,
 "kro-grb",
 "Latn",
 ancestors = "grb",
}
m["grm"] = {
 "Kota Marudu Talantang",
 6433808,
 "poz-san",
 "Latn",
}
m["gro"] = {
 "Groma",
 56551,
 "sit-tib",
}
m["grq"] = {
 "Gorovu",
 56355,
 "paa",
 "Latn",
}
m["grs"] = {
 "Gresi",
 5607612,
 "paa-nim",
 "Latn",
}
m["grt"] = {
 "Garo",
 36137,
 "tbq-bdg",
 "Latn, Beng, Brai",
}
m["gru"] = {
 "Kistane",
 13273,
 "sem-eth",
 "Latn",
}
m["grv"] = {
 "Central Grebo",
 18385114,
 "kro-grb",
 "Latn",
 ancestors = "grb",
}
m["grw"] = {
 "Gweda",
 5623387,
 "poz-ocw",
 "Latn",
}
m["grx"] = {
 "Guriaso",
 12631954,
 "paa-kwm",
 "Latn",
}
m["gry"] = {
 "Barclayville Grebo",
 11157342,
 "kro-grb",
 "Latn",
 ancestors = "grb",
}
m["grz"] = {
 "Guramalum",
 3120935,
 "poz-ocw",
 "Latn",
}
m["gse"] = {
 "Ghanaian Sign Language",
 35289,
 "sgn",
 "Latn", -- when documented
}
m["gsg"] = {
 "German Sign Language",
 33282,
 "sgn-gsl",
 "Sgnw",
}
m["gsl"] = {
 "Gusilay",
 35439,
 "alv-jol",
 "Latn",
}
m["gsm"] = {
 "Guatemalan Sign Language",
 2886781,
 "sgn",
 "Latn", -- when documented
}
m["gsn"] = {
 "Gusan",
 11732224,
 "ngf-fin",
 "Latn",
}
m["gso"] = {
 "Southwest Gbaya",
 4919322,
 "alv-gbs",
 "Latn",
}
m["gsp"] = {
 "Wasembo",
 7971402,
 "ngf-mad",
 "Latn",
}
m["gss"] = {
 "Greek Sign Language",
 3565084,
 "sgn",
}
m["gsw"] = {
 "Alemannic German",
 131339,
 "gmw",
 "Latn",
 wikimedia_codes = "als",
 ancestors = "gmh",
}
m["gta"] = {
 "Guató",
 3027940,
 "qfa-iso",
 "Latn",
}
m["gtu"] = {
 "Aghu Tharrnggala",
 16825981,
 "aus-pmn",
 "Latn",
}
m["gua"] = {
 "Shiki",
 3913946,
 "nic-jrn",
 "Latn",
}
m["gub"] = {
 "Guajajára",
 7699720,
 "tup-gua",
 "Latn",
}
m["guc"] = {
 "Wayuu",
 891085,
 "awd-taa",
 "Latn",
}
m["gud"] = {
 "Yocoboué Dida",
 21074781,
 "kro-did",
 "Latn",
}
m["gue"] = {
 "Gurindji",
 10511016,
 "aus-pam",
 "Latn",
}
m["guf"] = {
 "Gupapuyngu",
 10511004,
 "aus-yol",
 "Latn",
}
m["gug"] = {
 "Paraguayan Guaraní",
 17478066,
 "tup-gua",
 "Latn",
 ancestors = "gn",
}
m["guh"] = {
 "Guahibo",
 2669193,
 "sai-guh",
 "Latn",
}
m["gui"] = {
 "Eastern Bolivian Guaraní",
 2963912,
 "tup-gua",
 "Latn",
 ancestors = "gn",
}
m["guk"] = {
 "Gumuz",
 2396970,
 "ssa",
 "Latn, Ethi",
}
m["gul"] = {
 "Gullah",
 33395,
 "crp",
 "Latn",
 ancestors = "en",
}
m["gum"] = {
 "Guambiano",
 2744745,
 "sai-bar",
 "Latn",
}
m["gun"] = {
 "Mbyá Guaraní",
 3915584,
 "tup-gua",
 "Latn",
 ancestors = "gn",
}
m["guo"] = {
 "Guayabero",
 2980375,
 "sai-guh",
 "Latn",
}
m["gup"] = {
 "Gunwinggu",
 1406574,
 "aus-gun",
 "Latn",
}
m["guq"] = {
 "Aché",
 383701,
 "tup",
 "Latn",
}
m["gur"] = {
 "Farefare",
 35331,
 "nic-mre",
 "Latn",
}
m["gus"] = {
 "Guinean Sign Language",
 15983937,
 "sgn",
 "Latn", -- when documented
}
m["gut"] = {
 "Maléku Jaíka",
 3915782,
 "cba",
 "Latn",
}
m["guu"] = {
 "Yanomamö",
 8048928,
 "sai-ynm",
 "Latn",
}
m["guv"] = {
 "Gey",
 nil,
 "alv-sav",
 "Latn",
}
m["guw"] = {
 "Gun",
 3111668,
 "alv-gbe",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.macron},
}
m["gux"] = {
 "Gourmanchéma",
 35474,
 "nic-grm",
 "Latn",
}
m["guz"] = {
 "Gusii",
 33603,
 "bnt-lok",
 "Latn",
}
m["gva"] = {
 "Kaskihá",
 3033534,
 "sai-mas",
 "Latn",
}
m["gvc"] = {
 "Guanano",
 3566001,
 "sai-tuc",
 "Latn",
}
m["gve"] = {
 "Duwet",
 5317647,
 "poz-ocw",
 "Latn",
}
m["gvf"] = {
 "Golin",
 3110291,
 "ngf",
 "Latn",
}
m["gvj"] = {
 "Guajá",
 3915506,
 "tup",
 "Latn",
}
m["gvl"] = {
 "Gulay",
 641737,
 "csu-sar",
 "Latn",
}
m["gvm"] = {
 "Gurmana",
 3913363,
 "nic-shi",
 "Latn",
}
m["gvn"] = {
 "Kuku-Yalanji",
 5621973,
 "aus-pam",
 "Latn",
}
m["gvo"] = {
 "Gavião do Jiparaná",
 5528335,
 "tup",
 "Latn",
}
m["gvp"] = {
 "Pará Gavião",
 3365443,
 "sai-nje",
 "Latn",
}
m["gvr"] = {
 "Western Gurung",
 2392342,
 "sit-tam",
 "Deva",
}
m["gvs"] = {
 "Gumawana",
 5618041,
 "poz-ocw",
 "Latn",
}
m["gvy"] = {
 "Guyani",
 10511230,
 "aus-pam",
 "Latn",
}
m["gwa"] = {
 "Mbato",
 3914941,
 "alv-ptn",
 "Latn",
}
m["gwb"] = {
 "Gwa",
 5623219,
 "nic-jrn",
 "Latn",
}
m["gwc"] = {
 "Kalami",
 1675961,
 "inc-dar",
 "Arab",
}
m["gwd"] = {
 "Gawwada",
 3032135,
 "cus-eas",
}
m["gwe"] = {
 "Gweno",
 3358211,
 "bnt-chg",
 "Latn",
}
m["gwf"] = {
 "Gowro",
 3812403,
 "inc-dar",
}
m["gwg"] = {
 "Moo",
 6907057,
 "alv-bwj",
 "Latn",
}
m["gwi"] = {
 "Gwich'in",
 21057,
 "ath-nor",
 "Latn",
}
m["gwj"] = {
 "Gcwi",
 12631978,
 "khi-kal",
 "Latnx",
}
m["gwm"] = {
 "Awngthim",
 4830109,
 "aus-pmn",
 "Latn",
}
m["gwn"] = {
 "Gwandara",
 56521,
 "cdc-wst",
 "Latn",
}
m["gwr"] = {
 "Gwere",
 5623559,
 "bnt-nyg",
 "Latn",
}
m["gwt"] = {
 "Gawar-Bati",
 33894,
 "inc-dar",
}
m["gwu"] = {
 "Guwamu",
 10511225,
 "aus-pam",
 "Latn",
}
m["gww"] = {
 "Kwini",
 10551249,
 "aus-wor",
 "Latn",
}
m["gwx"] = {
 "Gua",
 35422,
 "alv-gng",
 "Latn",
}
m["gxx"] = {
 "Wè Southern",
 19921582,
 "kro-wee",
 "Latn",
}
m["gya"] = {
 "Northwest Gbaya",
 36594,
 "alv-gbw",
 "Latn",
}
m["gyb"] = {
 "Garus",
 5524492,
 "ngf-mad",
 "Latn",
}
m["gyd"] = {
 "Kayardild",
 3913770,
 "aus-tnk",
 "Latn",
}
m["gye"] = {
 "Gyem",
 5624046,
 "nic-jer",
 "Latn",
}
m["gyf"] = {
 "Gungabula",
 10510783,
 "aus-pam",
 "Latn",
}
m["gyg"] = {
 "Gbayi",
 11137618,
 "nic-ngd",
 "Latn",
}
m["gyi"] = {
 "Gyele",
 35434,
 "bnt-mnj",
 "Latn",
}
m["gyl"] = {
 "Gayil",
 5528771,
 "omv-aro",
 "Latn",
}
m["gym"] = {
 "Ngäbere",
 3915581,
 "cba",
 "Latn",
}
m["gyn"] = {
 "Guyanese Creole English",
 3305477,
 "crp",
 "Latn",
 ancestors = "en",
}
m["gyo"] = {
 "Gyalsumdo",
 53575940,
 "sit-kyk",
}
m["gyr"] = {
 "Guarayu",
 3118779,
 "tup",
 "Latn",
}
m["gyy"] = {
 "Gunya",
 10511001,
 "aus-pam",
 "Latn",
}
m["gza"] = {
 "Ganza",
 5521556,
 "omv-mao",
 "Latn",
}
m["gzn"] = {
 "Gane",
 3095108,
 "poz-hce",
 "Latn",
}
m["haa"] = {
 "Hän",
 28272,
 "ath-nor",
 "Latn",
}
m["hab"] = {
 "Hanoi Sign Language",
 12632107,
 "sgn",
 "Latn", -- when documented
}
m["hac"] = {
 "Gurani",
 33733,
 "ira-zgr",
 "ku-Arab",
 translit = "ckb-translit",
}
m["had"] = {
 "Hatam",
 56825,
 "paa-wpa",
}
m["haf"] = {
 "Haiphong Sign Language",
 39868240,
 "sgn",
}
m["hag"] = {
 "Hanga",
 35426,
 "nic-dag",
 "Latn",
}
m["hah"] = {
 "Hahon",
 3125730,
 "poz-ocw",
 "Latn",
}
m["hai"] = {
 "Haida",
 33303,
 "qfa-iso",
 "Latn",
}
m["haj"] = {
 "Hajong",
 3350576,
 "qfa-mix",
 "as-Beng, Latn",
 ancestors = "inc-oas, tbq-pro",
}
m["hak"] = {
 "Hakka",
 33375,
 "zhx",
 "Hani, Hant, Hans",
 ancestors = "ltc",
 generate_forms = "zh-generateforms",
 sort_key = "Hani-sortkey",
}
m["hal"] = {
 "Halang",
 56307,
 "mkh",
}
m["ham"] = {
 "Hewa",
 5748345,
 "paa-spk",
}
m["hao"] = {
 "Hakö",
 3125871,
 "poz-ocw",
 "Latn",
}
m["hap"] = {
 "Hupla",
 5946223,
 "ngf",
}
m["har"] = {
 "Harari",
 33626,
 "sem-eth",
 "Ethi",
 translit = "Ethi-translit",
}
m["has"] = {
 "Haisla",
 3107399,
 "wak",
}
m["hav"] = {
 "Havu",
 5684097,
 "bnt-shh",
 "Latn",
}
m["haw"] = {
 "Hawaiian",
 33569,
 "poz-pep",
 "Latn",
 display_text = {
  from = {"‘"},
  to = {"ʻ"}
 },
 sort_key = {remove_diacritics = c.macron},
 standardChars = "AaĀāEeĒēIiĪīOoŌōUuŪūHhKkLlMmNnPpWwʻ" .. c.punc,
}
m["hax"] = {
 "Southern Haida",
 12953543,
 "qfa-iso",
 ancestors = "hai",
}
m["hay"] = {
 "Haya",
 35756,
 "bnt-haj",
}
m["hba"] = {
 "Hamba",
 11028905,
 "bnt-tet",
}
m["hbb"] = {
 "Huba",
 56290,
 "cdc-cbm",
}
m["hbn"] = {
 "Heiban",
 35523,
 "alv-hei",
}
m["hbu"] = {
 "Habu",
 1567033,
 "poz-cet",
 "Latn",
}
m["hca"] = {
 "Andaman Creole Hindi",
 7599417,
 "crp",
 ancestors = "hi, bn, ta",
}
m["hch"] = {
 "Huichol",
 35575,
 "azc",
 "Latn",
}
m["hdn"] = {
 "Northern Haida",
 20054484,
 "qfa-iso",
 ancestors = "hai",
}
m["hds"] = {
 "Honduras Sign Language",
 3915496,
 "sgn",
 "Latn", -- when documented
}
m["hdy"] = {
 "Hadiyya",
 56613,
 "cus-hec",
}
m["hea"] = {
 "Northern Qiandong Miao",
 3138832,
 "hmn",
}
m["hed"] = {
 "Herdé",
 56253,
 "cdc-mas",
}
m["heg"] = {
 "Helong",
 35432,
 "poz-tim",
 "Latn",
}
m["heh"] = {
 "Hehe",
 3129390,
 "bnt-bki",
 "Latn",
}
m["hei"] = {
 "Heiltsuk",
 5699507,
 "wak",
}
m["hem"] = {
 "Hemba",
 5711209,
 "bnt-lbn",
}
m["hgm"] = {
 "Haiǁom",
 4494781,
 "khi-khk",
 "Latn",
}
m["hgw"] = {
 "Haigwai",
 5639108,
 "poz-ocw",
 "Latn",
}
m["hhi"] = {
 "Hoia Hoia",
 5877767,
 "ngf",
}
m["hhr"] = {
 "Kerak",
 11010783,
 "alv-jfe",
}
m["hhy"] = {
 "Hoyahoya",
 nil,
 "ngf",
}
m["hia"] = {
 "Lamang",
 35700,
 "cdc-cbm",
 "Latn",
}
m["hib"] = {
 "Hibito",
 3135164,
}
m["hid"] = {
 "Hidatsa",
 3135234,
 "sio-mor",
 "Latn",
}
m["hif"] = {
 "Fiji Hindi",
 46728,
 "inc-hie",
 "Latn",
 ancestors = "awa",
}
m["hig"] = {
 "Kamwe",
 56271,
 "cdc-cbm",
}
m["hih"] = {
 "Pamosu",
 12953011,
 "ngf-mad",
}
m["hii"] = {
 "Hinduri",
 5766763,
 "him",
}
m["hij"] = {
 "Hijuk",
 35274,
 "bnt-bsa",
}
m["hik"] = {
 "Seit-Kaitetu",
 7446989,
 "poz-cma",
}
m["hil"] = {
 "Hiligaynon",
 35978,
 "phi",
 "Latn",
 entry_name = {Latn = {remove_diacritics = c.grave .. c.acute .. c.circ}},
 standardChars = {
  Latn = "AaBbKkDdEeGgHhIiLlMmNnOoPpRrSsTtUuWwYy",
  c.punc
 },
 sort_key = {
  Latn = "tl-sortkey"
 },
}
m["hio"] = {
 "Tshwa",
 963636,
 "khi-kal",
}
m["hir"] = {
 "Himarimã",
 5765127,
}
m["hit"] = {
 "Hittite",
 35668,
 "ine-ana",
 "Xsux",
}
m["hiw"] = {
 "Hiw",
 3138713,
 "poz-vnc",
 "Latn",
}
m["hix"] = {
 "Hixkaryana",
 56522,
 "sai-prk",
 "Latn",
}
m["hji"] = {
 "Haji",
 5639933,
 "poz-mly",
}
m["hka"] = {
 "Kahe",
 3892562,
 "bnt-chg",
 "Latn",
}
m["hke"] = {
 "Hunde",
 3065432,
 "bnt-shh",
 "Latn",
}
m["hkk"] = {
 "Hunjara-Kaina Ke",
 nil,
 "ngf",
}
m["hkn"] = {
 "Mel-Khaonh",
 nil,
 "mkh-ban",
}
m["hks"] = {
 "Hong Kong Sign Language",
 17038844,
 "sgn",
}
m["hla"] = {
 "Halia",
 3125959,
 "poz-ocw",
 "Latn",
}
m["hlb"] = {
 "Halbi",
 3695692,
 "inc-eas",
 "Deva, Orya",
 ancestors = "pra-mag",
}
m["hld"] = {
 "Halang Doan",
 3914632,
 "mkh-ban",
}
m["hle"] = {
 "Hlersu",
 5873537,
 "tbq-lol",
}
m["hlt"] = {
 "Nga La",
 12952942,
 "tbq-kuk",
}
m["hma"] = {
 "Southern Mashan Hmong",
 12953560,
 "hmn",
 "Latn",
}
m["hmb"] = {
 "Humburi Senni",
 35486,
 "son",
}
m["hmc"] = {
 "Central Huishui Hmong",
 12953558,
 "hmn",
}
m["hmd"] = {
 "A-Hmao",
 1108934,
 "hmn",
 "Latn, Plrd",
}
m["hme"] = {
 "Eastern Huishui Hmong",
 12953559,
 "hmn",
}
m["hmf"] = {
 "Hmong Don",
 22911602,
 "hmn",
}
m["hmg"] = {
 "Southwestern Guiyang Hmong",
 27478542,
 "hmn",
}
m["hmh"] = {
 "Southwestern Huishui Hmong",
 12953565,
 "hmn",
}
m["hmi"] = {
 "Northern Huishui Hmong",
 27434946,
 "hmn",
}
m["hmj"] = {
 "Ge",
 11251864,
 "hmn",
}
m["hmk"] = {
 "Maek",
 8050724,
 "qfa-kor",
}
m["hml"] = {
 "Luopohe Hmong",
 14468943,
 "hmn",
}
m["hmm"] = {
 "Central Mashan Hmong",
 12953561,
 "hmn",
}
m["hmp"] = {
 "Northern Mashan Hmong",
 12953564,
 "hmn",
}
m["hmq"] = {
 "Eastern Qiandong Miao",
 27431369,
 "hmn",
}
m["hmr"] = {
 "Hmar",
 2992841,
 "tbq-kuk",
 ancestors = "lus",
}
m["hms"] = {
 "Southern Qiandong Miao",
 12953562,
 "hmn",
}
m["hmt"] = {
 "Hamtai",
 5646436,
 "ngf",
}
m["hmu"] = {
 "Hamap",
 12952484,
 "qfa-tap",
}
m["hmv"] = {
 "Hmong Dô",
 22911598,
 "hmn",
}
m["hmw"] = {
 "Western Mashan Hmong",
 12953563,
 "hmn",
}
m["hmy"] = {
 "Southern Guiyang Hmong",
 12953553,
 "hmn",
}
m["hmz"] = {
 "Hmong Shua",
 25559603,
 "hmn",
}
m["hna"] = {
 "Mina",
 56532,
 "cdc-cbm",
}
m["hnd"] = {
 "Southern Hindko",
 382273,
 "inc-pan",
 ancestors = "lah",
}
m["hne"] = {
 "Chhattisgarhi",
 33158,
 "inc-hie",
 "Deva",
 ancestors = "inc-pra",
 translit = "hi-translit"
}
m["hnh"] = {
 "ǁAni",
 3832982,
 "khi-kal",
 "Latnx",
}
m["hni"] = {
 "Hani",
 56516,
 "tbq-lol",
}
m["hnj"] = {
 "Green Hmong",
 3138831,
 "hmn",
 "Latn, Hmng",
}
m["hnn"] = {
 "Hanunoo",
 35435,
 "phi",
 "Hano, Latn",
}
m["hno"] = {
 "Northern Hindko",
 6346358,
 "inc-pan",
 "Arab",
 ancestors = "lah",
}
m["hns"] = {
 "Caribbean Hindustani",
 1843468,
 "inc-hie",
 ancestors = "bho",
}
m["hnu"] = {
 "Hung",
 12632753,
 "mkh-vie",
}
m["hoa"] = {
 "Hoava",
 3138887,
 "poz-ocw",
 "Latn",
}
m["hob"] = {
 "Austronesian Mari",
 6760941,
 "poz-ocw",
 "Latn",
}
m["hoc"] = {
 "Ho",
 33270,
 "mun",
 "Wara, Orya, Deva, Latn",
}
m["hod"] = {
 "Holma",
 56331,
 "cdc-cbm",
 "Latn",
}
m["hoe"] = {
 "Horom",
 3914008,
 "nic-ple",
 "Latn",
}
m["hoh"] = {
 "Hobyót",
 33299,
 "sem-sar",
 "Arab, Latn",
}
m["hoi"] = {
 "Holikachuk",
 28508,
 "ath-nor",
 "Latn",
}
m["hoj"] = {
 "Hadothi",
 33227,
 "inc-wes",
 ancestors = "mwr",
}
m["hol"] = {
 "Holu",
 4121133,
 "bnt-pen",
 "Latn",
}
m["hom"] = {
 "Homa",
 3449953,
 "bnt-boa",
 "Latn",
}
m["hoo"] = {
 "Holoholo",
 3139484,
 "bnt-tkm",
 "Latn",
}
m["hop"] = {
 "Hopi",
 56421,
 "azc",
 "Latn",
}
m["hor"] = {
 "Horo",
 641748,
 "csu-sar",
}
m["hos"] = {
 "Ho Chi Minh City Sign Language",
 16111971,
 "sgn",
 "Latn", -- when documented
}
m["hot"] = {
 "Hote",
 12632404,
 "poz-ocw",
 "Latn",
}
m["hov"] = {
 "Hovongan",
 5917269,
 "poz",
}
m["how"] = {
 "Honi",
 56842,
 "tbq-lol",
}
m["hoy"] = {
 "Holiya",
 5880707,
 "dra",
}
m["hoz"] = {
 "Hozo",
 5923010,
 "omv-mao",
}
m["hpo"] = {
 "Hpon",
 5923277,
 "tbq-brm",
}
m["hps"] = {
 "Hawai'i Pidgin Sign Language",
 33358,
 "sgn",
 "Latn", -- when documented
}
m["hra"] = {
 "Hrangkhol",
 5923435,
 "tbq-kuk",
}
m["hrc"] = {
 "Niwer Mil",
 nil,
 "poz-oce",
 "Latn",
}
m["hre"] = {
 "Hre",
 3915794,
 "mkh-nbn",
}
m["hrk"] = {
 "Haruku",
 5675762,
 "poz-cma",
}
m["hrm"] = {
 "Horned Miao",
 nil,
 "hmn",
}
m["hro"] = {
 "Haroi",
 3127568,
 "cmc",
 "Latn",
}
m["hrp"] = {
 "Nhirrpi",
 32571318,
 "aus-kar",
}
m["hrt"] = {
 "Hértevin",
 33290,
 "sem-nna",
 "Latn",
}
m["hru"] = {
 "Hruso",
 5923933,
 "sit-hrs",
}
m["hrw"] = {
 "Warwar Feni",
 nil,
 "poz-oce",
 "Latn",
}
m["hrx"] = {
 "Hunsrik",
 304049,
 "gmw",
 "Latn",
 ancestors = "gmw-cfr",
}
m["hrz"] = {
 "Harzani",
 56464,
 "xme-ttc",
 ancestors = "xme-ttc-nor",
}
m["hsb"] = {
 "Upper Sorbian",
 13248,
 "wen",
 "Latn",
 sort_key = s["wen-sortkey"],
}
m["hsh"] = {
 "Hungarian Sign Language",
 13636869,
 "sgn",
 "Latn", -- when documented
}
m["hsl"] = {
 "Hausa Sign Language",
 3915462,
 "sgn",
 "Latn", -- when documented
}
m["hsn"] = {
 "Xiang",
 13220,
 "zhx",
 "Hani, Hant, Hans",
 ancestors = "ltc",
 generate_forms = "zh-generateforms",
 translit = "zh-translit",
 sort_key = "Hani-sortkey",
}
m["hss"] = {
 "Harsusi",
 33423,
 "sem-sar",
 "Arab, Latn",
}
m["hti"] = {
 "Hoti",
 5912372,
 "poz-cma",
 "Latn",
}
m["hto"] = {
 "Minica Huitoto",
 948514,
 "sai-wit",
 "Latn",
}
m["hts"] = {
 "Hadza",
 33411,
 "qfa-iso",
 "Latn",
}
m["htu"] = {
 "Hitu",
 5872700,
 "poz-cma",
 "Latn",
}
m["hub"] = {
 "Huambisa",
 1526037,
 "sai-jiv",
 "Latn",
}
m["huc"] = {
 "ǂHoan",
 2053913,
 "khi-kxa",
 "Latnx",
}
m["hud"] = {
 "Huaulu",
 12952504,
 "poz-cma",
 "Latn",
}
m["huf"] = {
 "Humene",
 11732231,
 "ngf",
 "Latn",
}
m["hug"] = {
 "Huachipaeri",
 3446617,
 "sai-har",
 "Latn",
}
m["huh"] = {
 "Huilliche",
 35531,
 "sai-ara",
 "Latn",
}
m["hui"] = {
 "Huli",
 3125121,
 "paa-eng",
 "Latn",
}
m["huj"] = {
 "Northern Guiyang Hmong",
 12953554,
 "hmn",
}
m["huk"] = {
 "Hulung",
 12952505,
 "poz-cet",
}
m["hul"] = {
 "Hula",
 6382179,
 "poz-ocw",
 "Latn",
}
m["hum"] = {
 "Hungana",
 10975396,
 "bnt-yak",
}
m["huo"] = {
 "Hu",
 3141783,
 "mkh-pal",
}
m["hup"] = {
 "Hupa",
 28058,
 "ath-pco",
 "Latn",
}
m["huq"] = {
 "Tsat",
 34133,
 "cmc",
}
m["hur"] = {
 "Halkomelem",
 35388,
 "sal",
 "Latn",
}
m["hus"] = {
 "Wastek",
 35573,
 "myn",
 "Latn",
}
m["huu"] = {
 "Murui Huitoto",
 2640935,
 "sai-wit",
 "Latn",
}
m["huv"] = {
 "Huave",
 12954031,
 "qfa-iso",
 "Latn",
}
m["huw"] = {
 "Hukumina",
 3142988,
 "poz-cma",
 "Latn",
}
m["hux"] = {
 "Nüpode Huitoto",
 56333,
 "sai-wit",
 "Latn",
}
m["huy"] = {
 "Hulaulá",
 33426,
 "sem-nna",
}
m["huz"] = {
 "Hunzib",
 56564,
 "cau-ets",
 "Cyrl",
 translit = "huz-translit",
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
}
m["hvc"] = {
 "Haitian Vodoun Culture Language",
 3504239,
 "crp",
 "Latn",
}
m["hvk"] = {
 "Haveke",
 5683513,
 "poz-cln",
 "Latn",
}
m["hvn"] = {
 "Sabu",
 3128792,
 "poz-cet",
 "Latn",
}
m["hwa"] = {
 "Wané",
 3914887,
 "kro-ekr",
 "Latn",
}
m["hwc"] = {
 "Hawaiian Creole",
 35602,
 "crp",
 "Latn",
}
m["hwo"] = {
 "Hwana",
 56498,
 "cdc-cbm",
 "Latn",
}
m["hya"] = {
 "Hya",
 56798,
 "cdc-cbm",
 "Latn",
}
m["iai"] = {
 "Iaai",
 282888,
 "poz-occ",
 "Latn",
}
m["ian"] = {
 "Iatmul",
 5983460,
 "paa-spk",
}
m["iar"] = {
 "Purari",
 3499934,
 "paa",
}
m["iba"] = {
 "Iban",
 33424,
 "poz-mly",
 "Latn",
}
m["ibb"] = {
 "Ibibio",
 33792,
 "nic-ief",
 "Latn",
}
m["ibd"] = {
 "Iwaidja",
 1977429,
 "aus-wdj",
 "Latn",
}
m["ibe"] = {
 "Akpes",
 35457,
 "alv-von",
 "Latn",
}
m["ibg"] = {
 "Ibanag",
 1775596,
 "phi",
}
m["ibh"] = {
 "Bih",
 nil,
 "cmc",
 "Latn",
}
m["ibl"] = {
 "Ibaloi",
 3147383,
 "phi",
}
m["ibm"] = {
 "Agoi",
 34727,
 "nic-ucr",
 "Latn",
}
m["ibn"] = {
 "Ibino",
 3813281,
 "nic-lcr",
 "Latn",
}
m["ibr"] = {
 "Ibuoro",
 3813306,
 "nic-ief",
}
m["ibu"] = {
 "Ibu",
 11732235,
 "paa-nha",
}
m["iby"] = {
 "Ibani",
 11280479,
 "ijo",
}
m["ica"] = {
 "Ede Ica",
 12952405,
 "alv-ede",
 "Latn",
}
m["ich"] = {
 "Etkywan",
 3914462,
 "nic-jkn",
 "Latn",
}
m["icl"] = {
 "Icelandic Sign Language",
 3436654,
 "sgn",
 "Latn", -- when documented
}
m["icr"] = {
 "Islander Creole English",
 2044587,
 "crp",
 "Latn",
 ancestors = "en",
}
m["ida"] = {
 "Idakho-Isukha-Tiriki",
 12952512,
 "bnt-lok",
}
m["idb"] = {
 "Indo-Portuguese",
 6025550,
 "crp",
 "Latn",
 ancestors = "pt",
}
m["idc"] = {
 "Idon",
 3913366,
 "nic-plc",
}
m["idd"] = {
 "Ede Idaca",
 13123376,
 "alv-ede",
 "Latn",
}
m["ide"] = {
 "Idere",
 3813288,
 "nic-ief",
}
m["idi"] = {
 "Idi",
 5988630,
 "paa",
}
m["idr"] = {
 "Indri",
 35662,
 "nic-ser",
}
m["ids"] = {
 "Idesa",
 3913979,
 "alv-swd",
 "Latn",
 ancestors = "oke",
}
m["idt"] = {
 "Idaté",
 12952511,
 "poz-tim",
 "Latn",
}
m["idu"] = {
 "Idoma",
 35478,
 "alv-ido",
 "Latn",
}
m["ifa"] = {
 "Amganad Ifugao",
 18748222,
 "phi",
}
m["ifb"] = {
 "Batad Ifugao",
 12953578,
 "phi",
}
m["ife"] = {
 "Ifè",
 33606,
 "alv-ede",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.macron .. c.caron},
 sort_key = {
  remove_diacritics = c.tilde,
  from = {"ɖ", "dz", "ɛ", "gb", "kp", "ny", "ŋ", "ɔ", "ts"},
  to = {"d" .. p[1], "d" .. p[2], "e" .. p[1], "g" .. p[1], "k" .. p[1], "n" .. p[1], "n" .. p[2], "o" .. p[1], "t" .. p[1]}
 },
}
m["iff"] = {
 "Ifo",
 7902545,
 "poz-oce",
 "Latn",
}
m["ifk"] = {
 "Tuwali Ifugao",
 7857158,
 "phi",
}
m["ifm"] = {
 "Teke-Fuumu",
 36603,
 "bnt-tek",
}
m["ifu"] = {
 "Mayoyao Ifugao",
 12953579,
 "phi",
 "Latn",
}
m["ify"] = {
 "Keley-I Kallahan",
 3192221,
 "phi",
}
m["igb"] = {
 "Ebira",
 35363,
 "alv-nup",
 "Latn",
}
m["ige"] = {
 "Igede",
 35420,
 "alv-ido",
 "Latn",
}
m["igg"] = {
 "Igana",
 5991454,
 "paa",
 "Latn",
}
m["igl"] = {
 "Igala",
 35513,
 "alv-yrd",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.macron .. c.dotabove .. c.caron .. c.lineabove},
 sort_key = {
  from = {
   "ñm", "ñw", -- 3 chars
   "ch", "ẹ", "gb", "gw", "kp", "kw", "ny", "ñ", "ọ" -- 2 chars
  },
  to = {
   "n" .. p[3], "n" .. p[4],
   "c" .. p[1], "e" .. p[1], "g" .. p[1], "g" .. p[2], "k" .. p[1], "k" .. p[2], "n" .. p[1], "n" .. p[2], "o" .. p[1]
  }
 },
}
m["igm"] = {
 "Kanggape",
 6362743,
 "paa",
 "Latn",
}
m["ign"] = {
 "Ignaciano",
 3148190,
 "awd",
}
m["igo"] = {
 "Isebe",
 11732248,
 "ngf-mad",
}
m["igs"] = {
 "Glosa",
 1138529,
 "art",
 type = "appendix-constructed",
}
m["igw"] = {
 "Igwe",
 3913985,
 "alv-yek",
 "Latn",
}
m["ihb"] = {
 "Pidgin Iha",
 12639686,
 "crp",
 ancestors = "ihp",
}
m["ihi"] = {
 "Ihievbe",
 3441193,
 "alv-eeo",
 "Latn",
 ancestors = "ema",
}
m["ihp"] = {
 "Iha",
 5994495,
 "ngf",
}
m["ijc"] = {
 "Izon",
 35483,
 "ijo",
 "Latn",
}
m["ije"] = {
 "Biseni",
 35010,
 "ijo",
}
m["ijj"] = {
 "Ede Ije",
 12952406,
 "alv-ede",
 "Latn",
}
m["ijn"] = {
 "Kalabari",
 35697,
 "ijo",
}
m["ijs"] = {
 "Southeast Ijo",
 3915854,
 "ijo",
 "Latn",
}
m["ike"] = {
 "Eastern Canadian Inuktitut",
 4126517,
 "esx-inu",
 "Cans",
}
m["iki"] = {
 "Iko",
 3813290,
 "nic-lcr",
 "Latn",
}
m["ikk"] = {
 "Ika",
 35406,
 "alv-igb",
}
m["ikl"] = {
 "Ikulu",
 425973,
 "nic-plc",
 "Latn",
}
m["iko"] = {
 "Olulumo-Ikom",
 3914402,
 "nic-uce",
 "Latn",
}
m["ikp"] = {
 "Ikpeshi",
 3912777,
 "alv-yek",
 "Latn",
}
m["ikr"] = {
 "Ikaranggal",
 5995402,
 "aus-pam",
}
m["iks"] = {
 "Inuit Sign Language",
 13360244,
 "sgn",
 "Latn", -- when documented
}
m["ikt"] = {
 "Inuvialuktun",
 27990,
 "esx-inu",
 "Cans, Latn",
}
m["ikv"] = {
 "Iku-Gora-Ankwa",
 3913940,
 "nic-plc",
}
m["ikw"] = {
 "Ikwere",
 35399,
 "alv-igb",
}
m["ikx"] = {
 "Ik",
 35472,
 "ssa-klk",
 "Latn",
}
m["ikz"] = {
 "Ikizu",
 10977626,
 "bnt-lok",
 "Latn",
}
m["ila"] = {
 "Ile Ape",
 12473380,
 "poz-cet",
}
m["ilb"] = {
 "Ila",
 10962725,
 "bnt-bot",
 "Latn",
}
m["ilg"] = {
 "Ilgar",
 5997810,
 "aus-wdj",
 "Latn",
}
m["ili"] = {
 "Ili Turki",
 33627,
 "trk-kar",
}
m["ilk"] = {
 "Ilongot",
 3148787,
 "phi",
 "Latn",
}
m["ill"] = {
 "Iranun",
 12953581,
 "phi",
 "Latn, Arab",
}
m["ilo"] = {
 "Ilocano",
 35936,
 "phi",
 "Latn, Tglg",
 translit = {
  Tglg = "ilo-translit",
 },
 override_translit = true,
 entry_name = {
  Latn = {
   remove_diacritics = c.grave .. c.acute .. c.circ .. c.diaer,
  }
 },
    sort_key = {
  Latn = "tl-sortkey",
 },
 standardChars = { 
  Latn = "AaBbKkDdEeGgHhIiLlMmNnOoPpRrSsTtUuWwYy" .. c.punc,
 },
}
m["ils"] = {
 "International Sign",
 35754,
 "sgn",
}
m["ilu"] = {
 "Ili'uun",
 12632888,
 "poz-tim",
}
m["ilv"] = {
 "Ilue",
 3813301,
 "nic-lcr",
 "Latn",
}
m["ima"] = {
 "Mala Malasar",
 6740693,
 "dra",
}
m["imi"] = {
 "Anamgura",
 3501881,
 "ngf-mad",
}
m["iml"] = {
 "Miluk",
 3314550,
 "nai-coo",
 "Latn",
}
m["imn"] = {
 "Imonda",
 6005721,
 "paa-brd",
}
m["imo"] = {
 "Imbongu",
 12632895,
 "ngf-mad",
}
m["imr"] = {
 "Imroing",
 6008394,
 "poz-tim",
}
m["ims"] = {
 "Marsian",
 1265446,
 "itc-sbl",
 "Latn",
}
m["imy"] = {
 "Milyan",
 3832946,
 "ine-ana",
 "Lyci",
}
m["inb"] = {
 "Inga",
 35491,
 "qwe",
 ancestors = "qwe-kch",
}
m["ing"] = {
 "Deg Xinag",
 27782,
 "ath-nor",
}
m["inh"] = {
 "Ingush",
 33509,
 "cau-vay",
 "Cyrl, Latn, Arab",
 translit = {
  Cyrl = "cau-nec-translit",
  Arab = "ar-translit",
 },
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
 sort_key = {
  Cyrl = {
   from = {"аь", "гӏ", "ё", "кх", "къ", "кӏ", "пӏ", "тӏ", "хь", "хӏ", "цӏ", "чӏ", "яь"},
   to = {"а" .. p[1], "г" .. p[1], "е" .. p[1], "к" .. p[1], "к" .. p[2], "к" .. p[3], "п" .. p[1], "т" .. p[1], "х" .. p[1], "х" .. p[2], "ц" .. p[1], "ч" .. p[1], "я" .. p[1]}
  },
 },
}
m["inj"] = {
 "Jungle Inga",
 16115012,
 "qwe",
 ancestors = "qwe-kch",
}
m["inl"] = {
 "Indonesian Sign Language",
 3915477,
 "sgn",
 "Latn", -- when documented
}
m["inm"] = {
 "Minaean",
 737784,
 "sem-osa",
 "Sarb",
 translit = "Sarb-translit",
}
m["inn"] = {
 "Isinai",
 6081098,
 "phi",
}
m["ino"] = {
 "Inoke-Yate",
 6036531,
 "paa-kag",
}
m["inp"] = {
 "Iñapari",
 15338035,
 "awd",
 "Latn",
}
m["ins"] = {
 "Indian Sign Language",
 12953486,
 "sgn",
}
m["int"] = {
 "Intha",
 6057507,
 "tbq-brm",
 ancestors = "obr",
}
m["inz"] = {
 "Ineseño",
 35443,
 "nai-chu",
 "Latn",
}
m["ior"] = {
 "Inor",
 35763,
 "sem-eth",
 "Ethi",
}
m["iou"] = {
 "Tuma-Irumu",
 7852460,
 "ngf-fin",
 "Latn",
}
m["iow"] = {
 "Chiwere",
 56737,
 "sio-msv",
 "Latn",
}
m["ipi"] = {
 "Ipili",
 6065141,
 "paa-eng",
}
m["ipo"] = {
 "Ipiko",
 10566515,
 "ngf",
}
m["iqu"] = {
 "Iquito",
 2669184,
 "sai-zap",
 "Latn",
}
m["iqw"] = {
 "Ikwo",
 11926474,
 "alv-igb",
 "Latn",
 ancestors = "izi",
}
m["ire"] = {
 "Iresim",
 6069398,
 "poz-hce",
 "Latn",
}
m["irh"] = {
 "Irarutu",
 3027928,
 "poz-cet",
 "Latn",
}
m["iri"] = {
 "Rigwe",
 3912756,
 "nic-plc",
 "Latn",
}
m["irk"] = {
 "Iraqw",
 33595,
 "cus-sou",
 "Latn",
}
m["irn"] = {
 "Irantxe",
 3409301,
 nil,
 "Latn",
}
m["irr"] = {
 "Ir",
 3071880,
 "mkh-kat",
}
m["iru"] = {
 "Irula",
 33363,
 "dra",
 "Taml",
 translit = "ta-translit"
}
m["irx"] = {
 "Kamberau",
 6356317,
 "ngf",
}
m["iry"] = {
 "Iraya",
 6068356,
 "phi",
}
m["isa"] = {
 "Isabi",
 11732247,
 "paa-kag",
}
m["isc"] = {
 "Isconahua",
 3052971,
 "sai-pan",
 "Latn",
}
m["isd"] = {
 "Isnag",
 6085162,
 "phi",
 "Latn",
}
m["ise"] = {
 "Italian Sign Language",
 375619,
 "sgn",
 "Latn", -- when documented
}
m["isg"] = {
 "Irish Sign Language",
 14183,
 "sgn",
 "Latn", -- when documented
}
m["ish"] = {
 "Esan",
 35268,
 "alv-eeo",
 "Latn",
}
m["isi"] = {
 "Nkem-Nkum",
 36261,
 "nic-eko",
 "Latn",
}
m["isk"] = {
 "Ishkashimi",
 33419,
 "ira-sgi",
}
m["ism"] = {
 "Masimasi",
 6783273,
 "poz-ocw",
 "Latn",
}
m["isn"] = {
 "Isanzu",
 6078891,
 "bnt-tkm",
 "Latn",
}
m["iso"] = {
 "Isoko",
 35414,
 "alv-swd",
 "Latn",
}
m["isr"] = {
 "Israeli Sign Language",
 2911863,
 "sgn",
 "Sgnw",
}
m["ist"] = {
 "Istriot",
 35845,
 "roa-itd",
 "Latn",
}
m["isu"] = {
 "Isu",
 6089423,
 "nic-rnw",
 "Latn",
}
m["itb"] = {
 "Binongan Itneg",
 12953584,
 "phi",
}
m["itd"] = {
 "Southern Tidong",
 7049643,
 "poz-san",
}
m["ite"] = {
 "Itene",
 3038640,
 "sai-cpc",
 "Latn",
}
m["iti"] = {
 "Inlaod Itneg",
 12953585,
 "phi",
}
m["itk"] = {
 "Judeo-Italian",
 1145414,
 "roa-itd",
 "Hebr, Latn",
}
m["itl"] = {
 "Itelmen",
 33624,
 "qfa-cka",
 "Cyrl, Latn",
 entry_name = {
  Cyrl = {
   from = {"['’]", "[ӅԮ]", "[ӆԯ]", "Ҳ", "ҳ"},
   to   = {"ʼ", "Ԓ", "ԓ", "Ӽ", "ӽ"}
  },
 },
 sort_key = {
  Cyrl = {
   from = {
    "ӑ", "ё", "кʼ", "ӄʼ", "о̆", "пʼ", "тʼ", "ў", "чʼ", -- 2 chars
    "ӄ", "љ", "ԓ", "њ", "ӈ", "ӽ", "ә" -- 1 char
   },
   to = {
    "а" .. p[1], "е" .. p[1], "к" .. p[1], "к" .. p[3], "о" .. p[1], "п" .. p[1], "т" .. p[1], "у" .. p[1], "ч" .. p[1],
    "к" .. p[2], "л" .. p[1], "л" .. p[2], "н" .. p[1], "н" .. p[2], "х" .. p[1], "ь" .. p[1]
   }
  },
 },
}
m["itm"] = {
 "Itu Mbon Uzo",
 10977737,
 "nic-ief",
 "Latn",
 ancestors = "ibr",
}
m["ito"] = {
 "Itonama",
 950585,
 "qfa-iso",
}
m["itr"] = {
 "Iteri",
 2083185,
 "paa-asa",
}
m["its"] = {
 "Itsekiri",
 36045,
 "alv-edk",
 "Latn",
 entry_name = {Latn = {remove_diacritics = c.grave .. c.acute .. c.macron}},
 sort_key = {
  remove_diacritics = c.tilde,
  from = {"ẹ", "gb", "gh", "kp", "ọ", "ts", "ṣ"},
  to = {"e" .. p[1], "g" .. p[1], "g" .. p[2], "k" .. p[1], "o" .. p[1], "t" .. p[1], "t" .. p[1]}
 },
}
m["itt"] = {
 "Maeng Itneg",
 18748761,
 "phi",
}
m["itv"] = {
 "Itawit",
 3915527,
 "phi",
 "Latn",
}
m["itw"] = {
 "Ito",
 11128810,
 "nic-ief",
 ancestors = "ibr",
}
m["itx"] = {
 "Itik",
 6094713,
 "paa-tkw",
}
m["ity"] = {
 "Moyadan Itneg",
 12953583,
 "phi",
}
m["itz"] = {
 "Itzá",
 35537,
 "myn",
}
m["ium"] = {
 "Iu Mien",
 2498808,
 "hmx-mie",
}
m["ivb"] = {
 "Ibatan",
 18748212,
 "phi",
 "Latn",
}
m["ivv"] = {
 "Ivatan",
 3547080,
 "phi",
 "Latn",
}
m["iwk"] = {
 "I-Wak",
 12632789,
 "phi",
}
m["iwm"] = {
 "Iwam",
 3915215,
 "paa-spk",
}
m["iwo"] = {
 "Iwur",
 6101006,
 "ngf-okk",
}
m["iws"] = {
 "Sepik Iwam",
 16893603,
 "paa-spk",
}
m["ixc"] = {
 "Ixcatec",
 56706,
 "omq",
}
m["ixl"] = {
 "Ixil",
 35528,
 "myn",
 "Latn",
}
m["iya"] = {
 "Iyayu",
 3913390,
 "alv-nwd",
 "Latn",
}
m["iyo"] = {
 "Mesaka",
 36080,
 "nic-tiv",
 "Latn",
}
m["iyx"] = {
 "Yaa",
 36909,
 "bnt-nze",
 "Latn",
}
m["izh"] = {
 "Ingrian",
 33559,
 "urj-fin",
 "Latn",
 sort_key = {
  from = {
   "š", "ž",
  },
  to = {
   "s" .. p[1], "z" .. p[1],
  }
 },
}
m["izi"] = {
 "Izi-Ezaa-Ikwo-Mgbo",
 nil,
 "alv-igb",
}
m["izr"] = {
 "Izere",
 6101921,
 "nic-plc",
 "Latn",
}
m["izz"] = {
 "Izi",
 3914387,
 "alv-igb",
 "Latn",
 ancestors = "izi",
}
m["jaa"] = {
 "Jamamadí",
 3053275,
 "auf",
 "Latn",
}
m["jab"] = {
 "Hyam",
 35403,
 "nic-plc",
 "Latn",
}
m["jac"] = {
 "Jakaltek",
 33393,
 "myn",
 "Latn",
}
m["jad"] = {
 "Jahanka",
 3913992,
 "dmn-wmn",
 "Latn",
}
m["jae"] = {
 "Jabem",
 3571232,
 "poz-ocw",
 "Latn",
}
m["jaf"] = {
 "Jara",
 56289,
 "cdc",
 "Latn",
}
m["jah"] = {
 "Jah Hut",
 2742661,
 "mkh-asl",
}
m["jaj"] = {
 "Zazao",
 3574969,
 "poz-ocw",
 "Latn",
}
-- "jak" IS TREATED AS "ms", SEE WT:LT
m["jal"] = {
 "Yalahatan",
 8047298,
 "poz-cma",
 "Latn",
}
m["jam"] = {
 "Jamaican Creole",
 35939,
 "crp",
 "Latn",
 ancestors = "en",
}
m["jan"] = {
 "Janday",
 6150919,
 "aus-pam",
 "Latn",
}
m["jao"] = {
 "Yanyuwa",
 34241,
 "aus-pam",
 "Latn",
}
m["jaq"] = {
 "Yaqay",
 8049134,
 "ngf",
 "Latn",
}
m["jas"] = {
 "New Caledonian Javanese",
 12953527,
 "poz-sus",
 "Latn",
 ancestors = "jv",
}
m["jat"] = {
 "Jakati",
 4159744,
 "inc-pan",
 ancestors = "lah",
}
m["jau"] = {
 "Yaur",
 8050346,
 "poz-hce",
 "Latn",
}
m["jax"] = {
 "Jambi Malay",
 3915769,
 "poz-mly",
 "Latn",
}
m["jay"] = {
 "Yan-nhangu",
 10723405,
 "aus-yol",
 "Latn",
}
m["jaz"] = {
 "Jawe",
 3163200,
 "poz-cln",
 "Latn",
}
m["jbj"] = {
 "Arandai",
 4784070,
 "ngf",
 "Latn",
}
m["jbk"] = {
 "Barikewa",
 nil,
 "ngf",
 "Latn",
}
m["jbn"] = {
 "Nefusa",
 36151,
 "ber",
}
m["jbo"] = {
 "Lojban",
 36350,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["jbr"] = {
 "Jofotek-Bromnya",
 16886849,
 "paa-tkw",
}
m["jbt"] = {
 "Jabutí",
 2060023,
 "sai-mje",
 "Latn",
}
m["jbu"] = {
 "Jukun Takum",
 35447,
 "nic-jkn",
 "Latn",
}
m["jbw"] = {
 "Yawijibaya",
 31722921,
 "aus-wor",
 "Latn",
}
m["jcs"] = {
 "Jamaican Country Sign Language",
 6127418,
 "sgn",
 "Latn", -- when documented
}
m["jct"] = {
 "Krymchak",
 33723,
 "trk-kcu",
 "Latn, Cyrl",
}
m["jda"] = {
 "Jad",
 12633440,
 "sit-las",
}
m["jdg"] = {
 "Jadgali",
 13560607,
 "inc-snd",
 ancestors = "inc-vra",
}
m["jdt"] = {
 "Judeo-Tat",
 56495,
 "ira-swi",
 "Latn, Cyrl, Hebr",
 ancestors = "fa",
 translit = "jdt-translit",
}
m["jeb"] = {
 "Jebero",
 967031,
 "sai-cah",
}
m["jee"] = {
 "Jerung",
 56372,
 "sit-kiw",
}
m["jeg"] = {
 "Jeng",
 5091274,
 "mkh-ban",
 "Latn",
}
m["jeh"] = {
 "Jeh",
 3914636,
 "mkh-ban",
 "Latn",
}
m["jei"] = {
 "Yei",
 8051326,
}
m["jek"] = {
 "Jeri Kuo",
 11031936,
 "dmn-jje",
 "Latn",
}
m["jel"] = {
 "Yelmek",
 8052020,
}
m["jen"] = {
 "Dza",
 35558,
 "alv-bwj",
}
m["jer"] = {
 "Jere",
 3915449,
 "nic-jer",
}
m["jet"] = {
 "Manem",
 6748412,
 "paa-brd",
}
m["jeu"] = {
 "Jonkor Bourmataguil",
 56269,
}
m["jgb"] = {
 "Ngbee",
 7022243,
}
-- "jge" IS TREATED AS "ka", SEE WT:LT
m["jgk"] = {
 "Gwak",
 17523694,
 "nic-jrw",
}
m["jgo"] = {
 "Ngomba",
 36287,
 "bai",
 "Latn",
}
m["jhi"] = {
 "Jehai",
 3176748,
 "mkh-asl",
}
m["jhs"] = {
 "Jhankot Sign Language",
 6190889,
 "sgn",
}
m["jia"] = {
 "Jina",
 56297,
}
m["jib"] = {
 "Jibu",
 3914448,
 "nic-jkn",
 "Latn",
}
m["jic"] = {
 "Tol",
 3178609,
 "hok",
 "Latn",
}
m["jid"] = {
 "Bu",
 3913321,
 "nic-nin",
 "Latn",
}
m["jie"] = {
 "Jilbe",
 56281,
}
m["jig"] = {
 "Jingulu",
 6202435,
 "aus-mir",
}
m["jih"] = {
 "Shangzhai",
 25559440,
 "sit-rgy",
}
m["jii"] = {
 "Jiiddu",
 56769,
 "cus-som",
 "Latn",
}
m["jil"] = {
 "Jilim",
 6192674,
 "ngf-mad",
}
m["jim"] = {
 "Jimjimen",
 56288,
 "cdc-cbm",
 "Latn",
}
m["jio"] = {
 "Jiamao",
 3178570,
 nil,
 "Latn",
}
m["jiq"] = {
 "Khroskyabs",
 3118757,
 "sit-rgy",
}
m["jit"] = {
 "Jita",
 6203228,
 "bnt-haj",
 "Latn",
}
m["jiu"] = {
 "Youle Jinuo",
 12952530,
 "tbq-lol",
}
m["jiv"] = {
 "Shuar",
 617291,
 "sai-jiv",
 "Latn",
}
m["jiy"] = {
 "Buyuan Jinuo",
 12952528,
 "tbq-lol",
}
m["jje"] = {
 "Jeju",
 129648,
 "qfa-kor",
 "Kore",
 ancestors = "okm",
 translit = "jje-translit",
 entry_name = s["Kore-entryname"],
}
m["jjr"] = {
 "Zhár",
 17523697,
 "nic-jrw",
}
m["jka"] = {
 "Kaera",
 16910923,
 "ngf",
 "Latn",
}
m["jko"] = {
 "Kubo",
 12952670,
 "ngf",
}
m["jkr"] = {
 "Koro (India)",
 36162,
 "sit-gsi",
}
m["jku"] = {
 "Labir",
 1990210,
 "nic-jrn",
}
m["jle"] = {
 "Ngile",
 36329,
 "alv-tal",
}
m["jls"] = {
 "Jamaican Sign Language",
 6127433,
 "sgn",
 "Latn", -- when documented
}
m["jma"] = {
 "Dima",
 5277140,
}
m["jmb"] = {
 "Zumbun",
 56252,
 "cdc-wst",
}
m["jmc"] = {
 "Machame",
 12952751,
 "bnt-chg",
 "Latn",
}
m["jmd"] = {
 "Yamdena",
 8048030,
 "poz-cet",
 "Latn",
}
m["jmi"] = {
 "Jimi",
 3502308,
 "cdc-wst",
 "Latn",
}
m["jml"] = {
 "Jumli",
 6310993,
 "inc-pah",
}
m["jmn"] = {
 "Makuri Naga",
 6740482,
 "sit-aao",
}
m["jmr"] = {
 "Kamara",
 35561,
 "nic-dag",
}
-- "jms" IS TREATED AS "mff", SEE WT:LT
m["jmw"] = {
 "Mouwase",
 nil,
 "ngf",
 "Latn",
}
m["jmx"] = {
 "Western Juxtlahuaca Mixtec",
 12953731,
 "omq-mxt",
 "Latn",
}
m["jna"] = {
 "Jangshung",
 12633505,
 "sit-kin",
}
m["jnd"] = {
 "Jandavra",
 6150941,
 "inc-wes",
 "Arab",
 ancestors = "gu",
}
m["jng"] = {
 "Yangman",
 10723416,
 "aus-yng",
}
m["jni"] = {
 "Janji",
 3915330,
 "nic-jer",
}
m["jnj"] = {
 "Yemsa",
 36873,
 "omv",
}
m["jnl"] = {
 "Rawat",
 7296948,
 "sit-gma",
}
m["jns"] = {
 "Jaunsari",
 6164857,
 "him",
}
m["job"] = {
 "Joba",
 13123409,
 "bnt-shh",
}
m["jod"] = {
 "Wojenaka",
 11029540,
 "dmn-mnk",
}
m["jor"] = {
 "Jorá",
 5393974,
 "tup-gua",
 "Latn",
}
m["jos"] = {
 "Jordanian Sign Language",
 6534917,
 "sgn",
 "Sgnw",
}
m["jow"] = {
 "Jowulu",
 3914487,
 "dmn-mnw",
 "Latn",
}
-- "jpa" IS NOT USED, SEE WT:LT
m["jpr"] = {
 "Judeo-Persian",
 33367,
 "ira-swi",
 "Hebr",
 ancestors = "fa",
}
m["jqr"] = {
 "Jaqaru",
 33443,
 "sai-aym",
 "Latn",
}
m["jra"] = {
 "Jarai",
 33370,
 "cmc",
 "Latn",
}
m["jrr"] = {
 "Jiru",
 6203123,
 "nic-jkn",
}
m["jru"] = {
 "Japrería",
 3441409,
 "sai-yuk",
 "Latn",
}
m["jsl"] = {
 "Japanese Sign Language",
 35601,
 "sgn-jsl",
}
m["jua"] = {
 "Júma",
 12953587,
 "tup-gua",
 "Latn",
}
m["jub"] = {
 "Wannu",
 3914905,
 "nic-jkn",
}
m["juc"] = {
 "Jurchen",
 56731,
 "tuw",
 "Jurc",
}
m["jud"] = {
 "Worodougou",
 11155821,
 "dmn-mnk",
}
m["juh"] = {
 "Hone",
 5964576,
 "nic-jkn",
 "Latn",
}
m["jui"] = {
 "Ngadjuri",
 16897028,
 "aus-pam",
 "Latn",
}
m["juk"] = {
 "Wapan",
 3914914,
 "nic-jkn",
}
m["jul"] = {
 "Jirel",
 56863,
 "sit-tib",
}
m["jum"] = {
 "Jumjum",
 11283696,
 "sdv",
}
m["jun"] = {
 "Juang",
 33362,
 "mun",
 "Orya",
}
m["juo"] = {
 "Jiba",
 6191995,
 "nic-jkn",
}
m["jup"] = {
 "Hupdë",
 3143384,
 "sai-nad",
 "Latn",
}
m["jur"] = {
 "Jurúna",
 4023175,
 "tup",
 "Latn",
}
m["jus"] = {
 "Jumla Sign Language",
 6310991,
 "sgn",
}
m["jut"] = {
 "Jutish",
 1340322,
 "gmq",
 "Latn",
 ancestors = "da",
}
m["juu"] = {
 "Ju",
 3914897,
}
m["juw"] = {
 "Wãpha",
 3914934,
 "nic-jkn",
 "Latn",
}
m["juy"] = {
 "Juray",
 6314963,
 "mun",
}
m["jvd"] = {
 "Javindo",
 2719893,
}
m["jvn"] = {
 "Caribbean Javanese",
 11732256,
 "poz-sus",
 "Latn",
 ancestors = "jv",
}
m["jwi"] = {
 "Jwira-Pepesa",
 35467,
 "alv-ctn",
 "Latn",
}
-- "jya" IS TREATED AS "sit-sit", "sit-jap", "sit-tsh", "sit-zbu", SEE WT:LT
m["jyy"] = {
 "Jaya",
 641720,
 "csu-bgr",
 "Latn",
}
m["kaa"] = {
 "Karakalpak",
 33541,
 "trk-kno",
 "Latn, Cyrl, fa-Arab",
 dotted_dotless_i = true,
 entry_name = {
  from = {"['’]"},
  to = {"ʼ"}
 },
 sort_key = {
  Latn = {
   from = {
    -- Sort the old orthography (using the apostrophe) after the new orthography (using the acute accent).
    "í", "iʼ", "i", -- Ensure "i" comes after "í", "iʼ", "ı".
    "sh", "ch",
    "á", "aʼ", "ǵ", "gʼ", "x", p[4], p[5], "ı", "q", "ń", "nʼ", "ó", "oʼ", "ú", "uʼ", "c"
   },
   to = {
    p[4], p[5], "i" .. p[3],
    "z" .. p[1], "z" .. p[3],
    "a" .. p[1], "a" .. p[2], "g" .. p[1], "g" .. p[2], "h" .. p[1], "i", "i" .. p[1], "i" .. p[2], "k" .. p[1], "n" .. p[1], "n" .. p[2], "o" .. p[1], "o" .. p[2], "u" .. p[1], "u" .. p[2], "z" .. p[2]
   }
  },
  Cyrl = {
   from = {"ә", "ғ", "ё", "қ", "ң", "ө", "ү", "ў", "ҳ"},
   to = {"а" .. p[1], "г" .. p[1], "е" .. p[1], "к" .. p[1], "н" .. p[1], "о" .. p[1], "у" .. p[1], "у" .. p[2], "х" .. p[1]}
  },
 },
}
m["kab"] = {
 "Kabyle",
 35853,
 "ber",
 "Latn",
}
m["kac"] = {
 "Jingpho",
 33332,
 "sit-jnp",
 "Latn, Mymr",
}
m["kad"] = {
 "Kadara",
 3914011,
 "nic-plc",
 "Latn",
}
m["kae"] = {
 "Ketangalan",
 2779411,
 "map",
}
m["kaf"] = {
 "Katso",
 246122,
 "tbq-lol",
}
m["kag"] = {
 "Kajaman",
 6348863,
 "poz",
 "Latn",
}
m["kah"] = {
 "Fer",
 5443742,
 "csu-bgr",
 "Latn",
}
m["kai"] = {
 "Karekare",
 3438770,
 "cdc-wst",
 "Latn",
}
m["kaj"] = {
 "Jju",
 35401,
 "nic-plc",
 "Latn",
}
m["kak"] = {
 "Kayapa Kallahan",
 3192220,
 "phi",
 "Latn",
}
m["kam"] = {
 "Kamba",
 2574767,
 "bnt-kka",
 "Latn",
}
m["kao"] = {
 "Kassonke",
 36905,
 "dmn-wmn",
 "Latn",
}
m["kap"] = {
 "Bezhta",
 33054,
 "cau-ets",
 "Cyrl",
 translit = "cau-nec-translit",
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
}
m["kaq"] = {
 "Capanahua",
 2937196,
 "sai-pan",
 "Latn",
}
m["kaw"] = {
 "Old Javanese",
 49341,
 "poz-sus",
 "Latn, Java, Kawi",
 translit = "jv-translit", --same as jv
}
m["kax"] = {
 "Kao",
 3192799,
 "paa-nha"
}
m["kay"] = {
 "Kamayurá",
 3192336,
 "tup-gua",
 "Latn",
}
m["kba"] = {
 "Kalarko",
 5517764,
 "aus-pam",
 "Latn",
}
m["kbb"] = {
 "Kaxuyana",
 12953626,
 "sai-prk",
 "Latn",
}
m["kbc"] = {
 "Kadiwéu",
 18168288,
 "sai-guc",
 "Latn",
}
m["kbd"] = {
 "Kabardian",
 33522,
 "cau-cir",
 "Cyrl, Latn, Arab",
 translit = {
  Cyrl = "cau-cir-translit",
  Arab = "ar-translit",
 },
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
 sort_key = {
  Cyrl = {
   from = {
    "кхъу", "къӏу", -- 4 chars
    "гъу", "джу", "дзу", "жъу", "къу", "кхъ", "къӏ", "кӏу", "кӏь", "лъу", "лӏу", "пӏу", "сӏу", "тӏу", "фӏу", "хъу", "цӏу", "чъу", "чӏу", "шъу", "шӏу", "щӏу", -- 3 chars
    "гу", "гъ", "гь", "дж", "дз", "ё", "жъ", "жь", "ку", "къ", "кь", "кӏ", "лъ", "ль", "лӏ", "пӏ", "сӏ", "тӏ", "фӏ", "ху", "хъ", "хь", "цу", "цӏ", "чу", "чъ", "чӏ", "шъ", "шӏ", "щӏ", "ӏу", "ӏь", -- 2 chars
    "э" -- 1 char
   },
   to = {
    "к" .. p[5], "к" .. p[7],
    "г" .. p[3], "д" .. p[2], "д" .. p[4], "ж" .. p[2], "к" .. p[3], "к" .. p[4], "к" .. p[6], "к" .. p[10], "к" .. p[11], "л" .. p[2], "л" .. p[5], "п" .. p[2], "с" .. p[2], "т" .. p[2], "ф" .. p[2], "х" .. p[3], "ц" .. p[3], "ч" .. p[3], "ч" .. p[5], "ш" .. p[2], "ш" .. p[4], "щ" .. p[2],
    "г" .. p[1], "г" .. p[2], "г" .. p[4], "д" .. p[1], "д" .. p[3], "е" .. p[1], "ж" .. p[1], "ж" .. p[3], "к" .. p[1], "к" .. p[2], "к" .. p[8], "к" .. p[9], "л" .. p[1], "л" .. p[3], "л" .. p[4], "п" .. p[1], "с" .. p[1], "т" .. p[1], "ф" .. p[1], "х" .. p[1], "х" .. p[2], "х" .. p[4], "ц" .. p[1], "ц" .. p[2], "ч" .. p[1], "ч" .. p[2], "ч" .. p[4], "ш" .. p[1], "ш" .. p[3], "щ" .. p[1], "ӏ" .. p[1], "ӏ" .. p[2],
    "а" .. p[1]
   }
  },
 },
}
m["kbe"] = {
 "Kanju",
 10543322,
 "aus-pam",
 "Latn",
}
m["kbh"] = {
 "Camsá",
 2842667,
 "qfa-iso",
 "Latn",
}
m["kbi"] = {
 "Kaptiau",
 6367294,
 "poz-oce",
 "Latn",
}
m["kbj"] = {
 "Kari",
 6370438,
 "bnt-boa",
 "Latn",
}
m["kbk"] = {
 "Grass Koiari",
 12952642,
 "ngf",
 "Latn",
}
m["kbm"] = {
 "Iwal",
 3156391,
 "poz-ocw",
 "Latn",
}
m["kbn"] = {
 "Kare (Africa)",
 35554,
 "alv-mbm",
 "Latn",
}
m["kbo"] = {
 "Keliko",
 11275553,
 "csu-mma",
}
m["kbp"] = {
 "Kabiyé",
 35475,
 "nic-gne",
 "Latn",
}
m["kbq"] = {
 "Kamano",
 11732272,
 "paa-kag",
 "Latn",
}
m["kbr"] = {
 "Kafa",
 35481,
 "omv-gon",
 "Ethi, Latn",
}
m["kbs"] = {
 "Kande",
 35556,
 "bnt-tso",
 "Latn",
}
m["kbt"] = {
 "Gabadi",
 3291159,
 "poz-ocw",
 "Latn",
}
m["kbu"] = {
 "Kabutra",
 10966761,
 "inc-wes",
 ancestors = "raj",
}
m["kbv"] = {
 "Kamberataro",
 5261289,
 "paa",
 "Latn",
}
m["kbw"] = {
 "Kaiep",
 6347632,
 "poz-ocw",
 "Latn",
}
m["kbx"] = {
 "Ap Ma",
 56298,
 "paa-ram",
}
m["kbz"] = {
 "Duhwa",
 56295,
 "cdc-wst",
 "Latn",
}
m["kca"] = {
 "Khanty",
 33563,
 "urj-ugr",
 "Cyrl",
 translit = "kca-translit",
 override_translit = true,
}
m["kcb"] = {
 "Kawacha",
 11732302,
 "ngf",
}
m["kcc"] = {
 "Lubila",
 3914381,
 "nic-uce",
 "Latn",
}
m["kcd"] = {
 "Ngkâlmpw Kanum",
 12952566,
 "paa-yam",
}
m["kce"] = {
 "Kaivi",
 6348685,
 "nic-kau",
}
m["kcf"] = {
 "Ukaan",
 36651,
 "nic-bco",
}
m["kcg"] = {
 "Tyap",
 3912765,
 "nic-plc",
}
m["kch"] = {
 "Vono",
 3913920,
 "nic-kau",
}
m["kci"] = {
 "Kamantan",
 3914019,
 "nic-plc",
}
m["kcj"] = {
 "Kobiana",
 35609,
 "alv-nyn",
}
m["kck"] = {
 "Kalanga",
 33672,
 "bnt-sho",
 "Latn",
}
m["kcl"] = {
 "Kala",
 6349982,
 "poz-ocw",
 "Latn",
}
m["kcm"] = {
 "Tar Gula",
 277963,
 "csu-bba",
}
m["kcn"] = {
 "Nubi",
 36388,
 "crp",
 "Latn, Arab",
 ancestors = "apd",
 entry_name = {remove_diacritics = c.acute},
}
m["kco"] = {
 "Kinalakna",
 11732320,
 "ngf",
}
m["kcp"] = {
 "Kanga",
 6362384,
 "qfa-kad",
 "Latn",
}
m["kcq"] = {
 "Kamo",
 3914879,
 "alv-wjk",
}
m["kcr"] = {
 "Katla",
 35688,
 "nic-ktl",
}
m["kcs"] = {
 "Koenoem",
 3438755,
 "cdc-wst",
}
m["kct"] = {
 "Kaian",
 6347538,
 "paa-ram",
}
m["kcu"] = {
 "Kikami",
 3915212,
 "bnt-ruv",
 "Latn",
}
m["kcv"] = {
 "Kete",
 3195598,
 "bnt-lub",
}
m["kcw"] = {
 "Kabwari",
 6344539,
 "bnt-glb",
}
m["kcx"] = {
 "Kachama-Ganjule",
 12634070,
 "omv-eom",
}
m["kcy"] = {
 "Korandje",
 33427,
 "son",
}
m["kcz"] = {
 "Konongo",
 11732345,
 "bnt-tkm",
 "Latn",
}
m["kda"] = {
 "Worimi",
 3914062,
 "aus-pam",
 "Latn",
}
m["kdc"] = {
 "Kutu",
 6448634,
 "bnt-ruv",
}
m["kdd"] = {
 "Yankunytjatjara",
 34207,
 "aus-pam",
 "Latn",
}
m["kde"] = {
 "Makonde",
 35172,
 "bnt-rvm",
 "Latn",
}
m["kdf"] = {
 "Mamusi",
 6746036,
 "poz-ocw",
 "Latn",
}
m["kdg"] = {
 "Seba",
 7442316,
 "bnt-sbi",
 "Latn",
}
m["kdh"] = {
 "Tem",
 36531,
 "nic-gne",
}
m["kdi"] = {
 "Kumam",
 6443410,
 "sdv-los",
}
m["kdj"] = {
 "Karamojong",
 56326,
 "sdv-ttu",
 "Latn",
}
m["kdk"] = {
 "Numee",
 3346774,
 "poz-cln",
}
m["kdl"] = {
 "Tsikimba",
 3914404,
 "nic-kam",
}
m["kdm"] = {
 "Kagoma",
 3914420,
 "nic-plc",
}
m["kdn"] = {
 "Kunda",
 4121130,
 "bnt-sna",
}
m["kdp"] = {
 "Kaningdon-Nindem",
 3914956,
 "nic-nin",
}
m["kdq"] = {
 "Koch",
 56431,
 "tbq-bdg",
}
m["kdr"] = {
 "Karaim",
 33725,
 "trk-kcu",
 "Cyrl, Latn, Hebr",
}
m["kdt"] = {
 "Kuy",
 56310,
 "mkh-kat",
}
m["kdu"] = {
 "Kadaru",
 35441,
 "nub-hil",
 "Latn",
}
m["kdv"] = {
 "Kado",
 7402721,
 "sit-luu",
}
m["kdw"] = {
 "Koneraw",
 11732341,
 "ngf",
}
m["kdx"] = {
 "Kam",
 36753,
 "alv-wjk",
}
m["kdy"] = {
 "Keder",
 6383641,
 "paa-tkw",
}
m["kdz"] = {
 "Kwaja",
 11128866,
 "nic-nka",
 "Latn",
}
m["kea"] = {
 "Kabuverdianu",
 35963,
 "crp",
 "Latn",
 ancestors = "pt",
}
m["keb"] = {
 "Kélé",
 35559,
 "bnt-kel",
}
m["kec"] = {
 "Keiga",
 3409311,
 "qfa-kad",
 "Latn",
}
m["ked"] = {
 "Kerewe",
 6393846,
 "bnt-haj",
}
m["kee"] = {
 "Eastern Keres",
 15649021,
 "nai-ker",
 "Latn",
}
m["kef"] = {
 "Kpessi",
 35748,
 "alv-gbe",
}
m["keg"] = {
 "Tese",
 16887296,
 "sdv",
}
m["keh"] = {
 "Keak",
 6382110,
 "paa-spk",
}
m["kei"] = {
 "Kei",
 2410352,
}
m["kej"] = {
 "Kadar",
 6345179,
 "dra",
}
m["kek"] = {
 "Q'eqchi",
 35536,
 "myn",
 "Latn",
}
m["kel"] = {
 "Kela-Yela",
 6385426,
 "bnt-mon",
 "Latn",
}
m["kem"] = {
 "Kemak",
 35549,
 "poz-tim",
}
m["ken"] = {
 "Kenyang",
 35650,
 "nic-mam",
 "Latn",
}
m["keo"] = {
 "Kakwa",
 3033547,
 "sdv-bri",
}
m["kep"] = {
 "Kaikadi",
 6347757,
 "dra",
}
m["keq"] = {
 "Kamar",
 14916877,
 "inc-eas",
 ancestors = "pra-mag",
}
m["ker"] = {
 "Kera",
 56251,
 "cdc-est",
 "Latn",
}
m["kes"] = {
 "Kugbo",
 3813394,
 "nic-cde",
 "Latn",
}
m["ket"] = {
 "Ket",
 33485,
 "qfa-yen",
 "Cyrl",
 entry_name = {
  from = {"['’]"},
  to = {"ʼ"}
 },
 sort_key = {
  from = {"ӷ", "ё", "ӄ", "ӈ", "ө", "ә", "ʼ"},
  to = {"г" .. p[1], "е" .. p[1], "к" .. p[1], "н" .. p[1], "о" .. p[1], "ъ" .. p[1], "ь" .. p[1]}
 },
}
m["keu"] = {
 "Akebu",
 35026,
 "alv-ktg",
}
m["kev"] = {
 "Kanikkaran",
 6363201,
 "dra",
}
m["kew"] = {
 "Kewa",
 12952619,
 "paa-eng",
 "Latn",
}
m["kex"] = {
 "Kukna",
 5031131,
 "inc-eas",
 ancestors = "bh",
}
m["key"] = {
 "Kupia",
 6445354,
 "inc-eas",
}
m["kez"] = {
 "Kukele",
 3915391,
 "nic-ucn",
 "Latn",
}
m["kfa"] = {
 "Kodava",
 33531,
 "dra",
 "Knda, Mlym",
 translit = {
  Knda = "kn-translit",
  Mlym = "ml-translit"
 },
}
m["kfb"] = {
 "Kolami",
 33479,
 "dra",
 "Deva, Telu",
 translit = {
  Telu = "te-translit",
 },
}
m["kfc"] = {
 "Konda-Dora",
 35679,
 "dra",
 "Orya, Telu",
 translit = {
  Orya = "gon-Orya-translit",
  Telu = "te-translit",
 },
}
m["kfd"] = {
 "Korra Koraga",
 12952655,
 "dra",
 "Knda",
 translit = "kn-translit",
}
m["kfe"] = {
 "Kota (India)",
 33483,
 "dra",
 "Taml",
 translit = "ta-translit",
}
m["kff"] = {
 "Koya",
 33471,
 "dra",
}
m["kfg"] = {
 "Kudiya",
 12952667,
 "dra",
}
m["kfh"] = {
 "Kurichiya",
 12952676,
 "dra",
 "Mlym",
 translit = "ml-translit",
}
m["kfi"] = {
 "Kannada Kurumba",
 56589,
 "dra",
}
m["kfj"] = {
 "Kemiehua",
 27144776,
 "mkh-pal",
}
m["kfk"] = {
 "Kinnauri",
 2383208,
 "sit-kin",
}
m["kfl"] = {
 "Kung",
 6444510,
 "nic-rnc",
 "Latn",
}
m["kfn"] = {
 "Kuk",
 6442398,
 "nic-rnc",
 "Latn",
}
m["kfo"] = {
 "Koro (West Africa)",
 11160588,
 "dmn-mnk",
 "Latn, Nkoo",
}
m["kfp"] = {
 "Korwa",
 6432786,
 "mun",
}
m["kfq"] = {
 "Korku",
 33715,
 "mun",
}
m["kfr"] = {
 "Kachchi",
 56487,
 "inc-snd",
 "Gujr, sd-Arab, Sind, Khoj",
 translit = {
  Gujr = "gu-translit",
  Sind = "Sind-translit",
 },
 entry_name = {
  remove_diacritics = c.kashida .. c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun .. c.superalef,
  from = {u(0x0671)},
  to = {u(0x0627)}
 },
 ancestors = "inc-vra",
}
m["kfs"] = {
 "Bilaspuri",
 12953397,
 "him",
 "Deva, Takr",
 translit = "hi-translit",
}
m["kft"] = {
 "Kanjari",
 12953610,
 "inc-pan",
 ancestors = "pa",
}
m["kfu"] = {
 "Katkari",
 6377671,
 "inc-sou",
 ancestors = "pra-mah",
}
m["kfv"] = {
 "Kurmukar",
 6446193,
 "inc-eas",
 ancestors = "pra-mag",
}
m["kfw"] = {
 "Kharam Naga",
 12952906,
 "tbq-kuk",
}
m["kfx"] = {
 "Kullu Pahari",
 6443148,
 "him",
 "Deva",
 translit = "hi-translit",
}
m["kfy"] = {
 "Kumaoni",
 33529,
 "inc-pah",
 "Deva, Shrd, Takr",
}
m["kfz"] = {
 "Koromfé",
 35701,
 "nic-gur",
 "Latn",
}
m["kga"] = {
 "Koyaga",
 11155632,
 "dmn-mnk",
}
m["kgb"] = {
 "Kawe",
 12952750,
 "poz-hce",
}
m["kgd"] = {
 "Kataang",
 12953622,
 "mkh",
}
m["kge"] = {
 "Komering",
 49224,
 "poz-lgx",
}
m["kgf"] = {
 "Kube",
 11732359,
 "ngf",
}
m["kgg"] = {
 "Kusunda",
 33630,
 "qfa-iso",
 "Latn",
}
m["kgi"] = {
 "Selangor Sign Language",
 33731,
 "sgn",
}
m["kgj"] = {
 "Gamale Kham",
 22236996,
 "sit-kha",
}
m["kgk"] = {
 "Kaiwá",
 3111883,
 "tup-gua",
 "Latn",
}
m["kgl"] = {
 "Kunggari",
 10550184,
 "aus-pam",
}
m["kgm"] = {
 "Karipúna",
 6371069,
}
m["kgn"] = {
 "Karingani",
 6371041,
 "xme-ttc",
 ancestors = "xme-ttc-nor",
}
m["kgo"] = {
 "Krongo",
 6438927,
 "qfa-kad",
 "Latn",
}
m["kgp"] = {
 "Kaingang",
 2665734,
 "sai-sje",
 "Latn",
}
m["kgq"] = {
 "Kamoro",
 6359001,
 "ngf",
}
m["kgr"] = {
 "Abun",
 56657,
 "paa",
}
m["kgs"] = {
 "Kumbainggar",
 3915412,
 "aus-pam",
}
m["kgt"] = {
 "Somyev",
 3913354,
 "nic-mmb",
 "Latn",
}
m["kgu"] = {
 "Kobol",
 11732325,
 "ngf-mad",
}
m["kgv"] = {
 "Karas",
 6368621,
 "ngf",
}
m["kgw"] = {
 "Karon Dori",
 56817,
}
m["kgx"] = {
 "Kamaru",
 12953604,
 "poz",
}
m["kgy"] = {
 "Kyerung",
 12952691,
 "sit-kyk",
}
m["kha"] = {
 "Khasi",
 33584,
 "aav-pkl",
 "Latn, as-Beng",
}
m["khb"] = {
 "Lü",
 36948,
 "tai-swe",
 "Talu, Lana",
 translit = {Talu = "Talu-translit"},
 entry_name = {remove_diacritics = c.ZWNJ},
 sort_key = {
  Talu = "Talu-sortkey",
  Lana = "Lana-sortkey",
 },
}
m["khc"] = {
 "Tukang Besi North",
 18611555,
 "poz",
}
m["khd"] = {
 "Bädi Kanum",
 20888004,
 "paa-yam",
}
m["khe"] = {
 "Korowai",
 6432598,
 "ngf",
}
m["khf"] = {
 "Khuen",
 27144893,
 "mkh",
}
m["khh"] = {
 "Kehu",
 10994953,
}
m["khj"] = {
 "Kuturmi",
 3914490,
 "nic-plc",
 "Latn",
}
m["khl"] = {
 "Lusi",
 3267788,
 "poz-ocw",
 "Latn",
}
m["khn"] = {
 "Khandeshi",
 33726,
 "inc-sou",
 ancestors = "pra-mah",
}
m["kho"] = {
 "Khotanese",
 6583551,
 "xsc-sak",
 "Brah, Khar",
 translit = "Brah-translit",
}
m["khp"] = {
 "Kapauri",
 3502575,
 "paa-tkw",
}
m["khq"] = {
 "Koyra Chiini",
 33600,
 "son",
}
m["khr"] = {
 "Kharia",
 3915562,
 "mun",
}
m["khs"] = {
 "Kasua",
 6374863,
 "ngf",
}
m["kht"] = {
 "Khamti",
 3915502,
 "tai-swe",
 "Mymr",
 entry_name = {remove_diacritics = c.VS01},
}
m["khu"] = {
 "Nkhumbi",
 11019169,
 "bnt-swb",
}
m["khv"] = {
 "Khvarshi",
 56425,
 "cau-wts",
 "Cyrl",
 translit = "khv-translit",
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
}
m["khw"] = {
 "Khowar",
 938216,
 "inc-dar",
 "Arab",
}
m["khx"] = {
 "Kanu",
 12952571,
 "bnt-lgb",
}
m["khy"] = {
 "Ekele",
 6385549,
 "bnt-ske",
 "Latn",
}
m["khz"] = {
 "Keapara",
 12952603,
 "poz-ocw",
 "Latn",
}
m["kia"] = {
 "Kim",
 35685,
 "alv-kim",
}
m["kib"] = {
 "Koalib",
 35859,
 "alv-hei",
}
m["kic"] = {
 "Kickapoo",
 20162127,
 "alg-sfk",
 "Latn",
}
m["kid"] = {
 "Koshin",
 35632,
 "nic-beb",
 "Latn",
}
m["kie"] = {
 "Kibet",
 56893,
}
m["kif"] = {
 "Eastern Parbate Kham",
 12953022,
 "sit-kha",
}
m["kig"] = {
 "Kimaama",
 11732321,
 "ngf",
}
m["kih"] = {
 "Kilmeri",
 6408020,
 "paa-brd",
}
m["kii"] = {
 "Kitsai",
 56627,
 "cdd",
 "Latn",
}
m["kij"] = {
 "Kilivila",
 3196601,
 "poz-ocw",
 "Latn",
}
m["kil"] = {
 "Kariya",
 3438708,
 "cdc-wst",
}
m["kim"] = {
 "Tofa",
 36848,
 "trk-sib",
 "Cyrl",
}
m["kio"] = {
 "Kiowa",
 56631,
 "nai-kta",
 "Latn",
}
m["kip"] = {
 "Sheshi Kham",
 12952622,
 "sit-kha",
}
m["kiq"] = {
 "Kosadle",
 6432994,
}
m["kis"] = {
 "Kis",
 6416362,
 "poz-ocw",
 "Latn",
}
m["kit"] = {
 "Agob",
 3332143,
}
m["kiv"] = {
 "Kimbu",
 10997740,
 "bnt-tkm",
}
m["kiw"] = {
 "Northeast Kiwai",
 11732324,
 "paa-kiw",
}
m["kix"] = {
 "Khiamniungan Naga",
 6401546,
 "sit-kch",
 "Latn",
}
m["kiy"] = {
 "Kirikiri",
 6415159,
 "paa-lkp",
}
m["kiz"] = {
 "Kisi",
 3912772,
 "bnt-bki",
}
m["kja"] = {
 "Mlap",
 6885683,
 "paa-nim",
}
m["kjb"] = {
 "Q'anjob'al",
 35551,
 "myn",
 "Latn",
}
m["kjc"] = {
 "Coastal Konjo",
 3198689,
 "poz",
}
m["kjd"] = {
 "Southern Kiwai",
 11732322,
 "paa-kiw",
}
m["kje"] = {
 "Kisar",
 3197441,
 "poz",
}
m["kjg"] = {
 "Khmu",
 33335,
 "mkh",
 "Laoo",
 sort_key = "Laoo-sortkey",
}
m["kjh"] = {
 "Khakas",
 33575,
 "trk-sib",
 "Cyrl",
 translit = "kjh-translit",
 override_translit = true,
}
m["kji"] = {
 "Zabana",
 379130,
 "poz-ocw",
 "Latn",
}
m["kjj"] = {
 "Khinalug",
 35278,
 "cau-nec",
 "Cyrl, Latn",
 translit = "kjj-translit",
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
}
m["kjk"] = {
 "Highland Konjo",
 3198688,
 "poz",
}
m["kjl"] = {
 "Kham",
 22237017,
 "sit-kha",
}
m["kjm"] = {
 "Kháng",
 6403501,
 "mkh-pal",
}
m["kjn"] = {
 "Kunjen",
 3200468,
 "aus-pmn",
 "Latn",
}
m["kjo"] = {
 "Harijan Kinnauri",
 5657463,
 "him",
}
m["kjp"] = {
 "Eastern Pwo",
 5330390,
 "kar",
 "Mymr, Leke, Thai",
}
m["kjq"] = {
 "Western Keres",
 12645568,
 "nai-ker",
 "Latn",
}
m["kjr"] = {
 "Kurudu",
 12952678,
 "poz-hce",
 "Latn",
}
m["kjs"] = {
 "East Kewa",
 20050949,
 "paa-eng",
}
m["kjt"] = {
 "Phrae Pwo",
 7187991,
 "kar",
 "Thai",
}
m["kju"] = {
 "Kashaya",
 3193689,
 "nai-pom",
 "Latn",
}
m["kjx"] = {
 "Ramopa",
 56830,
 "paa-nbo",
}
m["kjy"] = {
 "Erave",
 12952416,
 "paa-eng",
}
m["kjz"] = {
 "Bumthangkha",
 2786408,
 "sit-ebo",
 "Tibt",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["kka"] = {
 "Kakanda",
 3915342,
 "alv-ngb",
}
m["kkb"] = {
 "Kwerisa",
 56881,
 "paa-lkp",
}
m["kkc"] = {
 "Odoodee",
 12952987,
}
m["kkd"] = {
 "Kinuku",
 6414422,
 "nic-kau",
}
m["kke"] = {
 "Kakabe",
 3913966,
 "dmn-mok",
 "Latn",
}
m["kkf"] = {
 "Kalaktang Monpa",
 63257089,
 "sit-tsk",
 "Tibt, Latn, Deva",
 translit = {Tibt = "Tibt-translit"},
 override_translit = true,
 display_text = {Tibt = s["Tibt-displaytext"]},
 entry_name = {Tibt = s["Tibt-entryname"]},
 sort_key = {Tibt = "Tibt-sortkey"},
}
m["kkg"] = {
 "Mabaka Valley Kalinga",
 18753304,
 "phi",
}
m["kkh"] = {
 "Khün",
 3545044,
 "tai-swe",
 "Lana, Thai",
 sort_key = "nod-sortkey",
}
m["kki"] = {
 "Kagulu",
 12952537,
 "bnt-ruv",
 "Latn",
}
m["kkj"] = {
 "Kako",
 35755,
 "bnt-kak",
}
m["kkk"] = {
 "Kokota",
 3198399,
 "poz-ocw",
 "Latn",
}
m["kkl"] = {
 "Kosarek Yale",
 6432995,
 "ngf",
}
m["kkm"] = {
 "Kiong",
 6414512,
 "nic-ucr",
 "Latn",
}
m["kkn"] = {
 "Kon Keu",
 6428686,
 "mkh-pal",
}
m["kko"] = {
 "Karko",
 35529,
 "nub-hil",
}
m["kkp"] = {
 "Koko-Bera",
 6426699,
 "aus-pmn",
 "Latn",
}
m["kkq"] = {
 "Kaiku",
 6347840,
 "bnt-kbi",
 "Latn",
}
m["kkr"] = {
 "Kir-Balar",
 3440527,
 "cdc-wst",
 "Latn",
}
m["kks"] = {
 "Kirfi",
 56242,
 "cdc-wst",
 "Latn",
}
m["kkt"] = {
 "Koi",
 6426194,
 "sit-kiw",
}
m["kku"] = {
 "Tumi",
 3913934,
 "nic-kau",
}
m["kkv"] = {
 "Kangean",
 2071325,
 "poz-msa",
 "Latn",
}
m["kkw"] = {
 "Teke-Kukuya",
 36560,
 "bnt-tek",
}
m["kkx"] = {
 "Kohin",
 6425997,
 "poz-brw",
}
m["kky"] = {
 "Guugu Yimidhirr",
 56543,
 "aus-pam",
 "Latn",
}
m["kkz"] = {
 "Kaska",
 20823,
 "ath-nor",
 "Latn",
}
m["kla"] = {
 "Klamath-Modoc",
 2669248,
 "nai-plp",
 "Latn",
}
m["klb"] = {
 "Kiliwa",
 3182593,
 "nai-yuc",
 "Latn",
}
m["klc"] = {
 "Kolbila",
 6427122,
 "alv-lek",
}
m["kld"] = {
 "Gamilaraay",
 3111818,
 "aus-cww",
 "Latn",
}
m["kle"] = {
 "Kulung",
 6443304,
 "sit-kic",
}
m["klf"] = {
 "Kendeje",
 56895,
}
m["klg"] = {
 "Tagakaulu Kalagan",
 18756514,
 "phi",
}
m["klh"] = {
 "Weliki",
 7981017,
 "ngf-fin",
 "Latn",
}
m["kli"] = {
 "Kalumpang",
 13561407,
 "poz",
}
m["klj"] = {
 "Khalaj",
 33455,
 "trk",
 "fa-Arab, Latn",
 ancestors = "klj-arg",
 entry_name = {
  remove_diacritics = c.kashida .. c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun,
 }
}
m["klk"] = {
 "Kono (Nigeria)",
 6429589,
 "nic-kau",
 "Latn",
}
m["kll"] = {
 "Kagan Kalagan",
 18748913,
 "phi",
}
m["klm"] = {
 "Kolom",
 6844970,
 "ngf-mad",
 "Latn",
}
m["kln"] = {
 "Kalenjin",
 637228,
 "sdv-nma",
 "Latn",
}
m["klo"] = {
 "Kapya",
 6367410,
 "nic-ykb",
}
m["klp"] = {
 "Kamasa",
 6356107,
 "ngf",
}
m["klq"] = {
 "Rumu",
 7379420,
 "ngf",
}
m["klr"] = {
 "Khaling",
 56381,
 "sit-kiw",
}
m["kls"] = {
 "Kalasha",
 33416,
 "inc-dar",
 "Latn, ks-Arab",
}
m["klt"] = {
 "Nukna",
 7068874,
 "ngf-fin",
 "Latn",
}
m["klu"] = {
 "Klao",
 3914866,
 "kro-wkr",
}
m["klv"] = {
 "Maskelynes",
 3297282,
 "poz-vnc",
 "Latn",
}
m["klw"] = {
 "Lindu",
 18390055,
 "poz-kal",
}
m["klx"] = {
 "Koluwawa",
 6427954,
 "poz-ocw",
 "Latn",
}
m["kly"] = {
 "Kalao",
 6350643,
 "poz",
}
m["klz"] = {
 "Kabola",
 11732258,
 "qfa-tap",
}
m["kma"] = {
 "Konni",
 35680,
 "nic-buk",
}
m["kmb"] = {
 "Kimbundu",
 35891,
 "bnt-kmb",
 "Latn",
}
m["kmc"] = {
 "Southern Kam",
 35379,
 "qfa-kms",
 "Latn",
}
m["kmd"] = {
 "Madukayang Kalinga",
 18753305,
 "phi",
}
m["kme"] = {
 "Bakole",
 35068,
 "bnt-kpw",
}
m["kmf"] = {
 "Kare (New Guinea)",
 11732286,
 "ngf-mad",
 "Latn",
}
m["kmg"] = {
 "Kâte",
 3201059,
 "ngf",
}
m["kmh"] = {
 "Kalam",
 12952550,
 "ngf-mad",
}
m["kmi"] = {
 "Kami",
 3915372,
 "alv-ngb",
 "Latn",
}
m["kmj"] = {
 "Kumarbhag Paharia",
 3130374,
 "dra",
 "Beng, Deva",
}
m["kmk"] = {
 "Limos Kalinga",
 18753303,
 "phi",
}
m["kml"] = {
 "Tanudan Kalinga",
 18753307,
 "phi",
 "Latn",
}
m["kmm"] = {
 "Kom (India)",
 12952647,
 "tbq-kuk",
}
m["kmn"] = {
 "Awtuw",
 3504217,
 "paa-spk",
}
m["kmo"] = {
 "Kwoma",
 11732376,
 "paa-spk",
}
m["kmp"] = {
 "Gimme",
 11152236,
 "alv-dur",
}
m["kmq"] = {
 "Kwama",
 2591184,
 "ssa-kom",
}
m["kmr"] = {
 "Northern Kurdish",
 36163,
 "ku",
 "Latn, Cyrl, Armn, ku-Arab",
 translit = {
  Cyrl = "kmr-translit",
  Armn = "Armn-translit",
  ["ku-Arab"] = "ckb-translit",
 },
 entry_name = {
  remove_diacritics = "'’",
  from = {"r̄", "R̄", "ẍ", "Ẍ"},
  to = {"rr", "Rr", "x", "X"}
 },
 wikimedia_codes = "ku",
}
m["kms"] = {
 "Kamasau",
 6356117,
 "qfa-tor",
 "Latn",
}
m["kmt"] = {
 "Kemtuik",
 6387179,
 "paa-nim",
}
m["kmu"] = {
 "Kanite",
 12952567,
 "paa-kag",
}
m["kmv"] = {
 "Karipúna Creole French",
 2523999,
 "crp",
 "Latn",
 ancestors = "fr",
 sort_key = s["roa-oil-sortkey"],
}
m["kmw"] = {
 "Kumu",
 6428450,
 "bnt-kbi",
 "Latn",
}
m["kmx"] = {
 "Waboda",
 7958705,
 "paa-kiw",
}
m["kmy"] = {
 "Koma",
 35634,
 "alv-dur",
}
m["kmz"] = {
 "Khorasani Turkish",
 35373,
 "trk-ogz",
 ancestors = "trk-oat",
}
m["kna"] = {
 "Kanakuru",
 56811,
 "cdc-wst",
 "Latn",
}
m["knb"] = {
 "Lubuagan Kalinga",
 12953602,
 "phi",
}
m["knd"] = {
 "Konda",
 11732340,
 "ngf-sbh",
 "Latn",
}
m["kne"] = {
 "Kankanaey",
 18753329,
 "phi",
 "Latn",
}
m["knf"] = {
 "Mankanya",
 35789,
 "alv-pap",
}
m["kni"] = {
 "Kanufi",
 3913297,
 "nic-nin",
 "Latn",
}
m["knj"] = {
 "Akatek",
 34923,
 "myn",
 "Latn",
}
m["knk"] = {
 "Kuranko",
 3198896,
 "dmn-mok",
 "Latn",
}
m["knl"] = {
 "Keninjal",
 6389309,
 "poz-mly",
}
m["knm"] = { -- two unrelated lects have this name; this is the Katukinian one
 "Kanamari",
 3438373,
 "sai-ktk",
 "Latn",
}
m["kno"] = {
 "Kono (Sierra Leone)",
 35675,
 "dmn-vak",
}
m["knp"] = {
 "Kwanja",
 35641,
 "nic-mmb",
 "Latn",
}
m["knq"] = {
 "Kintaq",
 6414335,
 "mkh-asl",
}
m["knr"] = {
 "Kaningra",
 6363253,
 "paa-spk",
}
m["kns"] = {
 "Kensiu",
 6391529,
 "mkh-asl",
}
m["knt"] = {
 "Katukina",
 3194265,
 "sai-pan",
 "Latn",
}
m["knu"] = { -- a dialect of 'kpe'
 "Kono (Guinea)",
 3198703,
 "dmn-msw",
 "Latn",
 ancestors = "kpe",
}
m["knv"] = {
 "Tabo",
 7959888,
 "aav",
}
m["knx"] = {
 "Kendayan",
 6388963,
 "poz-mly",
 "Latn",
}
m["kny"] = {
 "Kanyok",
 11110766,
 "bnt-lub",
}
m["knz"] = {
 "Kalamsé",
 3914000,
 "nic-gnn",
}
m["koa"] = {
 "Konomala",
 3198732,
 "poz-ocw",
 "Latn",
}
m["koc"] = {
 "Kpati",
 3913279,
 "nic-nge",
 "Latn",
}
m["kod"] = {
 "Kodi",
 4577633,
}
m["koe"] = {
 "Kacipo-Balesi",
 5364424,
 "sdv",
}
m["kof"] = {
 "Kubi",
 3438718,
 "cdc-wst",
 "Latn",
}
m["kog"] = {
 "Cogui",
 3198286,
 "cba",
}
m["koh"] = {
 "Koyo",
 35649,
 "bnt-mbo",
 "Latn",
}
m["koi"] = {
 "Komi-Permyak",
 56318,
 "urj-prm",
 "Cyrl",
 translit = "kv-translit",
 entry_name = {remove_diacritics = c.acute},
 override_translit = true,
}
m["kok"] = {
 "Konkani",
 34239,
 "inc-sou",
 "Deva, Knda, Mlym, fa-Arab, Latn",
 ancestors = "pra-mah",
 translit = {
  Deva = "mr-translit",
  Knda = "kn-translit",
  Mlym = "ml-translit",
 },
 entry_name = {
  from = {"च़", "ज़", "झ़", "ಚ಼", "ಜ಼", "ಝ಼"},
  to = {"च", "ज", "झ", "ಚ", "ಜ", "ಝ"}
 } ,
}
m["kol"] = {
 "Kol (New Guinea)",
 4227542,
}
m["koo"] = {
 "Konzo",
 2361829,
 "bnt-glb",
}
m["kop"] = {
 "Waube",
 11732373,
 "ngf-mad",
}
m["koq"] = {
 "Kota (Gabon)",
 35607,
 "bnt-kel",
 "Latn",
}
m["kos"] = {
 "Kosraean",
 33464,
 "poz-mic",
 "Latn",
}
m["kot"] = {
 "Lagwan",
 3502264,
 "cdc-cbm",
 "Latn",
}
m["kou"] = {
 "Koke",
 797249,
 "alv-bua",
}
m["kov"] = {
 "Kudu-Camo",
 3915850,
 "nic-jer",
}
m["kow"] = {
 "Kugama",
 3913307,
 "alv-mye",
}
m["koy"] = {
 "Koyukon",
 28304,
 "ath-nor",
 "Latn",
}
m["koz"] = {
 "Korak",
 6431365,
 "ngf-mad",
}
m["kpa"] = {
 "Kutto",
 3437656,
 "cdc-wst",
}
m["kpb"] = {
 "Mullu Kurumba",
 19573111,
 "dra",
}
m["kpc"] = {
 "Curripaco",
 2882543,
 "awd-nwk",
 "Latn",
}
m["kpd"] = {
 "Koba",
 6424249,
 "poz",
}
m["kpe"] = {
 "Kpelle",
 35673,
 "dmn-msw",
 "Latn",
}
m["kpf"] = {
 "Komba",
 6428239,
 "ngf",
}
m["kpg"] = {
 "Kapingamarangi",
 35771,
 "poz-pnp",
 "Latn",
}
m["kph"] = {
 "Kplang",
 35628,
 "alv-gng",
}
m["kpi"] = {
 "Kofei",
 6425665,
 "paa-egb",
}
m["kpj"] = {
 "Karajá",
 10322066,
 "sai-mje",
 "Latn",
}
m["kpk"] = {
 "Kpan",
 3915380,
 "nic-jkn",
 "Latn",
}
m["kpl"] = {
 "Kpala",
 11154769,
 "nic-nkk",
 "Latn",
}
m["kpm"] = {
 "Koho",
 3511919,
 "mkh-ban",
 "Latn",
}
m["kpn"] = {
 "Kepkiriwát",
 3195366,
 "tup",
 "Latn",
}
m["kpo"] = {
 "Ikposo",
 35029,
 "alv-ktg",
 "Latn",
}
m["kpp"] = {
 "Paku Karen",
 nil,
}
m["kpq"] = {
 "Korupun-Sela",
 6432769,
 "ngf",
}
m["kpr"] = {
 "Korafe-Yegha",
 11732347,
 "ngf",
}
m["kps"] = {
 "Tehit",
 7694851,
}
m["kpt"] = {
 "Karata",
 56636,
 "cau-and",
 "Cyrl",
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
}
m["kpu"] = {
 "Kafoa",
 6346151,
 "qfa-tap",
}
m["kpv"] = {
 "Komi-Zyrian",
 34114,
 "urj-prm",
 "Cyrl",
 translit = "kv-translit",
 override_translit = true,
 wikimedia_codes = "kv",
}
m["kpw"] = {
 "Kobon",
 11732326,
 "ngf-mad",
}
m["kpx"] = {
 "Mountain Koiari",
 6925030,
 "ngf",
}
m["kpy"] = {
 "Koryak",
 36199,
 "qfa-cka",
 "Cyrl",
 entry_name = {
  from = {"['’]"},
  to = {"ʼ"}
 },
 sort_key = {
  from = {"вʼ", "гʼ", "ё", "ӄ", "ӈ"},
  to = {"в" .. p[1], "г" .. p[1], "е" .. p[1], "к" .. p[1], "н" .. p[1]}
 },
}
m["kpz"] = {
 "Kupsabiny",
 56445,
 "sdv-kln",
}
m["kqa"] = {
 "Mum",
 6935252,
 "ngf-mad",
}
m["kqb"] = {
 "Kovai",
 6434822,
 "ngf",
}
m["kqc"] = {
 "Doromu-Koki",
 5298175,
 "ngf",
}
m["kqd"] = {
 "Koy Sanjaq Surat",
 33463,
 "sem-nna",
}
m["kqe"] = {
 "Kalagan",
 18748906,
 "phi",
}
m["kqf"] = {
 "Kakabai",
 6349119,
 "poz-ocw",
 "Latn",
}
m["kqg"] = {
 "Khe",
 3914015,
 "nic-gur",
}
m["kqh"] = {
 "Kisankasa",
 6416409,
 "sdv",
}
m["kqi"] = {
 "Koitabu",
 6426363,
 "ngf",
}
m["kqj"] = {
 "Koromira",
 6432520,
 "paa-sbo",
}
m["kqk"] = {
 "Kotafon Gbe",
 12952447,
 "alv-pph",
}
m["kql"] = {
 "Kyenele",
 11732453,
 "paa-yua",
}
m["kqm"] = {
 "Khisa",
 3913955,
 "nic-gur",
}
m["kqn"] = {
 "Kaonde",
 33601,
 "bnt-lub",
 "Latn",
}
m["kqo"] = {
 "Eastern Krahn",
 3915374,
 "kro-wee",
}
m["kqp"] = {
 "Kimré",
 3441210,
 "cdc-est",
}
m["kqq"] = {
 "Krenak",
 6436747,
 "sai-cer",
}
m["kqr"] = {
 "Kimaragang",
 3196845,
 "poz-san",
 "Latn",
}
m["kqs"] = {
 "Northern Kissi",
 19921576,
 "alv-kis",
}
m["kqt"] = {
 "Klias River Kadazan",
 12953594,
 "poz-san",
}
m["kqu"] = {
 "Seroa",
 33127766,
 "khi-tuu",
}
m["kqv"] = {
 "Okolod",
 7082487,
 "poz-san",
}
m["kqw"] = {
 "Kandas",
 3192590,
 "poz-ocw",
 "Latn",
}
m["kqx"] = {
 "Mser",
 3502347,
 "cdc-cbm",
}
m["kqy"] = {
 "Koorete",
 6430753,
 "omv-eom",
}
m["kqz"] = {
 "Korana",
 2756709,
 "khi-khk",
 "Latnx",
}
m["kra"] = {
 "Kumhali",
 13580783,
 "inc-eas",
 ancestors = "bh",
}
m["krb"] = {
 "Karkin",
 3193345,
 "nai-you",
 "Latn",
}
m["krc"] = {
 "Karachay-Balkar",
 33714,
 "trk-kcu",
 "Cyrl",
 translit = "krc-translit",
 sort_key = {
  from = {"гъ", "дж", "ё", "къ", "нг"},
  to = {"г" .. p[1], "д" .. p[1], "е" .. p[1], "к" .. p[1], "н" .. p[1]}
 },
}
m["krd"] = {
 "Kairui-Midiki",
 12953277,
 "poz-tim",
}
m["kre"] = {
 "Panará",
 3361895,
 "sai-cer",
}
m["krf"] = {
 "Koro (Vanuatu)",
 3198995,
 "poz-oce",
 "Latn",
}
m["krh"] = {
 "Kurama",
 35593,
 "nic-kau",
}
m["kri"] = {
 "Krio",
 35744,
 "crp",
 "Latn",
 ancestors = "en",
}
m["krj"] = {
 "Kinaray-a",
 33720,
 "phi",
 "Latn",
}
m["krk"] = {
 "Kerek",
 332792,
 "qfa-cka",
 "Cyrl",
}
m["krl"] = {
 "Karelian",
 33557,
 "urj-fin",
 "Latn",
 sort_key = {
  from = {
   "č", "š", "ž", "ü", "ä", "ö", -- 2 chars
   "z", "'" -- 1 char
  },
  to = {
   "c" .. p[1], "s" .. p[1], "s" .. p[3], "y" .. p[1], "y" .. p[2], "y" .. p[3],
   "s" .. p[2], "y" .. p[4],
  }
 },
}
m["krm"] = {
 "Krim",
 35713,
 "alv",
}
m["krn"] = {
 "Sapo",
 3915386,
 "kro-wee",
}
m["krp"] = {
 "Korop",
 35626,
 "nic-ucr",
 "Latn",
}
m["krr"] = {
 "Kru'ng",
 12953650,
 "mkh-ban",
}
m["krs"] = {
 "Kresh",
 56674,
 "csu-bkr",
}
m["kru"] = {
 "Kurukh",
 33492,
 "dra",
 "Deva",
}
m["krv"] = {
 "Kavet",
 12953649,
 "sai-ktk",
 "Latn",
}
m["krw"] = {
 "Western Krahn",
 10975611,
 "kro-wee",
}
m["krx"] = {
 "Karon",
 35704,
 "alv-jol",
}
m["kry"] = {
 "Kryts",
 35861,
 "cau-ssm",
 "Latn, Cyrl",
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Latn = s["cau-Latn-entryname"],
  Cyrl = s["cau-Cyrl-entryname"],
 },
}
m["krz"] = {
 "Sota Kanum",
 12952568,
 "paa-yam",
}
m["ksa"] = {
 "Shuwa-Zamani",
 3913929,
 "nic-kau",
}
m["ksb"] = {
 "Shambala",
 3788739,
 "bnt-seu",
 "Latn",
}
m["ksc"] = {
 "Southern Kalinga",
 18753301,
 "phi",
}
m["ksd"] = {
 "Tolai",
 35870,
 "poz-ocw",
 "Latn",
}
m["kse"] = {
 "Kuni",
 6444619,
 "poz-ocw",
 "Latn",
}
m["ksf"] = {
 "Bafia",
 34930,
 "bnt-baf",
}
m["ksg"] = {
 "Kusaghe",
 3200638,
 "poz-ocw",
 "Latn",
}
m["ksi"] = {
 "Krisa",
 841704,
 "paa-msk",
 "Latn",
}
m["ksj"] = {
 "Uare",
 6450052,
 "ngf",
}
m["ksk"] = {
 "Kansa",
 3192772,
 "sio-dhe",
}
m["ksl"] = {
 "Kumalu",
 17584381,
 "poz-ocw",
 "Latn",
}
m["ksm"] = {
 "Kumba",
 3913972,
 "alv-mye",
}
m["ksn"] = {
 "Kasiguranin",
 6374525,
 "phi",
}
m["kso"] = {
 "Kofa",
 56278,
 "cdc-cbm",
}
m["ksp"] = {
 "Kaba",
 3915316,
 "csu-sar",
}
m["ksq"] = {
 "Kwaami",
 3440525,
 "cdc-wst",
}
m["ksr"] = {
 "Borong",
 4946263,
 "ngf",
}
m["kss"] = {
 "Southern Kissi",
 11028974,
 "alv-kis",
}
m["kst"] = {
 "Winyé",
 3913360,
 "nic-gnw",
}
m["ksu"] = {
 "Khamyang",
 6583541,
 "tai-swe",
}
m["ksv"] = {
 "Kusu",
 6448199,
 "bnt-tet",
}
m["ksw"] = {
 "S'gaw Karen",
 56410,
 "kar",
 "Mymr",
 translit = "ksw-translit",
}
m["ksx"] = {
 "Kedang",
 6382520,
 "poz",
 "Latn",
}
m["ksy"] = {
 "Kharia Thar",
 6400661,
 "inc-eas",
 ancestors = "pra-mag",
}
m["ksz"] = {
 "Kodaku",
 21179986,
 "mun",
}
m["kta"] = {
 "Katua",
 6378404,
 "mkh-ban",
}
m["ktb"] = {
 "Kambaata",
 35664,
 "cus-hec",
 "Latn",
}
m["ktc"] = {
 "Kholok",
 3440464,
 "cdc-wst",
}
m["ktd"] = {
 "Kokata",
 10547021,
 "aus-pam",
}
m["ktf"] = {
 "Kwami",
 12952687,
 "bnt-lgb",
}
m["ktg"] = {
 "Kalkatungu",
 3914057,
 "aus-pam",
 "Latn",
}
m["kth"] = {
 "Karanga",
 713643,
}
m["kti"] = {
 "North Muyu",
 20857698,
 "ngf",
 "Latn",
}
m["ktj"] = {
 "Plapo Krumen",
 10975356,
 "kro-grb",
}
m["ktk"] = {
 "Kaniet",
 3399050,
 "poz-aay",
 "Latn",
}
m["ktl"] = {
 "Koroshi",
 3775265,
 "ira-nwi",
 ancestors = "bal",
}
m["ktm"] = {
 "Kurti",
 3200615,
 "poz-aay",
 "Latn",
}
m["ktn"] = {
 "Karitiâna",
 3112184,
 "tup",
 "Latn",
}
m["kto"] = {
 "Kuot",
 56537,
}
m["ktp"] = {
 "Kaduo",
 769809,
 "tbq-lol",
}
m["ktq"] = {
 "Katabaga",
 3193895,
}
m["ktr"] = {
 "Kota Marudu Tinagas",
 18642280,
}
m["kts"] = {
 "South Muyu",
 42308820,
 "ngf",
 "Latn",
}
m["ktt"] = {
 "Ketum",
 12952616,
 "ngf",
}
m["ktu"] = {
 "Kituba",
 35746,
 "crp",
 "Latn",
 ancestors = "kg",
}
m["ktv"] = {
 "Eastern Katu",
 22808951,
 "mkh-kat",
}
m["ktw"] = {
 "Kato",
 20831,
 "ath-pco",
 "Latn",
}
m["ktx"] = {
 "Kaxararí",
 6380124,
 "sai-pan",
 "Latn",
}
m["kty"] = {
 "Kango",
 6362818,
 "bnt-bta",
 "Latn",
}
m["ktz"] = {
 "Juǀ'hoan",
 1192295,
 "khi-kxa",
 "Latn",
}
m["kub"] = {
 "Kutep",
 35645,
 "nic-jkn",
}
m["kuc"] = {
 "Kwinsu",
 6450460,
 "paa-tkw",
}
m["kud"] = {
 "Auhelawa",
 5166,
 "poz-ocw",
 "Latn",
}
m["kue"] = {
 "Kuman",
 137525,
 "ngf",
 "Latn",
}
m["kuf"] = {
 "Western Katu",
 6378400,
 "mkh-kat",
 "Laoo, Tale",
}
m["kug"] = {
 "Kupa",
 3915336,
 "alv-ngb",
}
m["kuh"] = {
 "Kushi",
 3438747,
 "cdc-wst",
}
m["kui"] = {
 "Kuikúro",
 3915522,
 "sai-kui",
 "Latn",
}
m["kuj"] = {
 "Kuria",
 6445968,
 "bnt-lok",
 "Latn",
}
m["kuk"] = {
 "Kepo'",
 6393217,
 "poz",
}
m["kul"] = {
 "Kulere",
 3440506,
 "cdc-wst",
}
m["kum"] = {
 "Kumyk",
 36209,
 "trk-kcu",
 "Cyrl",
 translit = "kum-translit",
 sort_key = {
  from = {"гъ", "гь", "ё", "къ", "нг", "оь", "уь"},
  to = {"г" .. p[1], "г" .. p[2], "е" .. p[1], "к" .. p[1], "н" .. p[1], "о" .. p[1], "у" .. p[1]}
 },
}
m["kun"] = {
 "Kunama",
 36041,
}
m["kuo"] = {
 "Kumukio",
 11732362,
 "ngf",
}
m["kup"] = {
 "Kunimaipa",
 6444696,
}
m["kuq"] = {
 "Karipuna",
 6371071,
 "tup-gua",
 "Latn",
}
m["kus"] = {
 "Kusaal",
 35708,
 "nic-dag",
 "Latn",
}
m["kut"] = {
 "Kutenai",
 33434,
 "qfa-iso",
}
m["kuu"] = {
 "Upper Kuskokwim",
 28062,
 "ath-nor",
}
m["kuv"] = {
 "Kur",
 12635082,
 "poz-cma",
 "Latn",
}
m["kuw"] = {
 "Kpagua",
 11137573,
 "bad-cnt",
}
m["kux"] = {
 "Kukatja",
 10549839,
 "aus-pam",
}
m["kuy"] = {
 "Kuuku-Ya'u",
 10550697,
 "aus-pmn",
}
m["kuz"] = {
 "Kunza",
 2669181,
 "qfa-iso",
}
m["kva"] = {
 "Bagvalal",
 56638,
 "cau-and",
 "Cyrl",
 translit = "cau-nec-translit",
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
}
m["kvb"] = {
 "Kubu",
 6441341,
 "poz-mly",
}
m["kvc"] = {
 "Kove",
 3199402,
 "poz-ocw",
 "Latn",
}
m["kvd"] = {
 "Kui (Indonesia)",
 6442230,
 "ngf",
}
m["kve"] = {
 "Kalabakan",
 6350003,
 "poz-san",
}
m["kvf"] = {
 "Kabalai",
 3440427,
 "cdc-est",
}
m["kvg"] = {
 "Kuni-Boazi",
 2907551,
 "ngf",
}
m["kvh"] = {
 "Komodo",
 3198565,
 "poz-cet",
}
m["kvi"] = {
 "Kwang",
 3440398,
 "cdc-est",
 "Latn",
}
m["kvj"] = {
 "Psikye",
 56304,
 "cdc-cbm",
}
m["kvk"] = {
 "Korean Sign Language",
 3073428,
 "sgn-jsl",
}
m["kvl"] = {
 "Brek Karen",
 12952577,
 "kar",
}
m["kvm"] = {
 "Kendem",
 35751,
 "nic-mam",
 "Latn",
}
m["kvn"] = {
 "Border Kuna",
 31777873,
 "cba",
}
m["kvo"] = {
 "Dobel",
 5286559,
 "poz",
}
m["kvp"] = {
 "Kompane",
 18343041,
 "poz",
}
m["kvq"] = {
 "Geba Karen",
 12952581,
 "kar",
}
m["kvr"] = {
 "Kerinci",
 3195442,
 "poz-mly",
}
m["kvt"] = {
 "Lahta Karen",
 12952582,
 "kar",
}
m["kvu"] = {
 "Yinbaw Karen",
 14426328,
 "kar",
}
m["kvv"] = {
 "Kola",
 6426967,
 "poz",
}
m["kvw"] = {
 "Wersing",
 7983599,
 "qfa-tap",
}
m["kvx"] = {
 "Parkari Koli",
 3244176,
 "inc-wes",
}
m["kvy"] = {
 "Yintale Karen",
 14426329,
 "kar",
}
m["kvz"] = {
 "Tsakwambo",
 7849438,
 "ngf",
}
m["kwa"] = {
 "Dâw",
 3042278,
 "sai-nad",
}
m["kwb"] = {
 "Baa",
 34842,
 "alv-ada",
}
m["kwc"] = {
 "Likwala",
 35597,
 "bnt-mbo",
}
m["kwd"] = {
 "Kwaio",
 3200796,
 "poz-sls",
 "Latn",
}
m["kwe"] = {
 "Kwerba",
 6450328,
 "paa-tkw",
}
m["kwf"] = {
 "Kwara'ae",
 3200829,
 "poz-oce",
}
m["kwg"] = {
 "Sara Kaba Deme",
 3915384,
 "csu-kab",
}
m["kwh"] = {
 "Kowiai",
 6435028,
 "poz",
}
m["kwi"] = {
 "Awa-Cuaiquer",
 2603103,
 "sai-bar",
 "Latn",
}
m["kwj"] = {
 "Kwanga",
 3438383,
 "paa-spk",
}
m["kwk"] = {
 "Kwak'wala",
 2640628,
 "wak",
 "Latn",
}
m["kwl"] = {
 "Kofyar",
 3441382,
 "cdc-wst",
 "Latn",
}
m["kwm"] = {
 "Kwambi",
 3487165,
 "bnt-ova",
}
m["kwn"] = {
 "Kwangali",
 36334,
 "bnt-kav",
 "Latn",
}
m["kwo"] = {
 "Kwomtari",
 3508116,
}
m["kwp"] = {
 "Kodia",
 3914867,
 "kro-ekr",
}
m["kwq"] = {
 "Kwak",
 11014183,
 "nic-nka",
 ancestors = "yam",
}
m["kwr"] = {
 "Kwer",
 12635137,
 "ngf-okk",
}
m["kws"] = {
 "Kwese",
 3200846,
 "bnt-pen",
}
m["kwt"] = {
 "Kwesten",
 6450354,
 "paa-tkw",
}
m["kwu"] = {
 "Kwakum",
 35624,
 "bnt-kak",
}
m["kwv"] = {
 "Sara Kaba Náà",
 3915361,
 "csu-kab",
}
m["kww"] = {
 "Kwinti",
 721182,
}
m["kwx"] = {
 "Khirwar",
 12976968,
 "dra",
}
m["kwz"] = {
 "Kwadi",
 2364661,
 "khi-kkw",
 "Latn",
}
m["kxa"] = {
 "Kairiru",
 3398785,
 "poz-ocw",
 "Latn",
}
m["kxb"] = {
 "Krobu",
 35586,
 "alv-ptn",
 "Latn",
}
m["kxc"] = {
 "Khonso",
 56624,
 "cus-eas",
}
m["kxd"] = {
 "Brunei Malay",
 3182878,
 "poz-mly",
 "Latn, ms-Arab",
}
m["kxe"] = {
 "Kakihum",
 3914433,
 "nic-kam",
 ancestors = "tvd",
}
m["kxf"] = {
 "Manumanaw Karen",
 12952592,
 "kar",
 "Mymr, Latn",
}
m["kxh"] = {
 "Karo",
 3447116,
 "omv-aro",
}
m["kxi"] = {
 "Keningau Murut",
 6389308,
 "poz-san",
 "Latn",
}
m["kxj"] = {
 "Kulfa",
 713654,
 "csu-kab",
}
m["kxk"] = {
 "Zayein Karen",
 14352960,
 "kar",
}
m["kxl"] = {
 "Nepali Kurux",
 3200624,
 "dra",
 "Deva",
}
m["kxm"] = {
 "Northern Khmer",
 3502234,
 "mkh-kmr",
 "Thai, Khmr",
 ancestors = "xhm",
 sort_key = {
  from = {"[%pๆ]", "[็-๎]", "([เแโใไ])([ก-ฮ])"},
  to = {"", "", "%2%1"}
 },
}
m["kxn"] = {
 "Kanowit",
 6364300,
 "poz-bnn",
 "Latn",
}
m["kxo"] = {
 "Kanoé",
 4356223,
 "qfa-iso",
}
m["kxp"] = {
 "Wadiyara Koli",
 12953645,
 "inc-wes",
}
m["kxq"] = {
 "Smärky Kanum",
 12952569,
 "paa-yam",
}
m["kxr"] = {
 "Koro (New Guinea)",
 3198994,
 "poz-oce",
 "Latn",
}
m["kxs"] = {
 "Kangjia",
 3182570,
 "xgn-shr",
}
m["kxt"] = {
 "Koiwat",
 6426388,
 "paa-spk",
}
m["kxu"] = {
 "Kui (India)",
 33919,
 "dra",
 "Orya",
 translit = "kxv-translit",
 entry_name = {
  remove_diacritics = "୕",
  from = {"ଆଆ", "ଇଇ", "ଉଉ", "ଏଏ", "ଓଓ", "ିଇ", "ୁଉ", "େଏ", "ୋଓ"},
  to = {"ଆ", "ଈ", "ଊ", "ଏ", "ଓ", "ୀ", "ୂ", "େ", "ୋ"},
 },
}
m["kxv"] = {
 "Kuvi",
 3200721,
 "dra",
 "Orya",
 translit = "kxv-translit",
 entry_name = {
  remove_diacritics = "୕",
  from = {"ଆଆ", "ଇଇ", "ଉଉ", "ଏଏ", "ଓଓ", "([କ-ହ])ଆ", "ିଇ", "ୁଉ", "େଏ", "ୋଓ"},
  to = {"ଆ", "ଈ", "ଊ", "ଏ", "ଓ", "%1ା", "ୀ", "ୂ", "େ", "ୋ"},
 },
}
m["kxw"] = {
 "Konai",
 11732339,
}
m["kxx"] = {
 "Likuba",
 35646,
 "bnt-bmo",
}
m["kxy"] = {
 "Kayong",
 6380673,
 "mkh",
}
m["kxz"] = {
 "Kerewo",
 6393847,
 "paa-kiw",
}
m["kya"] = {
 "Kwaya",
 6450276,
 "bnt-haj",
 "Latn",
}
m["kyb"] = {
 "Butbut Kalinga",
 18753300,
 "phi",
}
m["kyc"] = {
 "Kyaka",
 12952690,
 "paa-eng",
}
m["kyd"] = {
 "Karey",
 6370196,
 "poz",
}
m["kye"] = {
 "Krache",
 35658,
 "alv-gng",
}
m["kyf"] = {
 "Kouya",
 35595,
 "kro-bet",
}
m["kyg"] = {
 "Keyagana",
 6398208,
 "paa-kag",
}
m["kyh"] = {
 "Karok",
 1288440,
 "qfa-iso",
 "Latn",
}
m["kyi"] = {
 "Kiput",
 3038653,
 "poz-swa",
 "Latn",
}
m["kyj"] = {
 "Karao",
 3192950,
 "phi",
 "Latn",
}
m["kyk"] = {
 "Kamayo",
 3192339,
 "phi",
}
m["kyl"] = {
 "Kalapuya",
 3192120,
 "nai-klp",
}
m["kym"] = {
 "Kpatili",
 3913982,
 "znd",
}
m["kyn"] = {
 "Karolanos",
 6373093,
 "phi",
}
m["kyo"] = {
 "Kelon",
 6386414,
 "ngf",
}
m["kyp"] = {
 "Kang",
 25559558,
 "tai",
}
m["kyq"] = {
 "Kenga",
 35707,
 "csu-bgr",
}
m["kyr"] = {
 "Kuruáya",
 3200633,
 "tup",
 "Latn",
}
m["kys"] = {
 "Baram Kayan",
 2883794,
 "poz",
}
m["kyt"] = {
 "Kayagar",
 6380394,
 "ngf",
}
m["kyu"] = {
 "Western Kayah",
 12952596,
 "kar",
 "Kali, Mymr, Latn",
 translit = {Kali = "Kali-translit"},
}
m["kyv"] = {
 "Kayort",
 6380675,
 "inc-eas",
 "as-Beng",
 ancestors = "pra-mag",
}
m["kyw"] = {
 "Kudmali",
 6446173,
 "inc-eas",
 ancestors = "bh",
}
m["kyx"] = {
 "Rapoisi",
 7294279,
 "paa-nbo",
}
m["kyy"] = {
 "Kambaira",
 6356254,
 "paa-kag",
}
m["kyz"] = {
 "Kayabí",
 6380372,
 "tup-gua",
 "Latn",
}
m["kza"] = {
 "Western Karaboro",
 36601,
 "alv-krb",
}
m["kzb"] = {
 "Kaibobo",
 6347565,
 "poz-cma",
}
m["kzc"] = {
 "Bondoukou Kulango",
 11031321,
 "alv-kul",
}
m["kzd"] = {
 "Kadai",
 7679471,
 "poz-cma",
 "Latn",
}
m["kze"] = {
 "Kosena",
 12952663,
 "ngf",
 "Latn",
}
m["kzf"] = {
 "Da'a Kaili",
 33103997,
 "poz-kal",
 "Latn",
}
m["kzg"] = {
 "Kikai",
 3196527,
 "jpx-ryu",
 "Jpan",
 translit = s["Jpan-translit"],
 sort_key = s["Jpan-sortkey"],
}
m["kzh"] = {
 "Dongolawi",
 5295991,
 "nub",
 "Latn",
}
m["kzi"] = {
 "Kelabit",
 6385445,
 "poz-swa",
 "Latn",
}
m["kzj"] = {
 "Coastal Kadazan",
 3307195,
 "poz-san",
 "Latn",
}
m["kzk"] = {
 "Kazukuru",
 1089069,
 "poz-ocw",
}
m["kzl"] = {
 "Kayeli",
 4207444,
 "poz-cma",
 "Latn",
}
m["kzm"] = {
 "Kais",
 6348319,
 "paa",
 "Latn",
}
m["kzn"] = {
 "Kokola",
 11128329,
 "bnt-mak",
 "Latn",
 ancestors = "vmw",
}
m["kzo"] = {
 "Kaningi",
 35683,
 "bnt-mbt",
}
m["kzp"] = {
 "Kaidipang",
 6347611,
 "phi",
}
m["kzq"] = {
 "Kaike",
 10951226,
 "sit-tam",
}
m["kzr"] = {
 "Karang",
 35681,
 "alv-mbm",
 "Latn",
}
m["kzs"] = {
 "Sugut Dusun",
 12953510,
 "poz-san",
 "Latn",
}
m["kzt"] = {
 "Tambunan Dusun",
 12953514,
 "poz-san",
 "Latn",
}
m["kzu"] = {
 "Kayupulau",
 6380723,
 "poz-ocw",
}
m["kzv"] = {
 "Komyandaret",
 6428671,
 "ngf-okk",
 "Latn",
}
m["kzw"] = { -- contrast xoo, sai-kat, sai-xoc, the last of which the ISO conflated into this code
 "Kariri",
 12953620,
 "sai-mje",
 "Latn",
}
m["kzx"] = {
 "Kamarian",
 6356040,
 "poz-cma",
 "Latn",
}
m["kzy"] = {
 "Kango-Sua",
 11008360,
 "bnt-kbi",
 "Latn",
 ancestors = "bip",
}
m["kzz"] = {
 "Kalabra",
 6350038,
 "paa",
 "Latn",
}
m["laa"] = {
 "Lapuyan Subanun",
 12635302,
 "phi",
}
m["lab"] = {
 "Linear A",
 nil,
}
m["lac"] = {
 "Lacandon",
 35766,
 "myn",
}
m["lad"] = {
 "Ladino",
 36196,
 "roa-ibe",
 "Hebr, Latn, Cyrl",
 ancestors = "osp",
}
m["lae"] = {
 "Pattani",
 7148323,
 "sit-whm",
}
m["laf"] = {
 "Lafofa",
 35711,
 "alv",
}
m["lag"] = {
 "Langi",
 584983,
 "bnt-mra",
}
m["lah"] = {
 "Lahnda",
 1334774,
 "inc-pan",
 "pa-Arab",
 ancestors = "inc-opa",
}
m["lai"] = {
 "Lambya",
 6481626,
 "bnt-mby",
}
m["laj"] = {
 "Lango (Uganda)",
 35670,
 "sdv-los",
 "Latn",
}
m["lak"] = {
 "Laka",
 6474529, -- also Q55616620
 "csu-sar", -- formerly classified as "alv-mbm"; see [[w:Lau Laka language]]
}
m["lam"] = {
 "Lamba",
 36098,
 "bnt-sbi",
 "Latn",
}
m["lan"] = {
 "Laru",
 3913987,
 "nic-knj",
 "Latn",
}
m["lap"] = {
 "Kabba-Laka",
 6474528,
 "csu-sar",
}
m["laq"] = {
 "Qabiao",
 3436700,
 "qfa-kra",
}
m["lar"] = {
 "Larteh",
 35639,
 "alv-gng",
 "Latn",
}
m["las"] = {
 "Gur Lama",
 35652,
 "nic-gne",
 "Latn",
}
m["lau"] = {
 "Laba",
 12952694,
 "paa-nha"
}
m["law"] = {
 "Lauje",
 6498258,
 "poz",
 "Latn",
}
m["lax"] = {
 "Tiwa",
 7810466,
 "tbq-bdg",
 "Latn",
}
m["lay"] = {
 "Lama Bai",
 6480756,
 "zhx-gba",
 "Hani, Latn",
 sort_key = {Hani = "Hani-sortkey"},
}
m["laz"] = {
 "Aribwatsa",
 3502104,
 "poz-ocw",
 "Latn",
}
m["lbb"] = {
 "Label",
 3214296,
 "poz-ocw",
 "Latn",
}
m["lbc"] = {
 "Lakkia",
 3027879,
 "qfa-tak",
}
m["lbe"] = {
 "Lak",
 36206,
 "cau-nec",
 "Cyrl, Latn, Arab, Geor",
 translit = "lbe-translit",
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
 sort_key = "lbe-sortkey",
}
m["lbf"] = {
 "Tinani",
 784502,
 "sit-whm",
}
m["lbg"] = {
 "Laopang",
 12952711,
 "tbq-lol",
}
m["lbi"] = {
 "La'bi",
 6460637,
 "alv-mbm",
}
m["lbj"] = {
 "Ladakhi",
 35833,
 "sit-lab",
 "Tibt",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["lbk"] = {
 "Central Bontoc",
 nil,
 "phi",
 "Latn",
}
m["lbl"] = {
 "Libon Bikol",
 18664462,
 "phi",
}
m["lbm"] = {
 "Lodhi",
 6666374,
 "mun",
}
m["lbn"] = {
 "Lamet",
 3216723,
 "mkh-pal",
}
m["lbo"] = {
 "Laven",
 6298648,
 "mkh-ban",
 "Latn",
}
m["lbq"] = {
 "Wampar",
 7966946,
 "poz-ocw",
 "Latn",
}
m["lbr"] = {
 "Northern Lorung",
 6668040,
 "sit-kie",
}
m["lbs"] = {
 "Libyan Sign Language",
 11775688,
 "sgn",
}
m["lbt"] = {
 "Lachi",
 6583606,
 "qfa-kra",
}
m["lbu"] = {
 "Labu",
 6467660,
 "poz-ocw",
 "Latn",
}
m["lbv"] = {
 "Lavatbura-Lamusong",
 2405981,
 "poz-ocw",
 "Latn",
}
m["lbw"] = {
 "Tolaki",
 3033597,
 "poz-btk",
 "Latn",
}
m["lbx"] = {
 "Lawangan",
 3120345,
 "poz-bre",
 "Latn",
}
m["lby"] = {
 "Lamu-Lamu",
 6482727,
 nil,
 "Latn",
}
m["lbz"] = {
 "Lardil",
 3915688,
 "aus-tnk",
 "Latn",
}
m["lcc"] = {
 "Legenyem",
 12952713,
 "poz-hce",
 "Latn",
}
m["lcd"] = {
 "Lola",
 6668867,
 "poz-cet",
 "Latn",
}
m["lce"] = {
 "Loncong",
 3058192,
}
m["lcf"] = {
 "Lubu",
 3264685,
}
m["lch"] = {
 "Luchazi",
 3265143,
 "bnt-clu",
}
m["lcl"] = {
 "Lisela",
 6558753,
 "poz-cma",
 "Latn",
}
m["lcm"] = {
 "Tungag",
 3542085,
 "poz-ocw",
 "Latn",
}
m["lcp"] = {
 "Western Lawa",
 18644465,
 "mkh-pal",
 "Thai",
 sort_key = "Thai-sortkey",
}
m["lcq"] = {
 "Luhu",
 6699890,
 "poz-cma",
 "Latn",
}
m["lcs"] = {
 "Lisabata-Nuniali",
 6558534,
}
m["lda"] = {
 "Kla",
 nil,
 "dmn-mda",
 "Latn",
}
m["ldb"] = {
 "Idun",
 3914441,
 "nic-plc",
 "Latn",
}
m["ldd"] = {
 "Luri (Nigeria)",
 4701277,
 "cdc-wst",
}
m["ldg"] = {
 "Lenyima",
 3914423,
 "nic-uce",
 "Latn",
}
m["ldh"] = {
 "Lamja-Dengsa-Tola",
 11001739,
 "nic-dak",
}
m["ldj"] = {
 "Lemoro",
 3912761,
 "nic-jer",
}
m["ldk"] = {
 "Leelau",
 3914465,
 "alv-bwj",
}
m["ldl"] = {
 "Kaan",
 3914501,
 "alv-yun",
}
m["ldm"] = {
 "Landoma",
 35568,
 "alv-mel",
}
m["ldn"] = {
 "Láadan",
 35757,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["ldo"] = {
 "Loo",
 3915378,
 "alv-bwj",
}
m["ldp"] = {
 "Tso",
 3913953,
 "alv-wjk",
}
m["ldq"] = {
 "Lufu",
 35796,
 "nic-ykb",
 "Latn",
}
m["lea"] = {
 "Lega-Shabunda",
 12952719,
 "bnt-lgb",
}
m["leb"] = {
 "Lala-Bisa",
 6480112,
 "bnt-sbi",
}
m["lec"] = {
 "Leco",
 2625398,
 "qfa-iso",
}
m["led"] = {
 "Lendu",
 523823,
 "csu-lnd",
 "Latn",
}
m["lee"] = {
 "Lyélé",
 3089032,
 "nic-gnn",
}
m["lef"] = {
 "Lelemi",
 35585,
 "alv-ntg",
}
m["leh"] = {
 "Lenje",
 6522666,
 "bnt-bot",
}
m["lei"] = {
 "Lemio",
 6521165,
 "ngf-mad",
}
m["lej"] = {
 "Lengola",
 6522474,
 "bnt-leb",
}
m["lek"] = {
 "Leipon",
 3229216,
 "poz-aay",
 "Latn",
}
m["lel"] = {
 "Lele (Congo)",
 56733,
 "bnt-bsh",
}
m["lem"] = {
 "Nomaande",
 13479983,
 "nic-mbw",
 "Latn",
}
m["len"] = {
 "Honduran Lenca",
 36189,
 "nai-len",
 "Latn",
}
m["leo"] = {
 "Leti (Cameroon)",
 1345684,
 "nic-mba",
 ancestors = "bag",
}
m["lep"] = {
 "Lepcha",
 35990,
 "sit",
 "Lepc",
 translit = "lep-translit",
}
m["leq"] = {
 "Lembena",
 6521067,
 "paa-eng",
}
m["ler"] = {
 "Lenkau",
 3229472,
 "poz-aay",
 "Latn",
}
m["les"] = {
 "Lese",
 11033939,
 "csu-mle",
}
m["let"] = {
 "Lesing-Gelimi",
 12635445,
 "poz-ocw",
 "Latn",
}
m["leu"] = {
 "Kara (New Guinea)",
 3192889,
 "poz-ocw",
 "Latn",
}
m["lev"] = {
 "Lamma",
 6583582,
 "ngf",
}
m["lew"] = { -- this code was basically assigned as a catch-all for things that aren't brs, kzf or unz
 "Ledo Kaili",
 35877,
 "poz-kal",
 "Latn",
}
m["lex"] = {
 "Luang",
 6695015,
 "poz-tim",
}
m["ley"] = {
 "Lemolang",
 3033560,
}
m["lez"] = {
 "Lezgi",
 31746,
 "cau-esm",
 "Cyrl, Latn, Arab",
 translit = "lez-translit",
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
}
m["lfa"] = {
 "Lefa",
 35643,
 "bnt-baf",
}
m["lfn"] = {
 "Lingua Franca Nova",
 146803,
 "art",
 "Latn, Cyrl",
 type = "appendix-constructed",
}
m["lga"] = {
 "Lungga",
 3267590,
 "poz-ocw",
 "Latn",
}
m["lgb"] = {
 "Laghu",
 3216169,
 "poz-ocw",
 "Latn",
}
m["lgg"] = {
 "Lugbara",
 3272737,
 "csu-mma",
}
m["lgh"] = {
 "Laghuu",
 6472114,
 "tbq-lol",
}
m["lgi"] = {
 "Lengilu",
 6522465,
 "poz-swa",
 "Latn",
}
m["lgk"] = {
 "Neverver",
 3241515,
 "poz-vnc",
 "Latn",
}
m["lgl"] = {
 "Wala",
 3565284,
 "poz-sls",
}
m["lgm"] = {
 "Lega-Mwenga",
 14916883,
 "bnt-lgb",
}
m["lgn"] = {
 "Opuuo",
 3354339,
 "ssa-kom",
}
m["lgq"] = {
 "Logba",
 35813,
 "alv-ntg",
 "Latn",
}
m["lgr"] = {
 "Lengo",
 3229454,
 "poz-sls",
 "Latn",
}
m["lgs"] = {
 "Guinea-Bissau Sign Language",
 5616441,
 "sgn",
}
m["lgt"] = {
 "Pahi",
 7124545,
 "paa-spk",
 "Latn",
}
m["lgu"] = {
 "Longgu",
 3259105,
 "poz-sls",
}
m["lgz"] = {
 "Ligenza",
 5531038,
 "bnt-bun",
}
m["lha"] = {
 "Laha (Vietnam)",
 3112363,
 "qfa-kra",
}
m["lhh"] = {
 "Laha (Indonesia)",
 6473107,
 "poz-cma",
}
m["lhi"] = {
 "Lahu Shi",
 25559457,
 "tbq-lol",
}
m["lhl"] = {
 "Lahul Lohar",
 12953672,
}
m["lhn"] = {
 "Lahanan",
 12953660,
}
m["lhp"] = {
 "Lhokpu",
 3436603,
 "sit-dhi",
}
m["lhs"] = {
 "Mlahsö",
 3393063,
 "sem-cna",
}
m["lht"] = {
 "Lo-Toga",
 3257566,
 "poz-vnc",
 "Latn",
}
m["lhu"] = {
 "Lahu",
 35780,
 "tbq-lol",
}
m["lia"] = {
 "West-Central Limba",
 32867815,
 "alv-lim",
}
m["lib"] = {
 "Likum",
 3240737,
 "poz-aay",
 "Latn",
}
m["lic"] = {
 "Hlai",
 934738,
 "qfa-lic",
 "Latn",
}
m["lid"] = {
 "Nyindrou",
 3346666,
 "poz-aay",
 "Latn",
}
m["lie"] = {
 "Likila",
 11011614,
 "bnt-ngn",
}
m["lif"] = {
 "Limbu",
 56477,
 "sit-kir",
 "Limb",
 translit = "lif-translit",
}
m["lig"] = {
 "Ligbi",
 33594,
 "dmn-jje",
}
m["lih"] = {
 "Lihir",
 6546938,
 "poz-ocw",
 "Latn",
}
m["lii"] = {
 "Lingkhim",
 12635536,
}
m["lij"] = {
 "Ligurian",
 36106,
 "roa-git",
 "Latn",
}
m["lik"] = {
 "Lika",
 1530394,
 "bnt-boa",
}
m["lil"] = {
 "Lillooet",
 34154,
 "sal",
}
m["lio"] = {
 "Liki",
 4261493,
 "poz-ocw",
 "Latn",
}
m["lip"] = {
 "Sekpele",
 36257,
 "alv-ntg",
}
m["liq"] = {
 "Libido",
 35691,
 "cus-hec",
}
m["lir"] = {
 "Liberian English",
 6541128,
}
m["lis"] = {
 "Lisu",
 56480,
 "tbq-lol",
 "Lisu, Latn",
 translit = {Lisu = "Lisu-translit"},
 override_translit = true,
}
m["liu"] = {
 "Logorik",
 6667811,
 "sdv-daj",
}
m["liv"] = {
 "Livonian",
 33698,
 "urj-fin",
 "Latn",
 entry_name = {
  remove_diacritics = "'" .. u(0x2019),
  from = {"Ǭ", "ǭ"},
  to = {"Ō", "ō"}
 },
}
m["liw"] = {
 "Col",
 2981948,
}
m["lix"] = {
 "Liabuku",
 13580912,
}
m["liy"] = {
 "Banda-Bambari",
 11051591,
 "bad-cnt",
}
m["liz"] = {
 "Libinza",
 4914576,
 "bnt-zbi",
}
m["lja"] = {
 "Golpa",
 nil,
 "aus-yol",
 "Latn",
}
m["lje"] = {
 "Rampi",
 7290041,
 "poz",
}
m["lji"] = {
 "Laiyolo",
 6474218,
}
m["ljl"] = {
 "Li'o",
 2697010,
 "poz",
}
m["ljp"] = {
 "Lampung Api",
 49215,
 "poz-lgx",
 "Latn",
}
m["ljw"] = {
 "Yirandali",
 17059380,
}
m["ljx"] = {
 "Yuru",
 nil,
}
m["lka"] = {
 "Lakalei",
 12952700,
 "poz-tim",
 "Latn",
}
m["lkb"] = {
 "Kabras",
 nil,
 "bnt-msl",
 ancestors = "luy",
}
m["lkc"] = {
 "Kucong",
 6441572,
 "tbq-lol",
}
m["lkd"] = {
 "Lakondê",
 20527166,
 "sai-nmk",
 "Latn",
}
m["lke"] = {
 "Kenyi",
 12952628,
 "bnt-nyg",
}
m["lkh"] = {
 "Lakha",
 56606,
 "sit-tib",
}
m["lki"] = {
 "Laki",
 56483,
 "ku",
 "fa-Arab",
 translit = "lki-translit",
 entry_name = {remove_diacritics = c.kasra .. c.sukun},
}
m["lkj"] = {
 "Remun",
 7312239,
}
m["lkl"] = {
 "Laeko-Libuat",
 3504331,
 "qfa-tor",
}
m["lkm"] = {
 "Kalaamaya",
 6349988,
}
m["lkn"] = {
 "Lakon",
 3216494,
 "poz-vnc",
 "Latn",
}
m["lko"] = {
 "Khayo",
 6401095,
 "bnt-msl",
}
m["lkr"] = {
 "Päri",
 36487,
 "sdv-lon",
}
m["lks"] = {
 "Kisa",
 nil,
 "bnt-msl",
 ancestors = "luy",
}
m["lkt"] = {
 "Lakota",
 33537,
 "sio-dkt",
 "Latn",
}
m["lku"] = {
 "Kungkari",
 6444526,
}
m["lky"] = {
 "Lokoya",
 56687,
 "sdv-lma",
}
m["lla"] = {
 "Lala-Roba",
 3914878,
 "alv-yun",
}
m["llb"] = {
 "Lolo",
 11006056,
 "bnt-mak",
 ancestors = "vmw",
}
m["llc"] = {
 "Lele (Guinea)",
 6520837,
 "dmn-mok",
}
m["lld"] = {
 "Ladin",
 36202,
 "roa-rhe",
 "Latn",
}
m["lle"] = {
 "Lele (New Guinea)",
 3229269,
 "poz-oce",
 "Latn",
}
m["llf"] = {
 "Hermit",
 3134240,
 "poz-aay",
 "Latn",
}
m["llg"] = {
 "Lole",
 6668883,
 "poz-tim",
}
m["llh"] = {
 "Lamu",
 6482736,
 "tbq-lol",
}
m["lli"] = {
 "Teke-Laali",
 36543,
 "bnt-nze",
}
m["llj"] = {
 "Ladji-Ladji",
 6512694,
 "aus-pam",
}
m["llk"] = {
 "Lelak",
 3229263,
 "poz-swa",
 "Latn",
}
m["lll"] = {
 "Lilau",
 6547570,
 "qfa-tor",
}
m["llm"] = {
 "Lasalimu",
 6492774,
}
m["lln"] = {
 "Lele (Chad)",
 1641493,
 "cdc-est",
}
m["llo"] = {
 "Khlor",
 27921409,
 "mkh-kat",
}
m["llp"] = {
 "North Efate",
 3580152,
 "poz-vnc",
 "Latn",
}
m["llq"] = {
 "Lolak",
 12953679,
 "phi",
}
m["lls"] = {
 "Lithuanian Sign Language",
 3915480,
 "sgn",
}
m["llu"] = {
 "Lau",
 3218574,
 "poz-sls",
 "Latn",
}
m["llx"] = {
 "Lauan",
 35682,
 "poz-occ",
 "Latn",
}
m["lma"] = {
 "East Limba",
 11034212,
 "alv-lim",
}
m["lmb"] = {
 "Merei",
 12952843,
 "poz-vnc",
 "Latn",
}
m["lmc"] = {
 "Limilngan",
 6549414,
}
m["lmd"] = {
 "Lumun",
 35777,
 "alv-tal",
}
m["lme"] = {
 "Pévé",
 56249,
 "cdc-mas",
}
m["lmf"] = {
 "South Lembata",
 7567815,
}
m["lmg"] = {
 "Lamogai",
 278365,
 "poz-ocw",
 "Latn",
}
m["lmh"] = {
 "Lambichhong",
 6481472,
 "sit-kie",
 ancestors = "ybh",
}
m["lmi"] = {
 "Lombi",
 11259563,
 "csu-maa",
}
m["lmj"] = {
 "West Lembata",
 6864697,
}
m["lmk"] = {
 "Lamkang",
 12952703,
 "tbq-kuk",
}
m["lml"] = {
 "Raga",
 3063193,
 "poz-vnc",
 "Latn",
}
m["lmn"] = {
 "Lambadi",
 33474,
 "inc-wes",
 ancestors = "raj",
}
m["lmo"] = {
 "Lombard",
 33754,
 "roa-git",
 "Latn",
}
m["lmp"] = {
 "Limbum",
 35801,
 "nic-nka",
 "Latn",
}
m["lmq"] = {
 "Lamatuka",
 6480982,
}
m["lmr"] = {
 "Lamalera",
 6480787,
}
m["lmu"] = {
 "Lamenu",
 740604,
 "poz-vnc",
 "Latn",
}
m["lmv"] = {
 "Lomaiviti",
 3130221,
 "poz-occ",
 "Latn",
}
m["lmw"] = {
 "Lake Miwok",
 3216471,
 "nai-you",
 "Latn",
}
m["lmx"] = {
 "Laimbue",
 6473933,
 "nic-rnw",
}
m["lmy"] = {
 "Laboya",
 6481538,
 "poz-cet",
 "Latn",
 sort_key = "lmy-sortkey",
}
m["lmz"] = {
 "Lumbee",
 12635887,
 nil,
 "Latn",
}
m["lna"] = {
 "Langbashe",
 11137550,
 "bad",
}
m["lnb"] = {
 "Mbalanhu",
 12952830,
 "bnt-ova",
}
m["lnd"] = {
 "Lun Bawang",
 13479839,
 "poz-swa",
 "Latn",
}
m["lnh"] = {
 "Lanoh",
 6487291,
 "mkh-asl",
}
m["lni"] = {
 "Daantanai'",
 5207384,
 "paa-sbo",
}
m["lnj"] = {
 "Linngithigh",
 3915694,
 "aus-pmn",
 "Latn",
}
m["lnl"] = {
 "South Central Banda",
 41354532,
 "bad",
}
m["lnm"] = {
 "Langam",
 6485678,
 "paa",
 "Latn",
}
m["lnn"] = {
 "Lorediakarkar",
 6680287,
 "poz-vnc",
 "Latn",
}
m["lno"] = {
 "Lango (Sudan)",
 223306,
 "sdv-lma",
}
m["lns"] = {
 "Lamnso'",
 35788,
 "nic-rng",
}
m["lnu"] = {
 "Longuda",
 35797,
 "alv-bam",
 "Latn",
}
m["lnw"] = {
 "Lanima",
 nil,
 "aus-pam",
 "Latn",
}
m["loa"] = {
 "Loloda",
 6669025,
 "paa-nha",
 "Latn",
}
m["lob"] = {
 "Lobi",
 35807,
}
m["loc"] = {
 "Inonhan",
 2400870,
 "phi",
}
m["lod"] = {
 "Berawan",
 4891018,
 "poz-swa",
 "Latn",
}
m["loe"] = {
 "Saluan",
 12953867,
 "poz",
}
m["lof"] = {
 "Logol",
 35779,
 "alv-hei",
}
m["log"] = {
 "Logo",
 2613477,
 "csu-mma",
}
m["loh"] = {
 "Narim",
 56353,
 "sdv",
}
m["loi"] = {
 "Lomakka",
 3913961,
 "alv-kul",
}
m["loj"] = {
 "Lou",
 3260104,
 "poz-aay",
 "Latn",
}
m["lok"] = {
 "Loko",
 3914912,
 "dmn-msw",
 "Latn",
}
m["lol"] = {
 "Mongo",
 112893,
 "bnt-mon",
 "Latn",
}
m["lom"] = {
 "Looma",
 35885,
 "dmn-msw",
}
m["lon"] = {
 "Malawi Lomwe",
 10975286,
}
m["loo"] = {
 "Lombo",
 11167192,
 "bnt-ske",
}
m["lop"] = {
 "Lopa",
 3914875,
}
m["loq"] = {
 "Lobala",
 4849710,
 "bnt-ngn",
}
m["lor"] = {
 "Téén",
 36467,
 "alv-kul",
}
m["los"] = {
 "Loniu",
 3259202,
 "poz-aay",
 "Latn",
}
m["lot"] = {
 "Lotuko",
 56672,
 "sdv-lma",
}
m["lou"] = {
 "Louisiana Creole",
 1185127,
 "crp",
 "Latn",
 ancestors = "fr",
 sort_key = s["roa-oil-sortkey"],
}
m["lov"] = {
 "Lopi",
 12952740,
 "tbq-lol",
}
m["low"] = {
 "Tampias Lobu",
 12953674,
}
m["lox"] = {
 "Loun",
 6689636,
 "poz-cet",
 "Latn",
}
m["loz"] = {
 "Lozi",
 33628,
 "bnt-sts",
 "Latn",
}
m["lpa"] = {
 "Lelepa",
 3229273,
 "poz-vnc",
}
m["lpe"] = {
 "Lepki",
 4259152,
 "paa-pau",
}
m["lpn"] = {
 "Long Phuri Naga",
 6673049,
 "sit-aao",
}
m["lpo"] = {
 "Lipo",
 56921,
 "tbq-lol",
 "Plrd",
}
m["lpx"] = {
 "Lopit",
 56684,
 "sdv-lma",
}
m["lra"] = {
 "Rara Bakati'",
 3419746,
 "day",
}
m["lrc"] = {
 "Northern Luri",
 19933293,
 "ira-swi",
 "fa-Arab",
 ancestors = "pal",
}
m["lre"] = {
 "Laurentian",
 1790301,
 "iro-nor",
 "Latn",
}
m["lrg"] = {
 "Laragia",
 2591193,
}
m["lri"] = {
 "Marachi",
 6754565,
 "bnt-msl",
}
m["lrk"] = {
 "Loarki",
 6663513,
}
m["lrl"] = {
 "Larestani",
 33468,
 "ira-swi",
 "fa-Arab",
}
m["lrm"] = {
 "Marama",
 nil,
 "bnt-msl",
 ancestors = "luy",
}
m["lrn"] = {
 "Lorang",
 6678781,
}
m["lro"] = {
 "Laro",
 35687,
 "alv-hei",
}
m["lrr"] = {
 "Southern Lorung",
 12952742,
 "sit-kie",
}
m["lrt"] = {
 "Larantuka Malay",
 6488691,
 "poz-mly",
 "Latn",
}
m["lrv"] = {
 "Larevat",
 3217892,
 "poz-vnc",
 "Latn",
}
m["lrz"] = {
 "Lemerig",
 2028448,
 "poz-vnc",
}
m["lsa"] = {
 "Lasgerdi",
 3218296,
 "ira-kms",
}
m["lsd"] = {
 "Lishana Deni",
 3436461,
 "sem-nna",
 "Hebr",
}
m["lse"] = {
 "Lusengo",
 6683546,
 "bnt-zbi",
}
m["lsh"] = {
 "Lish",
 6558822,
 "sit-khb",
}
m["lsi"] = {
 "Lashi",
 6493203,
 "tbq-brm",
}
m["lsl"] = {
 "Latvian Sign Language",
 6497414,
 "sgn",
}
m["lsm"] = {
 "Saamia",
 3739441,
 "bnt-msl",
}
m["lso"] = {
 "Laos Sign Language",
 6488022,
 "sgn",
}
m["lsp"] = {
 "Panamanian Sign Language",
 7129968,
 "sgn",
}
m["lsr"] = {
 "Aruop",
 3450566,
 "qfa-tor",
}
m["lss"] = {
 "Lasi",
 12953669,
 "inc-snd",
 "Arab",
 ancestors = "sd",
}
m["lst"] = {
 "Trinidad and Tobago Sign Language",
 7842495,
 "sgn",
}
m["lsy"] = {
 "Mauritian Sign Language",
 6793754,
 "sgn",
}
m["ltc"] = {
 "Middle Chinese",
 2016252,
 "zhx",
 "Hant, Phag, Tang",
 ancestors = "och",
 translit = {Hant = "zh-translit"},
 sort_key = {Hant = "Hani-sortkey"},
}
m["ltg"] = {
 "Latgalian",
 36212,
 "bat",
 "Latn",
}
m["lti"] = {
 "Leti (Indonesia)",
 3236912,
 "poz-tim",
 "Latn",
}
m["ltn"] = {
 "Latundê",
 nil,
 "sai-nmk",
 "Latn",
}
m["lto"] = {
 "Olutsotso",
 nil,
 "bnt-msl",
 ancestors = "luy",
}
m["lts"] = {
 "Lutachoni",
 nil,
 "bnt-msl",
}
m["ltu"] = {
 "Latu",
 6497181,
 "poz-cma",
}
m["lua"] = {
 "Luba-Kasai",
 34173,
 "bnt-lub",
 "Latn",
}
m["luc"] = {
 "Aringa",
 56556,
 "csu-mma",
}
m["lud"] = {
 "Ludian",
 33918,
 "urj-fin",
 "Latn",
}
m["lue"] = {
 "Luvale",
 33597,
 "bnt-clu",
 "Latn",
}
m["luf"] = {
 "Laua",
 6497673,
}
m["lui"] = {
 "Luiseño",
 56236,
 "azc-cup",
 "Latn",
 entry_name = {remove_diacritics = c.acute .. c.circ},
}
m["luj"] = {
 "Luna",
 11003832,
 "bnt-lbn",
}
m["luk"] = {
 "Lunanakha",
 56446,
 "sit-tib",
 "Tibt",
 ancestors = "dz",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["lul"] = {
 "Olu'bo",
 6589401,
 "csu-mma",
}
m["lum"] = {
 "Luimbi",
 10963134,
 "bnt-clu",
}
m["lun"] = {
 "Lunda",
 33607,
 "bnt-lun",
 "Latn",
}
m["luo"] = {
 "Luo",
 5414796,
 "sdv-los",
 "Latn",
}
m["lup"] = {
 "Lumbu",
 35793,
 "bnt-sir",
}
m["luq"] = {
 "Lucumí",
 1768321,
 "alv-yor",
 "Latn",
 ancestors = "yo",
 sort_key = {
  remove_diacritics = c.acute,
 },
}
m["lur"] = {
 "Laura",
 2984540,
}
m["lus"] = {
 "Mizo",
 36147,
 "tbq-kuk",
 "Latn",
}
m["lut"] = {
 "Lushootseed",
 33658,
 "sal",
 "Latn",
}
m["luu"] = {
 "Lumba-Yakkha",
 6703050,
 "sit-kie",
 ancestors = "ybh",
}
m["luv"] = {
 "Luwati",
 33402,
 "inc-snd",
 "Khoj",
 ancestors = "inc-vra",
}
m["luy"] = {
 "Luhya",
 35893,
 "bnt-msl",
 "Latn",
}
m["luz"] = {
 "Southern Luri",
 12952748,
 "ira-swi",
 "fa-Arab",
 ancestors = "pal",
}
m["lva"] = {
 "Maku'a",
 35790,
 "poz-tim",
}
m["lvi"] = {
 "Lawi",
 6502657,
 "mkh-ban",
 "Latn",
}
m["lvk"] = {
 "Lavukaleve",
 770547,
 "paa",
 "Latn",
}
m["lvu"] = {
 "Levuka",
 6535860,
}
m["lwa"] = {
 "Lwalu",
 6706953,
 "bnt-lbn",
}
m["lwe"] = {
 "Lewo Eleng",
 6537465,
}
m["lwg"] = {
 "Wanga",
 nil,
 "bnt-msl",
 ancestors = "luy",
}
m["lwh"] = {
 "White Lachi",
 8842956,
 "qfa-kra",
}
m["lwl"] = {
 "Eastern Lawa",
 18644464,
 "mkh-pal",
 "Thai",
 sort_key = "Thai-sortkey",
}
m["lwm"] = {
 "Laomian",
 19597674,
 "tbq-lol",
}
m["lwo"] = {
 "Luwo",
 56362,
 "sdv-lon",
 "Latn",
}
m["lws"] = {
 "Malawian Sign Language",
 47522462,
 "sgn",
}
m["lwt"] = {
 "Lewotobi",
 14916885,
}
m["lwu"] = {
 "Lawu",
 6505073,
}
m["lww"] = {
 "Lewo",
 3237321,
 "poz-vnc",
 "Latn",
}
m["lya"] = {
 "Layakha",
 56602,
 "sit-tib",
 "Tibt",
 ancestors = "dz",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["lyg"] = {
 "Lyngngam",
 12635902,
 "aav-pkl",
}
m["lyn"] = {
 "Luyana",
 3268098,
}
m["lzh"] = {
 "Literary Chinese",
 37041,
 "zhx",
 "Hant",
 wikimedia_codes = "zh-classical",
 sort_key = "Hani-sortkey",
}
m["lzl"] = {
 "Litzlitz",
 6653424,
 "poz-vnc",
 "Latn",
}
m["lzn"] = {
 "Leinong Naga",
 5924455,
 "sit-kch",
}
m["lzz"] = {
 "Laz",
 1160372,
 "ccs-zan",
 "Geor, Latn",
 translit = {Geor = "lzz-translit"},
 override_translit = true,
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ},
}
m["maa"] = {
 "San Jerónimo Tecóatl Mazatec",
 7692927,
 "omq-maz",
 "Latn",
}
m["mab"] = {
 "Yutanduchi Mixtec",
 12645448,
 "omq-mxt",
 "Latn",
}
m["mad"] = {
 "Madurese",
 36213,
 "poz-msa",
 "Latn",
}
m["mae"] = {
 "Bo-Rukul",
 34967,
 "nic-ple",
 "Latn",
}
m["maf"] = {
 "Mafa",
 35819,
 "cdc-cbm",
 "Latn",
}
m["mag"] = {
 "Magahi",
 33728,
 "inc-eas",
 "Deva, Kthi",
 ancestors = "bh",
}
m["mai"] = {
 "Maithili",
 36109,
 "inc-eas",
 "Deva, Tirh, Kthi, Newa",
 ancestors = "bh",
 translit = {
  Deva = "mai-translit",
  Tirh = "mai-Tirh-translit",
  Kthi = "bho-Kthi-translit",
 },
}
m["maj"] = {
 "Jalapa de Díaz Mazatec",
 3915999,
 "omq-maz",
 "Latn",
}
m["mak"] = {
 "Makasar",
 33643,
 "poz-ssw",
 "Latn, Maka",
}
m["mam"] = {
 "Mam",
 33467,
 "myn",
 "Latn",
}
m["man"] = {
 "Mandingo",
 35772,
 "dmn-man",
 "Latn",
}
m["maq"] = {
 "Chiquihuitlán Mazatec",
 5101757,
 "omq-maz",
 "Latn",
}
m["mas"] = {
 "Maasai",
 35787,
 "sdv-lma",
 "Latn",
}
m["mat"] = {
 "Matlatzinca",
 12953704,
 "omq",
 "Latn",
}
m["mau"] = {
 "Huautla Mazatec",
 36230,
 "omq-maz",
 "Latn",
}
m["mav"] = {
 "Sateré-Mawé",
 6794475,
 "tup",
 "Latn",
}
m["maw"] = {
 "Mampruli",
 35804,
 "nic-wov",
 "Latn",
}
m["max"] = {
 "North Moluccan Malay",
 7056136,
 "crp",
 "Latn",
}
m["maz"] = {
 "Central Mazahua",
 36228,
 "oto",
 "Latn",
}
m["mba"] = {
 "Higaonon",
 5753411,
 "mno",
 "Latn",
}
m["mbb"] = {
 "Western Bukidnon Manobo",
 7987643,
 "mno",
 "Latn",
}
m["mbc"] = {
 "Macushi",
 56633,
 "sai-pem",
 "Latn",
}
m["mbd"] = {
 "Dibabawon Manobo",
 18755523,
 "mno",
 "Latn",
}
m["mbe"] = {
 "Molale",
 3319444,
 "nai-plp",
 "Latn",
}
m["mbf"] = {
 "Baba Malay",
 18642798,
 "crp",
 "Latn",
 ancestors = "ms",
}
m["mbh"] = {
 "Mangseng",
 6749147,
 "poz-ocw",
 "Latn",
}
m["mbi"] = {
 "Ilianen Manobo",
 14916911,
 "mno",
 "Latn",
}
m["mbj"] = {
 "Nadëb",
 3335011,
 "sai-nad",
 "Latn",
}
m["mbk"] = {
 "Malol",
 6744477,
 "poz-ocw",
 "Latn",
}
m["mbl"] = {
 "Maxakalí",
 3029682,
 "sai-mje",
 "Latn",
}
m["mbm"] = {
 "Ombamba",
 36407,
 "bnt-mbt",
 "Latn",
}
m["mbn"] = {
 "Macaguán",
 3273980,
 "sai-guh",
 "Latn",
}
m["mbo"] = { -- is, like 'bqz', 'bsi' and 'bss', a dialect of Manenguba
 "Mbo (Cameroon)",
 nil,
 "bnt-mne",
 "Latn",
}
m["mbp"] = {
 "Wiwa",
 3012604,
 "cba",
 "Latn",
}
m["mbq"] = {
 "Maisin",
 3448149,
 nil,
 "Latn",
}
m["mbr"] = {
 "Nukak Makú",
 3346228,
 "sai-nad",
 "Latn",
}
m["mbs"] = {
 "Sarangani Manobo",
 7423093,
 "mno",
 "Latn",
}
m["mbt"] = {
 "Matigsalug Manobo",
 6787447,
 "mno",
 "Latn",
}
m["mbu"] = {
 "Mbula-Bwazza",
 3913324,
 "nic-jrn",
 "Latn",
}
m["mbv"] = {
 "Mbulungish",
 36003,
 "alv-nal",
 "Latn",
}
m["mbw"] = {
 "Maring",
 3293280,
 nil,
 "Latn",
}
m["mbx"] = {
 "Sepik Mari",
 6760942,
 "paa-spk",
 "Latn",
}
m["mby"] = {
 "Memoni",
 4180871,
 "inc-snd",
 "Gujr, ur-Arab",
 ancestors = "inc-vra",
}
m["mbz"] = {
 "Amoltepec Mixtec",
 13583504,
 "omq-mxt",
 "Latn",
}
m["mca"] = {
 "Maca",
 3281043,
 "sai-mtc",
 "Latn",
}
m["mcb"] = {
 "Machiguenga",
 3915441,
 "awd",
 "Latn",
}
m["mcc"] = {
 "Bitur",
 4919173,
}
m["mcd"] = {
 "Sharanahua",
 12953881,
 "sai-pan",
 "Latn",
}
m["mce"] = {
 "Itundujia Mixtec",
 12953727,
 "omq-mxt",
 "Latn",
}
m["mcf"] = {
 "Matsés",
 2981620,
 "sai-pan",
 "Latn",
}
m["mcg"] = {
 "Mapoyo",
 56946,
 "sai-map",
 "Latn",
}
m["mch"] = {
 "Maquiritari",
 3082027,
 "sai-car",
 "Latn",
}
m["mci"] = {
 "Mese",
 6821190,
}
m["mcj"] = {
 "Mvanip",
 3913281,
 "nic-mmb",
 "Latn",
}
m["mck"] = {
 "Mbunda",
 34170,
 "bnt-clu",
 "Latn",
}
m["mcl"] = {
 "Macaguaje",
 6722435,
 "sai-tuc",
 "Latn",
}
m["mcm"] = {
 "Kristang",
 2669169,
 "crp",
 "Latn",
 ancestors = "pt",
}
m["mcn"] = {
 "Masana",
 56668,
 "cdc-mas",
}
m["mco"] = {
 "Coatlán Mixe",
 25559716,
 "nai-miz",
 "Latn",
}
m["mcp"] = {
 "Makaa",
 35803,
 "bnt-mka",
}
m["mcq"] = {
 "Ese",
 5397551,
 "ngf",
 "Latn",
}
m["mcr"] = {
 "Menya",
 11732444,
 "ngf",
}
m["mcs"] = {
 "Mambai",
 6748872,
 "alv-mbm",
}
m["mcu"] = {
 "Cameroon Mambila",
 19359039,
 "nic-mmb",
 "Latn",
}
m["mcv"] = {
 "Minanibai",
 6863167,
 "ngf",
}
m["mcw"] = {
 "Mawa",
 3441333,
 "cdc-est",
 "Latn",
}
m["mcx"] = {
 "Mpiemo",
 35908,
 "bnt-bek",
}
m["mcy"] = {
 "South Watut",
 12953293,
 "poz-ocw",
}
m["mcz"] = {
 "Mawan",
 11732429,
 "ngf-mad",
}
m["mda"] = {
 "Mada (Nigeria)",
 3915843,
 "nic-nin",
 "Latn",
}
m["mdb"] = {
 "Morigi",
 6912195,
 "paa-kiw",
}
m["mdc"] = {
 "Male",
 6742927,
 "ngf-mad",
}
m["mdd"] = {
 "Mbum",
 36170,
 "alv-mbm",
}
m["mde"] = {
 "Bura Mabang",
 35860,
 "ssa",
}
m["mdf"] = {
 "Moksha",
 13343,
 "urj-mdv",
 "Cyrl",
 translit = "mdf-translit",
 override_translit = true,
 sort_key = "mdf-sortkey",
}
m["mdg"] = {
 "Massalat",
 759984,
}
m["mdh"] = {
 "Maguindanao",
 33717,
 "phi",
 "Latn, Arab",
}
m["mdi"] = {
 "Mamvu",
 3033594,
 "csu-mle",
}
m["mdj"] = {
 "Mangbetu",
 56327,
 "csu-maa",
}
m["mdk"] = {
 "Mangbutu",
 6748877,
 "csu-mle",
}
m["mdl"] = {
 "Maltese Sign Language",
 6744816,
 "sgn",
}
m["mdm"] = {
 "Mayogo",
 6797580,
 "nic-nke",
 "Latn",
}
m["mdn"] = {
 "Mbati",
 36165,
 "bnt-ngn",
}
m["mdp"] = {
 "Mbala",
 6799583,
 "bnt-pen",
}
m["mdq"] = {
 "Mbole",
 6799727,
 "bnt-mbe",
}
m["mdr"] = {
 "Mandar",
 35995,
 "poz-ssw",
 "Bugi, Latn",
}
m["mds"] = {
 "Maria",
 3448673,
}
m["mdt"] = {
 "Mbere",
 36062,
 "bnt-mbt",
}
m["mdu"] = {
 "Mboko",
 36058,
 "bnt-mbo",
}
m["mdv"] = {
 "Santa Lucía Monteverde Mixtec",
 12953722,
 "omq-mxt",
 "Latn",
}
m["mdw"] = {
 "Mbosi",
 36035,
 "bnt-mbo",
}
m["mdx"] = {
 "Dizin",
 35313,
 "omv-diz",
}
m["mdy"] = {
 "Maale",
 795327,
 "omv-ome",
}
m["mdz"] = {
 "Suruí Do Pará",
 10322149,
 "tup-gua",
 "Latn",
}
m["mea"] = {
 "Menka",
 36078,
 "nic-grs",
 "Latn",
}
m["meb"] = {
 "Ikobi-Mena",
 11732241,
 "ngf",
 "Latn",
}
m["mec"] = {
 "Mara",
 6772774,
}
m["med"] = {
 "Melpa",
 36166,
}
m["mee"] = {
 "Mengen",
 3305831,
 "poz-ocw",
}
m["mef"] = {
 "Megam",
 6808589,
}
m["meg"] = {
 "Mea",
 12952836,
 "poz-cln",
}
m["meh"] = {
 "Southwestern Tlaxiaco Mixtec",
 7070686,
 "omq-mxt",
 "Latn",
}
m["mei"] = {
 "Midob",
 36007,
 "nub",
 "Latn",
}
m["mej"] = {
 "Meyah",
 11732436,
 "paa-wpa",
}
m["mek"] = {
 "Mekeo",
 3304803,
 "poz-ocw",
}
m["mel"] = {
 "Central Melanau",
 18638319,
 "poz-swa",
 "Latn",
}
m["mem"] = {
 "Mangala",
 6748664,
}
m["men"] = {
 "Mende",
 1478672,
 "dmn-msw",
 "Latn, Mend",
}
m["meo"] = {
 "Kedah Malay",
 4925684,
 "poz-mly",
 "Latn, ms-Arab, Thai",
 entry_name = {
  from = {u(0xF70F)},
  to = {"ญ"}
 },
 sort_key = {Thai = "Thai-sortkey"},
}
m["mep"] = {
 "Miriwung",
 3111847,
}
m["meq"] = {
 "Merey",
 3502314,
 "cdc-cbm",
 "Latn",
}
m["mer"] = {
 "Meru",
 13313,
 "bnt-kka",
 "Latn",
}
m["mes"] = {
 "Masmaje",
 3440448,
}
m["met"] = {
 "Mato",
 3299190,
 "poz-ocw",
 "Latn",
}
m["meu"] = {
 "Motu",
 33516,
 "poz-ocw",
 "Latn",
}
m["mev"] = {
 "Mano",
 3913286,
 "dmn-mda",
 "Latn",
}
m["mew"] = {
 "Maaka",
 3438764,
 "cdc-wst",
 "Latn",
}
m["mey"] = {
 "Hassaniya",
 56231,
 "sem-arb",
 "Arab",
}
m["mez"] = {
 "Menominee",
 13363,
 "alg",
 "Latn",
 sort_key = {remove_diacritics = "·"},
}
m["mfa"] = {
 "Pattani Malay",
 1199751,
 "poz-mly",
 "Latn, ms-Arab, Thai",
 entry_name = {
  from = {u(0xF70F)},
  to = {"ญ"}
 },
 sort_key = {Thai = "Thai-sortkey"},
}
m["mfb"] = {
 "Bangka",
 3258818,
}
m["mfc"] = {
 "Mba",
 4286464,
 "nic-mbc",
 "Latn",
}
m["mfd"] = {
 "Mendankwe-Nkwen",
 11129537,
 "nic-nge",
 "Latn",
}
m["mfe"] = {
 "Mauritian Creole",
 33661,
 "crp",
 "Latn",
 ancestors = "fr",
 sort_key = s["roa-oil-sortkey"],
}
m["mff"] = {
 "Naki",
 36083,
 "nic-bbe",
 "Latn",
}
m["mfg"] = {
 "Mixifore",
 3914478,
 "dmn-mok",
}
m["mfh"] = {
 "Matal",
 3501751,
 "cdc-cbm",
 "Latn",
}
m["mfi"] = {
 "Wandala",
 3441249,
 "cdc-cbm",
 "Latn",
}
m["mfj"] = {
 "Mefele",
 3501871,
 "cdc-cbm",
}
m["mfk"] = {
 "North Mofu",
 56303,
 "cdc-cbm",
}
m["mfl"] = {
 "Putai",
 56291,
}
m["mfm"] = {
 "Marghi South",
 56248,
}
m["mfn"] = {
 "Cross River Mbembe",
 3915395,
 "nic-uce",
 "Latn",
}
m["mfo"] = {
 "Mbe",
 36075,
 "nic-eko",
 "Latn",
}
m["mfp"] = {
 "Makassar Malay",
 12952776,
 "qfa-mix",
 "Latn",
}
m["mfq"] = {
 "Moba",
 19921578,
 "nic-grm",
 "Latn",
}
m["mfr"] = {
 "Marrithiyel",
 6773014,
 "aus-dal",
 "Latn",
}
m["mfs"] = {
 "Mexican Sign Language",
 3915511,
 "sgn",
 "Latn", -- when documented
}
m["mft"] = {
 "Mokerang",
 3319387,
 "poz-aay",
 "Latn",
}
m["mfu"] = {
 "Mbwela",
 11004988,
 "bnt-clu",
 ancestors = "lch",
}
m["mfv"] = {
 "Mandjak",
 35822,
 "alv-pap",
}
m["mfw"] = {
 "Mulaha",
 6933720,
}
m["mfx"] = {
 "Melo",
 6813268,
 "omv-nom",
}
m["mfy"] = {
 "Mayo",
 56729,
 "azc-trc",
 "Latn",
 sort_key = {remove_diacritics = c.acute},
}
m["mfz"] = {
 "Mabaan",
 20526385,
 "sdv",
}
m["mga"] = {
 "Middle Irish",
 36116,
 "cel-gae",
 "Latn",
 ancestors = "sga",
 entry_name = {remove_diacritics = c.dotabove .. c.diaer .. "·"},
 sort_key = "mga-sortkey",
}
m["mgb"] = {
 "Mararit",
 56359,
 "sdv-tmn",
}
m["mgc"] = {
 "Morokodo",
 6913216,
 "csu-bbk",
 "Latn",
}
m["mgd"] = {
 "Moru",
 6915014,
 "csu-mma",
}
m["mge"] = {
 "Mango",
 713659,
 "csu-sar",
}
m["mgf"] = {
 "Maklew",
 6739816,
}
m["mgg"] = {
 "Mpongmpong",
 35924,
 "bnt-bek",
}
m["mgh"] = {
 "Makhuwa-Meetto",
 33604,
 "bnt-mak",
 "Latn",
 ancestors = "vmw",
}
m["mgi"] = {
 "Jili",
 3914497,
 "nic-pls",
}
m["mgj"] = {
 "Abureni",
 3441256,
 "nic-cde",
 "Latn",
}
m["mgk"] = {
 "Mawes",
 6794395,
 "paa",
}
m["mgl"] = {
 "Maleu-Kilenge",
 3281884,
}
m["mgm"] = {
 "Mambae",
 35774,
 "poz-tim",
 "Latn",
}
m["mgn"] = {
 "Mbangi",
 11017443,
 "nic-ngd",
 "Latn",
}
m["mgo"] = {
 "Meta'",
 36054,
 "nic-mom",
 "Latn",
}
m["mgp"] = {
 "Eastern Magar",
 12952758,
 "sit-gma",
}
m["mgq"] = {
 "Malila",
 6743679,
 "bnt-mby",
 "Latn",
}
m["mgr"] = {
 "Mambwe-Lungu",
 626210,
 "bnt-mwi",
 "Latn",
}
m["mgs"] = {
 "Manda (Tanzania)",
 16939267,
 "bnt-bki",
}
m["mgt"] = {
 "Mongol",
 11260674,
 "paa",
 "Latn",
}
m["mgu"] = {
 "Mailu",
 3278246,
 "ngf",
}
m["mgv"] = {
 "Matengo",
 6786446,
 "bnt-mbi",
 "Latn",
}
m["mgw"] = {
 "Matumbi",
 6791974,
 "bnt-mbi",
 "Latn",
}
m["mgy"] = {
 "Mbunga",
 6799817,
 "bnt-kil",
}
m["mgz"] = {
 "Mbugwe",
 3426367,
 "bnt-mra",
}
m["mha"] = {
 "Manda (India)",
 56760,
 "dra",
 "Orya",
 ancestors = "dra-pro",
 translit = "kxv-translit",
}
m["mhb"] = {
 "Mahongwe",
 35816,
 "bnt-kel",
}
m["mhc"] = {
 "Mocho",
 1941682,
 "myn",
}
m["mhd"] = {
 "Mbugu",
 36152,
 "qfa-mix",
 "Latn",
 ancestors = "asa",
}
m["mhe"] = {
 "Besisi",
 2742262,
 "mkh-asl",
}
m["mhf"] = {
 "Mamaa",
 6745346,
 "ngf-fin",
 "Latn",
}
m["mhg"] = {
 "Margu",
 6772812,
}
m["mhi"] = {
 "Ma'di",
 56670,
 "csu-mma",
}
m["mhj"] = {
 "Mogholi",
 13336,
 "xgn",
}
m["mhk"] = {
 "Mungaka",
 36068,
 "nic-nun",
 "Latn",
}
m["mhl"] = {
 "Mauwake",
 6794095,
 "ngf-mad",
}
m["mhm"] = {
 "Makhuwa-Moniga",
 6900145,
 "bnt-mak",
}
m["mhn"] = {
 "Mòcheno",
 268130,
 "gmw",
 "Latn",
 ancestors = "bar",
 sort_key = {remove_diacritics = c.grave},
}
m["mho"] = {
 "Mashi",
 10962737,
 "bnt-kav",
 "Latn",
}
m["mhp"] = {
 "Balinese Malay",
 12473441,
 "crp",
}
m["mhq"] = {
 "Mandan",
 1957120,
 "sio",
}
m["mhr"] = {
 "Eastern Mari",
 3906614,
 "chm",
 "Cyrl",
 translit = "chm-translit",
 override_translit = true,
 entry_name = {remove_diacritics = c.grave .. c.acute},
 sort_key = {
  from = {"ё", "ҥ", "ӧ", "ӱ"},
  to = {"е" .. p[1], "н" .. p[1], "о" .. p[1], "у" .. p[1]}
 }
}
m["mhs"] = {
 "Buru (Indonesia)",
 2928650,
 "poz-cma",
}
m["mht"] = {
 "Mandahuaca",
 6747924,
 "awd-nwk",
}
m["mhu"] = {
 "Taraon",
 56400,
 "sit-gsi",
 "Latn",
}
m["mhw"] = {
 "Mbukushu",
 2691548,
}
m["mhx"] = {
 "Lhao Vo",
 11149315,
 "tbq-brm",
}
m["mhy"] = {
 "Ma'anyan",
 2328761,
 "poz-bre",
}
m["mhz"] = {
 "Mor (Austronesian)",
 2122792,
 "poz-hce",
 "Latn",
}
m["mia"] = {
 "Miami",
 56523,
 "alg",
 "Latn",
}
m["mib"] = {
 "Atatláhuca Mixtec",
 32093046,
 "omq-mxt",
 "Latn",
}
m["mic"] = {
 "Mi'kmaq",
 13321,
 "alg-eas",
 "Latn",
}
m["mid"] = {
 "Mandaic",
 6991742,
 "sem-ase",
 "Mand",
 ancestors = "myz",
}
m["mie"] = {
 "Ocotepec Mixtec",
 25559575,
 "omq-mxt",
 "Latn",
}
m["mif"] = {
 "Mofu-Gudur",
 1365132,
 "cdc-cbm",
 "Latn",
}
m["mig"] = {
 "San Miguel el Grande Mixtec",
 12953719,
 "omq-mxt",
 "Latn",
}
m["mih"] = {
 "Chayuco Mixtec",
 13583510,
 "omq-mxt",
 "Latn",
}
m["mii"] = {
 "Chigmecatitlán Mixtec",
 12953724,
 "omq-mxt",
 "Latn",
}
m["mij"] = {
 "Mungbam",
 34725,
 "nic-beb",
 "Latn",
}
m["mik"] = {
 "Mikasuki",
 13316,
 "nai-mus",
 "Latn",
}
m["mil"] = {
 "Peñoles Mixtec",
 42411307,
 "omq-mxt",
 "Latn",
}
m["mim"] = {
 "Alacatlatzala Mixtec",
 14697894,
 "omq-mxt",
 "Latn",
}
m["min"] = {
 "Minangkabau",
 13324,
 "poz-mly",
 "Latn, Arab",
}
m["mio"] = {
 "Pinotepa Nacional Mixtec",
 7196415,
 "omq-mxt",
 "Latn",
}
m["mip"] = {
 "Apasco-Apoala Mixtec",
 13583505,
 "omq-mxt",
 "Latn",
}
m["miq"] = {
 "Miskito",
 1516803,
 "nai-min",
 "Latn",
 entry_name = {remove_diacritics = c.circ},
}
m["mir"] = {
 "Isthmus Mixe",
 6088873,
 "nai-miz",
}
m["mit"] = {
 "Southern Puebla Mixtec",
 7570345,
 "omq-mxt",
 "Latn",
}
m["miu"] = {
 "Cacaloxtepec Mixtec",
 12953723,
 "omq-mxt",
 "Latn",
}
m["miw"] = {
 "Akoye",
 3327462,
 "ngf",
 "Latn",
}
m["mix"] = {
 "Mixtepec Mixtec",
 6884125,
 "omq-mxt",
 "Latn",
}
m["miy"] = {
 "Ayutla Mixtec",
 13583508,
 "omq-mxt",
 "Latn",
}
m["miz"] = {
 "Coatzospan Mixtec",
 3317290,
 "omq-mxt",
 "Latn",
}
m["mjb"] = {
 "Makalero",
 35729,
 "ngf",
 "Latn",
}
m["mjc"] = {
 "San Juan Colorado Mixtec",
 12953718,
 "omq-mxt",
 "Latn",
}
m["mjd"] = {
 "Northwest Maidu",
 3198700,
 "nai-mdu",
 "Latn",
}
m["mje"] = {
 "Muskum",
 3913334,
}
-- mjg "Monguor" is not recognized as a language, but it is a family code
m["mji"] = {
 "Kim Mun",
 1115317,
 "hmx-mie",
}
m["mjj"] = {
 "Mawak",
 11732427,
 "ngf-mad",
}
m["mjk"] = {
 "Matukar",
 6791963,
 "poz-ocw",
 "Latn",
}
m["mjl"] = {
 "Mandeali",
 6747931,
 "him",
 "Deva, Takr",
 translit = "hi-translit",
}
m["mjm"] = {
 "Medebur",
 6805227,
 "poz-ocw",
 "Latn",
}
m["mjn"] = {
 "Mebu",
 6804364,
 "ngf-fin",
}
m["mjo"] = {
 "Malankuravan",
 14916887,
 "dra",
}
m["mjp"] = {
 "Malapandaram",
 10575729,
 "dra",
}
m["mjq"] = {
 "Malaryan",
 12952773,
 "dra",
}
m["mjr"] = {
 "Malavedan",
 12952775,
 "dra",
 "Mlym",
 translit = "ml-translit",
}
m["mjs"] = {
 "Miship",
 3441264,
 "cdc-wst",
 "Latn",
}
m["mjt"] = {
 "Sawriya Paharia",
 33907,
 "dra",
 "Beng, Deva",
}
m["mju"] = {
 "Manna-Dora",
 10576453,
 "dra",
 ancestors = "te",
}
m["mjv"] = {
 "Mannan",
 3286037,
 "dra",
 "Mlym, Taml",
 translit = {
  Mlym = "ml-translit",
  Taml = "ta-translit",
 },
}
m["mjw"] = {
 "Karbi",
 56591,
 "tbq-kuk",
 "Latn",
}
m["mjx"] = {
 "Mahali",
 12953686,
 "mun",
}
m["mjy"] = {
 "Mahican",
 3182562,
 "alg-eas",
 "Latn",
}
m["mjz"] = {
 "Majhi",
 6737786,
 "inc-eas",
 ancestors = "bh",
}
m["mka"] = {
 "Mbre",
 3450154,
 "nic", --unclassified within niger-congo tho
}
m["mkb"] = {
 "Mal Paharia",
 6583595,
}
m["mkc"] = {
 "Siliput",
 7515090,
 "qfa-tor",
 "Latn",
}
m["mke"] = {
 "Mawchi",
 21403317,
}
m["mkf"] = {
 "Miya",
 43328,
 "cdc-wst",
 "Latn",
}
m["mkg"] = {
 "Mak (China)",
 3280623,
 "qfa-kms",
}
m["mki"] = {
 "Dhatki",
 32480,
 "inc-wes",
 ancestors = "mwr",
}
m["mkj"] = {
 "Mokilese",
 2335528,
 "poz-mic",
 "Latn",
}
m["mkk"] = {
 "Byep",
 35052,
 "bnt-mka",
}
m["mkl"] = {
 "Mokole",
 36047,
}
m["mkm"] = {
 "Moklen",
 3319380,
}
m["mkn"] = {
 "Kupang Malay",
 18458203,
 "crp",
}
m["mko"] = {
 "Mingang Doso",
 3915382,
 "alv-bwj",
}
m["mkp"] = {
 "Moikodi",
 6894594,
 "ngf",
}
m["mkq"] = {
 "Bay Miwok",
 3460957,
 "nai-you",
 "Latn",
}
m["mkr"] = {
 "Malas",
 11732402,
 "ngf-mad",
}
m["mks"] = {
 "Silacayoapan Mixtec",
 7514027,
 "omq-mxt",
 "Latn",
}
m["mkt"] = {
 "Vamale",
 14916907,
 "poz-cln",
 "Latn",
}
m["mku"] = {
 "Konyanka Maninka",
 11163298,
 "dmn-mnk",
}
m["mkv"] = {
 "Mafea",
 3073532,
 "poz-vnc",
 "Latn",
}
m["mkx"] = {
 "Cinamiguin Manobo",
 12953697,
 "mno",
}
m["mky"] = {
 "East Makian",
 3512690,
 "poz-hce",
 "Latn",
}
m["mkz"] = {
 "Makasae",
 35782,
 "ngf",
}
m["mla"] = {
 "Tamambo",
 1153276,
 "poz-vnc",
 "Latn",
}
m["mlb"] = {
 "Mbule",
 35843,
 "nic-ymb",
 "Latn",
}
m["mlc"] = {
 "Caolan",
 3446682,
 "tai-cho",
 "Latn, Hani",
 sort_key = {Hani = "Hani-sortkey"},
}
m["mle"] = {
 "Manambu",
 11732406,
 "paa-spk",
 "Latn",
}
m["mlf"] = {
 "Mal",
 3281057,
 "mkh-khm",
}
m["mlh"] = {
 "Mape",
 6753787,
}
m["mli"] = {
 "Malimpung",
 12473435,
}
m["mlj"] = {
 "Miltu",
 3441310,
}
m["mlk"] = {
 "Ilwana",
 6001357,
 "bnt-sab",
}
m["mll"] = {
 "Malua Bay",
 6744946,
 "poz-vnc",
 "Latn",
}
m["mlm"] = {
 "Mulam",
 3092284,
 "qfa-kms",
 "Latn",
}
m["mln"] = {
 "Malango",
 3281522,
 "poz-sls",
 "Latn",
}
m["mlo"] = {
 "Mlomp",
 36009,
 "alv-bak",
}
m["mlp"] = {
 "Bargam",
 4860543,
 "ngf-mad",
 "Latn",
}
m["mlq"] = {
 "Western Maninkakan",
 11028033,
 "dmn-wmn",
}
m["mlr"] = {
 "Vame",
 3515088,
}
m["mls"] = {
 "Masalit",
 56557,
 "ssa",
}
m["mlu"] = {
 "To'abaita",
 36645,
 "poz-sls",
 "Latn",
}
m["mlv"] = {
 "Mwotlap",
 2475538,
 "poz-vnc",
 "Latn",
}
m["mlw"] = {
 "Moloko",
 1965222,
 "cdc-cbm",
 "Latn",
}
m["mlx"] = {
 "Malfaxal",
 2157421,
 "poz-vnc",
 "Latn",
}
m["mlz"] = {
 "Malaynon",
 18755512,
 "phi",
}
m["mma"] = {
 "Mama",
 3913963,
 "nic-jrn",
}
m["mmb"] = {
 "Momina",
 6897297,
}
m["mmc"] = {
 "Michoacán Mazahua",
 12953705,
 "oto",
 "Latn",
}
m["mmd"] = {
 "Maonan",
 3092293,
 "qfa-kms",
 "Latn",
}
m["mme"] = {
 "Mae",
 3276286,
 "poz-vnc",
 "Latn",
}
m["mmf"] = {
 "Mundat",
 56263,
 "cdc-wst",
 "Latn",
}
m["mmg"] = {
 "North Ambrym",
 2842468,
 "poz-vnc",
 "Latn",
}
m["mmh"] = {
 "Mehináku",
 3501838,
 "awd",
 "Latn",
}
m["mmi"] = {
 "Musar",
 6940113,
 "ngf-mad",
}
m["mmj"] = {
 "Majhwar",
 6737795,
}
m["mmk"] = {
 "Mukha-Dora",
 6933447,
}
m["mml"] = {
 "Man Met",
 3194984,
 "mkh-pal",
}
m["mmm"] = {
 "Maii",
 6735599,
 "poz-vnc",
 "Latn",
}
m["mmn"] = {
 "Mamanwa",
 3206623,
 "phi",
 "Latn",
}
m["mmo"] = {
 "Mangga Buang",
 12952294,
 "poz-ocw",
 "Latn",
}
m["mmp"] = {
 "Musan",
 2605703,
 "paa-asa",
}
m["mmq"] = {
 "Aisi",
 6940074,
 "ngf-mad",
 "Latn",
}
m["mmr"] = {
 "Western Xiangxi Miao",
 3307901,
 "hmn",
}
m["mmt"] = {
 "Malalamai",
 3281496,
 "poz-ocw",
 "Latn",
}
m["mmu"] = {
 "Mmaala",
 13123461,
 "nic-ymb",
 "Latn",
}
m["mmv"] = {
 "Miriti",
 6873567,
 "sai-tuc",
 "Latn",
}
m["mmw"] = {
 "Emae",
 3051961,
 "poz-pnp",
 "Latn",
}
m["mmx"] = {
 "Madak",
 3275205,
 "poz-ocw",
 "Latn",
}
m["mmy"] = {
 "Migaama",
 56259,
 "cdc-est",
 "Latn",
}
m["mmz"] = {
 "Mabaale",
 11003249,
 "bnt-ngn",
}
m["mna"] = {
 "Mbula",
 3303572,
 "poz-ocw",
 "Latn",
}
m["mnb"] = {
 "Muna",
 6935584,
 "poz-mun",
 "Latn",
}
m["mnc"] = {
 "Manchu",
 33638,
 "tuw",
 "mnc-Mong, Latn",
 ancestors = "juc",
 translit = "mnc-translit",
}
m["mnd"] = {
 "Mondé",
 6898840,
 "tup",
 "Latn",
}
m["mne"] = {
 "Naba",
 760732,
 "csu-bgr",
}
m["mnf"] = {
 "Mundani",
 35839,
 "nic-mom",
 "Latn",
}
m["mng"] = {
 "Eastern Mnong",
 12953747,
 "mkh-ban",
}
m["mnh"] = {
 "Mono (Congo)",
 33501,
 "bad-cnt",
 "Latn",
}
m["mni"] = {
 "Manipuri",
 33868,
 "sit",
 "Mtei, Beng",
 ancestors = "omp",
 translit = {Mtei = "Mtei-translit"},
}
m["mnj"] = {
 "Munji",
 33639,
 "ira-mny",
 "Arab",
}
m["mnk"] = {
 "Mandinka",
 33678,
 "dmn-wmn",
 "Latn",
}
m["mnl"] = {
 "Tiale",
 6744350,
 "poz-vnc",
 "Latn",
}
m["mnm"] = {
 "Mapena",
 11732415,
}
m["mnn"] = {
 "Southern Mnong",
 23857582,
}
m["mnp"] = {
 "Min Bei",
 36457,
 "zhx-min-shn",
 "Hani, Hant, Hans",
 generate_forms = "zh-generateforms",
 translit = "zh-translit",
 sort_key = "Hani-sortkey",
}
m["mnq"] = {
 "Minriq",
 2742268,
 "mkh-asl",
}
m["mnr"] = {
 "Mono (California)",
 33591,
 "azc-num",
 "Latn",
}
m["mns"] = {
 "Mansi",
 33759,
 "urj-ugr",
 "Cyrl",
 translit = "mns-translit",
 override_translit = true,
}
m["mnt"] = {
 "Maykulan",
 3915696,
 "aus-pam",
 "Latn",
}
m["mnu"] = {
 "Mer",
 6817854,
}
m["mnv"] = {
 "Rennellese",
 3397346,
 "poz-pnp",
 "Latn",
}
m["mnw"] = {
 "Mon",
 13349,
 "mkh-mnc",
 "Mymr",
 ancestors = "mkh-mmn",
 sort_key = {
  from = {"ျ", "ြ", "ွ", "ှ", "ၞ", "ၟ", "ၠ", "ၚ", "ဿ"},
  to = {"္ယ", "္ရ", "္ဝ", "္ဟ", "္န", "္မ", "္လ", "င", "သ္သ"}
 },
}
m["mnx"] = {
 "Manikion",
 3507964,
 "paa-wpa",
}
m["mny"] = {
 "Manyawa",
 11002622,
 "bnt-mak",
 ancestors = "vmw",
}
m["mnz"] = {
 "Moni",
 6899857,
}
m["moa"] = {
 "Mwan",
 3320111,
 "dmn-nbe",
 "Latn",
}
m["moc"] = {
 "Mocoví",
 3027906,
 "sai-guc",
 "Latn",
}
m["mod"] = {
 "Mobilian",
 13333,
 "crp",
 "Latn",
 ancestors = "cho, cic",
}
m["moe"] = {
 "Montagnais",
 13351,
 "alg",
 "Latn",
 ancestors = "cr",
 entry_name = {remove_diacritics = c.macron},
}
m["mog"] = {
 "Mongondow",
 3058458,
 "phi",
 "Latn",
}
m["moh"] = {
 "Mohawk",
 13339,
 "iro-nor",
 "Latn",
 ancestors = "iro-omo",
}
m["moi"] = {
 "Mboi",
 3914417,
 "alv-yun",
}
m["moj"] = {
 "Monzombo",
 11154772,
 "nic-nkk",
 "Latn",
}
m["mok"] = {
 "Morori",
 6913275,
}
m["mom"] = {
 "Monimbo",
 56542,
}
m["moo"] = {
 "Monom",
 6901726,
 "mkh-ban",
}
m["mop"] = {
 "Mopan Maya",
 36183,
 "myn",
 "Latn",
}
m["moq"] = {
 "Mor (Papuan)",
 11732468,
 "paa",
}
m["mor"] = {
 "Moro",
 36172,
 "alv-hei",
}
m["mos"] = {
 "Moore",
 36096,
 "nic-mre",
 "Latn",
}
m["mot"] = {
 "Barí",
 2886281,
 "cba",
 "Latn",
}
m["mou"] = {
 "Mogum",
 3440473,
 "cdc-est",
 "Latn",
}
m["mov"] = {
 "Mojave",
 56510,
 "nai-yuc",
 "Latn",
}
m["mow"] = {
 "Moi (Congo)",
 11124792,
 "bnt-bmo",
 "Latn",
}
m["mox"] = {
 "Molima",
 3319495,
 "poz-ocw",
 "Latn",
}
m["moy"] = {
 "Shekkacho",
 56827,
 "omv-gon",
}
m["moz"] = {
 "Mukulu",
 3440403,
 "cdc-est",
}
m["mpa"] = {
 "Mpoto",
 6928303,
 "bnt-mbi",
}
m["mpb"] = {
 "Mullukmulluk",
 6741120,
}
m["mpc"] = {
 "Mangarayi",
 6748829,
}
m["mpd"] = {
 "Machinere",
 12953681,
 "awd",
 "Latn",
}
m["mpe"] = {
 "Majang",
 56724,
 "sdv",
}
m["mpg"] = {
 "Marba",
 56614,
 "cdc-mas",
}
m["mph"] = {
 "Maung",
 6792550,
 "aus-wdj",
 "Latn",
}
m["mpi"] = {
 "Mpade",
 3280670,
 "cdc-cbm",
 "Latn",
}
m["mpj"] = {
 "Martu Wangka",
 3295916,
 "aus-pam",
 "Latn",
}
m["mpk"] = {
 "Mbara (Chad)",
 3912770,
 "cdc-cbm",
}
m["mpl"] = {
 "Middle Watut",
 15887910,
 "poz-ocw",
 "Latn",
}
m["mpm"] = {
 "Yosondúa Mixtec",
 12953741,
 "omq-mxt",
 "Latn",
}
m["mpn"] = {
 "Mindiri",
 6863842,
 "poz-ocw",
 "Latn",
}
m["mpo"] = {
 "Miu",
 6883668,
 "poz-ocw",
 "Latn",
}
m["mpp"] = {
 "Migabac",
 11732448,
}
m["mpq"] = {
 "Matís",
 3299145,
 "sai-pan",
 "Latn",
}
m["mpr"] = {
 "Vangunu",
 3554582,
 "poz-ocw",
 "Latn",
}
m["mps"] = {
 "Dadibi",
 5208077,
 "ngf",
 "Latn",
}
m["mpt"] = {
 "Mian",
 12952846,
 "ngf-okk",
 "Latn",
}
m["mpu"] = {
 "Makuráp",
 3281037,
 "tup",
 "Latn",
}
m["mpv"] = {
 "Mungkip",
 11732485,
 "ngf-fin",
 "Latn",
}
m["mpw"] = {
 "Mapidian",
 6753812,
 "awd",
 "Latn",
}
m["mpx"] = {
 "Misima-Paneati",
 6875666,
 "poz-ocw",
 "Latn",
}
m["mpy"] = {
 "Mapia",
 3287224,
 "poz-mic",
 "Latn",
}
m["mpz"] = {
 "Mpi",
 6928276,
 "tbq-lol",
}
m["mqa"] = {
 "Maba",
 3273750,
}
m["mqb"] = {
 "Mbuko",
 3502213,
 "cdc-cbm",
 "Latn",
}
m["mqc"] = {
 "Mangole",
 6749097,
 "poz-cma",
 "Latn",
}
m["mqe"] = {
 "Matepi",
 11732426,
 "ngf-mad",
}
m["mqf"] = {
 "Momuna",
 6897518,
}
m["mqg"] = {
 "Kota Bangun Kutai Malay",
 12952778,
}
m["mqh"] = {
 "Tlazoyaltepec Mixtec",
 12953740,
 "omq-mxt",
 "Latn",
}
m["mqi"] = {
 "Mariri",
 6765544,
}
m["mqj"] = {
 "Mamasa",
 6745452,
 "poz-ssw",
 "Latn",
}
m["mqk"] = {
 "Rajah Kabunsuwan Manobo",
 12953700,
 "mno",
}
m["mql"] = {
 "Mbelime",
 4286473,
 "nic-eov",
}
m["mqm"] = {
 "South Marquesan",
 19694214,
 "poz-pep",
 "Latn",
}
m["mqn"] = {
 "Moronene",
 642581,
 "poz-btk",
 "Latn",
}
m["mqo"] = {
 "Modole",
 11732457,
 "paa-nha",
}
m["mqp"] = {
 "Manipa",
 6749799,
 "poz-cma",
 "Latn",
}
m["mqq"] = {
 "Minokok",
 18642293,
}
m["mqr"] = {
 "Mander",
 6747979,
 "paa-tkw",
}
m["mqs"] = {
 "West Makian",
 3033575,
 "paa-nha",
}
m["mqt"] = {
 "Mok",
 13018559,
 "mkh-pal",
}
m["mqu"] = {
 "Mandari",
 3285426,
 "sdv-bri",
}
m["mqv"] = {
 "Mosimo",
 11732478,
 "ngf-mad",
 "Latn",
}
m["mqw"] = {
 "Murupi",
 11732486,
 "ngf-mad",
 "Latn",
}
m["mqx"] = {
 "Mamuju",
 6746004,
 "poz-ssw",
 "Latn",
}
m["mqy"] = {
 "Manggarai",
 3285748,
 "poz-cet",
 "Latn",
}
m["mqz"] = {
 "Malasanga",
 14916889,
 "poz-ocw",
 "Latn",
}
m["mra"] = {
 "Mlabri",
 3073465,
 "mkh",
}
m["mrb"] = {
 "Marino",
 3293299,
}
m["mrc"] = {
 "Maricopa",
 56386,
 "nai-yuc",
 "Latn",
}
m["mrd"] = {
 "Western Magar",
 22303263,
 "sit-gma",
}
m["mre"] = {
 "Martha's Vineyard Sign Language",
 33494,
 "sgn",
 "Latn, Sgnw",
}
m["mrf"] = {
 "Elseng",
 3915667,
 "paa-brd",
}
m["mrg"] = {
 "Mising",
 3316328,
 "sit-tan",
 "Latn, Beng, Deva",
 ancestors = "adi",
}
m["mrh"] = {
 "Mara Chin",
 4175893,
 "tbq-kuk",
 "Latn",
}
m["mrj"] = {
 "Western Mari",
 1776032,
 "chm",
 "Cyrl",
 translit = "chm-translit",
 sort_key = "mrj-sortkey",
}
m["mrk"] = {
 "Hmwaveke",
 5873712,
 "poz-cln",
 "Latn",
}
m["mrl"] = {
 "Mortlockese",
 3324598,
 "poz-mic",
 "Latn",
}
m["mrm"] = {
 "Merlav",
 3331115,
 "poz-vnc",
 "Latn",
}
m["mrn"] = {
 "Cheke Holo",
 2962165,
 "poz-ocw",
 "Latn",
}
m["mro"] = {
 "Mru",
 1951521,
 "sit-mru",
 "Latn, Mroo",
}
m["mrp"] = {
 "Morouas",
 6913299,
 "poz-vnc",
 "Latn",
}
m["mrq"] = {
 "North Marquesan",
 2603808,
 "poz-pep",
 "Latn",
}
m["mrr"] = {
 "Hill Maria",
 27602,
 "dra",
 ancestors = "gon",
}
m["mrs"] = {
 "Maragus",
 6754640,
 "poz-vnc",
 "Latn",
}
m["mrt"] = {
 "Margi",
 56241,
 "cdc-cbm",
 "Latn",
}
m["mru"] = {
 "Mono (Cameroon)",
 11031964,
 "alv-mbm",
 "Latn",
}
m["mrv"] = {
 "Mangarevan",
 36237,
 "poz-pep",
 "Latn",
}
m["mrw"] = {
 "Maranao",
 33800,
 "phi",
 "Latn, Arab",
}
m["mrx"] = {
 "Dineor",
 5278044,
 "paa-tkw",
}
m["mry"] = {
 "Karaga Mandaya",
 6747925,
 "phi",
}
m["mrz"] = {
 "Marind",
 6763970,
}
m["msb"] = {
 "Masbatenyo",
 33948,
 "phi",
 "Latn",
}
m["msc"] = {
 "Sankaran Maninka",
 11155812,
 "dmn-mnk",
}
m["msd"] = {
 "Yucatec Maya Sign Language",
 34281,
 "sgn",
 "Latn", -- when documented
}
m["mse"] = {
 "Musey",
 56328,
 "cdc-mas",
}
m["msf"] = {
 "Mekwei",
 4544752,
 "paa-nim",
 "Latn",
}
m["msg"] = {
 "Moraid",
 6909020,
}
m["msi"] = {
 "Sabah Malay",
 10867404,
 "crp",
}
m["msj"] = {
 "Ma",
 6720909,
 "nic-mbc",
 "Latn",
}
m["msk"] = {
 "Mansaka",
 12952800,
 "phi",
 "Latn",
}
m["msl"] = {
 "Molof",
 4300950,
}
m["msm"] = {
 "Agusan Manobo",
 12953696,
 "mno",
}
m["msn"] = {
 "Vurës",
 3563857,
 "poz-vnc",
 "Latn",
}
m["mso"] = {
 "Mombum",
 6897079,
}
m["msp"] = {
 "Maritsauá",
 6765915,
 "tup",
 "Latn",
}
m["msq"] = {
 "Caac",
 2932212,
 "poz-cln",
 "Latn",
}
m["msr"] = {
 "Mongolian Sign Language",
 3915499,
 "sgn",
}
m["mss"] = {
 "West Masela",
 12952816,
 "poz-tim",
}
m["msu"] = {
 "Musom",
 6943041,
 "poz-ocw",
 "Latn",
}
m["msv"] = {
 "Maslam",
 3502273,
}
m["msw"] = {
 "Mansoanka",
 35814,
}
m["msx"] = {
 "Moresada",
 11732475,
}
m["msy"] = {
 "Aruamu",
 3501809,
 "paa",
 "Latn",
}
m["msz"] = {
 "Momare",
 6897030,
}
m["mta"] = {
 "Cotabato Manobo",
 12953698,
 "mno",
}
m["mtb"] = {
 "Anyin Morofo",
 3502338,
 "alv-ctn",
 "Latn",
 ancestors = "any",
}
m["mtc"] = {
 "Munit",
 11732482,
 "ngf-mad",
}
m["mtd"] = {
 "Mualang",
 3073458,
 "poz-mly",
}
m["mte"] = {
 "Alu",
 33503,
 "poz-ocw",
 "Latn",
}
m["mtf"] = {
 "Murik (New Guinea)",
 7050035,
 "paa-lsp",
 "Latn",
}
m["mtg"] = {
 "Una",
 5580728,
}
m["mth"] = {
 "Munggui",
 6936018,
 "poz-hce",
 "Latn",
}
m["mti"] = {
 "Maiwa (New Guinea)",
 6737223,
 "ngf",
 "Latn",
}
m["mtj"] = {
 "Moskona",
 11288953,
}
m["mtk"] = {
 "Mbe'",
 10964025,
 "nic-nka",
 "Latn",
}
m["mtl"] = {
 "Montol",
 3440457,
 "cdc-wst",
 "Latn",
}
m["mtm"] = {
 "Mator",
 20669419,
 "syd",
 "Cyrl",
}
m["mtn"] = {
 "Matagalpa",
 3490756,
 "nai-min",
}
m["mto"] = {
 "Totontepec Mixe",
 7828400,
 "nai-miz",
}
m["mtp"] = {
 "Wichí Lhamtés Nocten",
 5908756,
 "sai-wic",
 "Latn",
}
m["mtq"] = {
 "Muong",
 3236789,
 "mkh-vie",
 "Latn",
 sort_key = "vi-sortkey",
}
m["mtr"] = {
 "Mewari",
 nil,
 "inc-wes",
 "Deva",
 ancestors = "raj",
 translit = "hi-translit", -- for now
}
m["mts"] = {
 "Yora",
 3572572,
 "sai-pan",
 "Latn",
}
m["mtt"] = {
 "Mota",
 3325052,
 "poz-vnc",
 "Latn",
}
m["mtu"] = {
 "Tututepec Mixtec",
 7857069,
 "omq-mxt",
 "Latn",
}
m["mtv"] = {
 "Asaro'o",
 3503684,
 "ngf-fin",
 "Latn",
}
m["mtw"] = {
 "Magahat",
 6729600,
 "phi",
}
m["mtx"] = {
 "Tidaá Mixtec",
 7800805,
 "omq-mxt",
 "Latn",
}
m["mty"] = {
 "Nabi",
 6956858,
 "qfa-tor",
 "Latn",
}
m["mua"] = {
 "Mundang",
 36032,
 "alv-mbm",
}
m["mub"] = {
 "Mubi",
 3440518,
 "cdc-est",
 "Latn",
}
m["muc"] = {
 "Mbu'",
 35868,
 "nic-beb",
 "Latn",
}
m["mud"] = {
 "Mednyj Aleut",
 1977419,
}
m["mue"] = {
 "Media Lengua",
 36066,
 "crp",
 "Latn",
 ancestors = "es, qu",
}
m["mug"] = {
 "Musgu",
 3123545,
 "cdc-cbm",
 "Latn",
}
m["muh"] = {
 "Mündü",
 35981,
 "nic-nke",
 "Latn",
}
m["mui"] = {
 "Musi",
 615660,
 "poz-mly",
 "Latn",
}
m["muj"] = {
 "Mabire",
 3440437,
}
m["mul"] = {
 "Translingual",
 20923490,
 "qfa-not",
 "All",
 wikipedia_article = "Translingualism",
 sort_key = {
  Hani = "Hani-sortkey",
  Jpan = "Jpan-sortkey",
  Hrkt = "Hira-sortkey", -- Sort all kana as Hira.
  Hira = "Hira-sortkey",
  Kana = "Hira-sortkey",
 },
 standardChars = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz" .. c.punc,
}
m["mum"] = {
 "Maiwala",
 12952764,
 "poz-ocw",
 "Latn",
}
m["muo"] = {
 "Nyong",
 36373,
 "alv-lek",
}
m["mup"] = {
 "Malvi",
 33413,
 "inc-wes",
 "Deva",
 ancestors = "raj",
 translit = "hi-translit"
}
m["muq"] = {
 "Eastern Xiangxi Miao",
 27431376,
 "hmn",
}
m["mur"] = {
 "Murle",
 56727,
 "sdv",
}
m["mus"] = {
 "Creek",
 523014,
 "nai-mus",
 "Latn",
}
m["mut"] = {
 "Western Muria",
 12952886,
 "dra",
 ancestors = "gon",
}
m["muu"] = {
 "Yaaku",
 34222,
 "cus-eas",
}
m["muv"] = {
 "Muthuvan",
 3327420,
 "dra",
}
m["mux"] = {
 "Bo-Ung",
 15831607,
}
m["muy"] = {
 "Muyang",
 3502301,
 "cdc-cbm",
 "Latn",
}
m["muz"] = {
 "Mursi",
 36013,
 "sdv",
}
m["mva"] = {
 "Manam",
 6746851,
 "poz-ocw",
 "Latn",
}
m["mvb"] = {
 "Mattole",
 20824,
 "ath-pco",
 "Latn",
}
m["mvd"] = {
 "Mamboru",
 578815,
 "poz",
}
m["mvg"] = {
 "Yucuañe Mixtec",
 25562736,
 "omq-mxt",
 "Latn",
}
m["mvh"] = {
 "Mire",
 3441359,
}
m["mvi"] = {
 "Miyako",
 36218,
 "jpx-ryu",
 "Jpan",
 translit = s["Jpan-translit"],
 sort_key = s["Jpan-sortkey"],
}
m["mvk"] = {
 "Mekmek",
 6810592,
 "paa-yua",
}
m["mvl"] = {
 "Mbara (Australia)",
 6799620,
 "aus-pam",
}
m["mvm"] = {
 "Muya",
 2422759,
 "sit-qia",
}
m["mvn"] = {
 "Minaveha",
 6863278,
 "poz-ocw",
 "Latn",
}
m["mvo"] = {
 "Marovo",
 3294683,
 "poz-ocw",
 "Latn",
}
m["mvp"] = {
 "Duri",
 3915414,
 "poz-ssw",
}
m["mvq"] = {
 "Moere",
 11732458,
 "ngf-mad",
}
m["mvr"] = {
 "Marau",
 6755069,
 "poz-hce",
 "Latn",
}
m["mvs"] = {
 "Massep",
 3502895,
 "paa-tkw",
}
m["mvt"] = {
 "Mpotovoro",
 6928305,
 "poz-vnc",
 "Latn",
}
m["mvu"] = {
 "Marfa",
 713633,
}
m["mvv"] = {
 "Tagal Murut",
 7675300,
 "poz-san",
 "Latn",
}
m["mvw"] = {
 "Machinga",
 12952754,
 "bnt-rvm",
}
m["mvx"] = {
 "Meoswar",
 6817777,
 "poz-hce",
 "Latn",
}
m["mvy"] = {
 "Indus Kohistani",
 33399,
 "inc-dar",
}
m["mvz"] = {
 "Mesqan",
 6821677,
 "sem-eth",
}
m["mwa"] = {
 "Mwatebu",
 14916896,
 "poz-ocw",
 "Latn",
}
m["mwb"] = {
 "Juwal",
 6319103,
 "qfa-tor",
 "Latn",
}
m["mwc"] = {
 "Are",
 29277,
 "poz-ocw",
 "Latn",
}
m["mwe"] = {
 "Mwera",
 6944725,
 "bnt-rvm",
 "Latn",
}
m["mwf"] = {
 "Murrinh-Patha",
 2980398,
 "aus-dal",
 "Latn",
}
m["mwg"] = {
 "Aiklep",
 3399652,
 "poz-ocw",
 "Latn",
}
m["mwh"] = {
 "Mouk-Aria",
 3325498,
 "poz-ocw",
 "Latn",
}
m["mwi"] = {
 "Labo",
 2157452,
 "poz-vnc",
 "Latn",
}
m["mwk"] = {
 "Kita Maninkakan",
 3015523,
 "dmn-wmn",
}
m["mwl"] = {
 "Mirandese",
 13330,
 "roa-ibe",
 "Latn",
 ancestors = "roa-ole",
}
m["mwm"] = {
 "Sar",
 56850,
 "csu-sar",
}
m["mwn"] = {
 "Nyamwanga",
 6944666,
 "bnt-mwi",
}
m["mwo"] = {
 "Central Maewo",
 3276435,
}
m["mwp"] = {
 "Kala Lagaw Ya",
 2591262,
 "aus-pam",
 "Latn",
}
m["mwq"] = {
 "Mün Chin",
 331340,
 "tbq-kuk",
}
m["mwr"] = {
 "Marwari",
 56312,
 "inc-wes",
 "Deva, Mahj",
 ancestors = "raj",
 translit = {
  Deva = "hi-translit", -- for now
  Mahj = "Mahj-translit",
 },
}
m["mws"] = {
 "Mwimbi-Muthambi",
 15632357,
 "bnt-kka",
 "Latn",
}
m["mwt"] = {
 "Moken",
 18648701,
 "poz",
}
m["mwu"] = {
 "Mittu",
 6883573,
 "csu-bbk",
 "Latn",
}
m["mwv"] = {
 "Mentawai",
 13365,
 "poz-nws",
 "Latn",
}
m["mww"] = {
 "White Hmong",
 3138829,
 "hmn",
 "Latn, Hmng",
}
m["mwz"] = {
 "Moingi",
 11011905,
}
m["mxa"] = {
 "Northwest Oaxaca Mixtec",
 12953739,
 "omq-mxt",
 "Latn",
}
m["mxb"] = {
 "Tezoatlán Mixtec",
 3317286,
 "omq-mxt",
 "Latn",
}
m["mxd"] = {
 "Modang",
 6888037,
 "poz",
}
m["mxe"] = {
 "Mele-Fila",
 3305008,
 "poz-pnp",
 "Latn",
}
m["mxf"] = {
 "Malgbe",
 3502224,
}
m["mxg"] = {
 "Mbangala",
 6799612,
 "bnt-yak",
}
m["mxh"] = {
 "Mvuba",
 6944591,
 "csu-mle",
 "Latn",
}
m["mxi"] = {
 "Mozarabic",
 317044,
 "roa-ibe",
 "Arab, Hebr, Latn",
 translit = "mxi-translit",
}
m["mxj"] = {
 "Miju",
 56332,
 "sit-mdz",
 "Latn, Deva",
}
m["mxk"] = {
 "Monumbo",
 6906792,
 "qfa-tor",
}
m["mxl"] = {
 "Maxi Gbe",
 35770,
 "alv-gbe",
}
m["mxm"] = {
 "Meramera",
 6817936,
 "poz-ocw",
 "Latn",
}
m["mxn"] = {
 "Moi (Indonesia)",
 11732459,
 "paa",
}
m["mxo"] = {
 "Mbowe",
 10962309,
 "bnt-kav",
}
m["mxp"] = {
 "Tlahuitoltepec Mixe",
 7810697,
}
m["mxq"] = {
 "Juquila Mixe",
 25559721,
}
m["mxr"] = {
 "Murik (Malaysia)",
 3328150,
 nil,
 "Latn",
}
m["mxs"] = {
 "Huitepec Mixtec",
 12953729,
 "omq-mxt",
 "Latn",
}
m["mxt"] = {
 "Jamiltepec Mixtec",
 12953730,
 "omq-mxt",
 "Latn",
}
m["mxu"] = {
 "Mada (Cameroon)",
 3441206,
 "cdc-cbm",
 "Latn",
}
m["mxv"] = {
 "Metlatónoc Mixtec",
 36363,
 "omq-mxt",
 "Latn",
}
m["mxw"] = {
 "Namo",
 12952923,
}
m["mxx"] = {
 "Mahou",
 11004334,
 "dmn-mnk",
}
m["mxy"] = {
 "Southeastern Nochixtlán Mixtec",
 7070684,
 "omq-mxt",
 "Latn",
}
m["mxz"] = {
 "Central Masela",
 42575433,
 "poz-tim",
}
m["myb"] = {
 "Mbay",
 3033565,
 "csu-sar",
}
m["myc"] = {
 "Mayeka",
 11129517,
 "bnt-boa",
}
m["mye"] = {
 "Myene",
 35832,
 "bnt-tso",
}
m["myf"] = {
 "Bambassi",
 56540,
 "omv-mao",
}
m["myg"] = {
 "Manta",
 35799,
 "nic-mom",
 "Latn",
}
m["myh"] = {
 "Makah",
 3280640,
 "wak",
 "Latn",
}
m["myj"] = {
 "Mangayat",
 35988,
 "nic-ser",
}
m["myk"] = {
 "Mamara Senoufo",
 36187,
 "alv-sma",
}
m["myl"] = {
 "Moma",
 6897018,
 "poz",
}
m["mym"] = {
 "Me'en",
 3408516,
 "sdv",
}
m["myo"] = {
 "Anfillo",
 34928,
 "omv-gon",
}
m["myp"] = {
 "Pirahã",
 33825,
 "sai-mur",
 "Latn",
}
m["myr"] = {
 "Muniche",
 3915654,
}
m["mys"] = {
 "Mesmes",
 3508617,
 "sem-eth",
}
m["myu"] = {
 "Mundurukú",
 746723,
 "tup",
 "Latn",
}
m["myv"] = {
 "Erzya",
 29952,
 "urj-mdv",
 "Cyrl",
 translit = "myv-translit",
 override_translit = true,
}
m["myw"] = {
 "Muyuw",
 3502878,
 "poz-ocw",
 "Latn",
}
m["myx"] = {
 "Masaba",
 12952814,
 "bnt-msl",
 "Latn",
}
m["myy"] = {
 "Macuna",
 3275059,
 "sai-tuc",
 "Latn",
}
m["myz"] = {
 "Classical Mandaic",
 25559314,
 "sem-ase",
 "Mand",
}
m["mza"] = {
 "Santa María Zacatepec Mixtec",
 8063756,
 "omq-mxt",
 "Latn",
}
m["mzb"] = {
 "Northern Saharan Berber",
 11156769,
 "ber",
}
m["mzc"] = {
 "Madagascar Sign Language",
 12715020,
 "sgn",
}
m["mzd"] = {
 "Malimba",
 35806,
 "bnt-saw",
}
m["mze"] = {
 "Morawa",
 6909384,
}
m["mzg"] = {
 "Monastic Sign Language",
 3217333,
 "sgn",
}
m["mzh"] = {
 "Wichí Lhamtés Güisnay",
 7998197,
 "sai-wic",
 "Latn",
}
m["mzi"] = {
 "Ixcatlán Mazatec",
 6101049,
 "omq-maz",
 "Latn",
}
m["mzj"] = {
 "Manya",
 11006832,
 "dmn-mnk",
}
m["mzk"] = {
 "Nigeria Mambila",
 11004163,
 "nic-mmb",
 "Latn",
}
m["mzl"] = {
 "Mazatlán Mixe",
 25559728,
}
m["mzm"] = {
 "Mumuye",
 36021,
 "alv-mum",
 "Latn",
}
m["mzn"] = {
 "Mazanderani",
 13356,
 "ira-msh",
 "mzn-Arab",
}
m["mzo"] = {
 "Matipuhy",
 6787588,
 "sai-kui",
 "Latn",
}
m["mzp"] = {
 "Movima",
 1659701,
 "qfa-iso",
}
m["mzq"] = {
 "Mori Atas",
 3324070,
 "poz-btk",
}
m["mzr"] = {
 "Marúbo",
 3296011,
 "sai-pan",
 "Latn",
}
m["mzs"] = {
 "Macanese",
 35785,
 "crp",
 "Latn",
 ancestors = "pt",
}
m["mzt"] = {
 "Mintil",
 6869641,
 "mkh-asl",
}
m["mzu"] = {
 "Inapang",
 6013569,
 "paa",
 "Latn",
}
m["mzv"] = {
 "Manza",
 36038,
 "alv-gbf",
}
m["mzw"] = {
 "Deg",
 35183,
 "nic-gnw",
 "Latn",
}
m["mzx"] = {
 "Mawayana",
 6794377,
 "awd",
}
m["mzy"] = {
 "Mozambican Sign Language",
 6927809,
 "sgn",
}
m["mzz"] = {
 "Maiadomu",
 6735234,
 "poz-ocw",
 "Latn",
}
m["naa"] = {
 "Namla",
 3508760,
 "paa-pau",
 "Latn",
}
m["nab"] = {
 "Nambikwara",
 2068190,
 "sai-nmk",
 "Latn",
}
m["nac"] = {
 "Narak",
 6965295,
 "ngf",
 "Latn",
}
m["nae"] = {
 "Naka'ela",
 6960073,
 "poz",
 "Latn",
}
m["naf"] = {
 "Nabak",
 11732491,
 "ngf",
 "Latn",
}
m["nag"] = {
 "Naga Pidgin",
 3503454,
 "crp",
 "Latn",
 ancestors = "as",
}
m["nah"] = {
 "Nahuatl",
 13300,
 "azc-nah",
 "Latn",
}
m["naj"] = {
 "Nalu",
 36026,
 "alv-nal",
 "Latn",
}
m["nak"] = {
 "Nakanai",
 6528669,
 "poz-ocw",
 "Latn",
}
m["nal"] = {
 "Nalik",
 3335387,
 "poz-ocw",
 "Latn",
}
m["nam"] = {
 "Ngan'gityemerri",
 3298041,
 "aus-dal",
 "Latn",
}
m["nan"] = {
 "Min Nan",
 36495,
 "zhx-min-hai",
 "Hani, Hant, Hans, Latn, Bopo, Kana",
 wikimedia_codes = "zh-min-nan",
 generate_forms = "zh-generateforms",
 sort_key = {
  Hani = "Hani-sortkey",
  Kana = "Kana-sortkey"
 },
}
m["nao"] = {
 "Naaba",
 11883865,
 "sit",
 ancestors = "xct",
}
m["nap"] = {
 "Neapolitan",
 33845,
 "roa-itd",
 "Latn",
}
m["naq"] = {
 "Khoekhoe",
 13301,
 "khi-khk",
 "Latn",
}
m["nar"] = {
 "Iguta",
 5621686,
 "nic-jer",
 "Latn",
}
m["nas"] = {
 "Nasioi",
 56772,
 "paa-sbo",
 "Latn",
}
m["nat"] = {
 "Hungworo",
 3914395,
 "nic-kmk",
 "Latn",
}
m["naw"] = {
 "Nawuri",
 35906,
 "alv-gng",
 "Latn",
}
m["nax"] = {
 "Nakwi",
 3504178,
 "qfa-mal",
 "Latn",
}
m["nay"] = {
 "Ngarrindjeri",
 7022091,
 "aus-pam",
 "Latn",
}
m["naz"] = {
 "Coatepec Nahuatl",
 5138605,
 "azc-nah",
 "Latn",
}
m["nba"] = {
 "Nyemba",
 3346655,
 "bnt-clu",
 "Latn",
 ancestors = "lch",
}
m["nbb"] = {
 "Ndoe",
 36134,
 "nic-eko",
 "Latn",
}
m["nbc"] = {
 "Chang",
 5071694,
 "sit-kch",
 "Latn",
}
m["nbd"] = {
 "Ngbinda",
 11132859,
 "bnt-boa",
 "Latn",
}
m["nbe"] = {
 "Konyak Naga",
 6430448,
 "sit-kch",
 "Latn",
}
m["nbg"] = {
 "Nagarchal",
 13299,
 "dra",
 ancestors = "gon",
}
m["nbh"] = {
 "Ngamo",
 3438705,
 "cdc-wst",
 "Latn",
}
m["nbi"] = {
 "Mao Naga",
 12952905,
 "tbq-anp",
 "Latn",
}
m["nbj"] = {
 "Ngarinman",
 10600380,
 nil,
 "Latn",
}
m["nbk"] = {
 "Nake",
 11732496,
 "ngf-mad",
 "Latn",
}
m["nbm"] = {
 "Ngbaka Ma'bo",
 3915331,
 "nic-nkm",
 "Latn",
}
m["nbn"] = {
 "Kuri",
 3200540,
 "poz",
 "Latn",
}
m["nbo"] = {
 "Nkukoli",
 3914482,
 "nic-uce",
 "Latn",
}
m["nbp"] = {
 "Nnam",
 36138,
 "nic-eko",
 "Latn",
}
m["nbq"] = {
 "Nggem",
 12952956,
 "ngf",
 "Latn",
}
m["nbr"] = {
 "Numana",
 5529310,
 "nic-nin",
 "Latn",
}
m["nbs"] = {
 "Namibian Sign Language",
 6961792,
 "sgn",
 "Latn", -- when documented
}
m["nbt"] = {
 "Na",
 12952895,
 "sit-tan",
 "Deva, Latn",
}
m["nbu"] = {
 "Rongmei Naga",
 12952912,
 "sit-zem",
 "Latn",
}
m["nbv"] = {
 "Ngamambo",
 11129694,
 "nic-mom",
 "Latn",
}
m["nbw"] = {
 "Southern Ngbandi",
 17522635,
 "nic-ngd",
 "Latn",
}
m["nby"] = {
 "Ningera",
 11732524,
 "paa-brd",
 "Latn",
}
m["nca"] = {
 "Iyo",
 6101336,
 "ngf-fin",
 "Latn",
}
m["ncb"] = {
 "Central Nicobarese",
 3335553,
 "aav-nic",
 "Deva, Latn",
}
m["ncc"] = {
 "Ponam",
 3396122,
 "poz-aay",
 "Latn",
}
m["ncd"] = {
 "Nachering",
 6957144,
 "sit-kic",
 "Deva",
}
m["nce"] = {
 "Yale",
 2992915,
 "paa", --kwomtari or isolate
 "Latn",
}
m["ncf"] = {
 "Notsi",
 3344784,
 "poz-ocw",
 "Latn",
}
m["ncg"] = {
 "Nisga'a",
 3342138,
 "nai-tsi",
 "Latn",
}
m["nch"] = {
 "Central Huasteca Nahuatl",
 2194290,
 "azc-nah",
 "Latn",
}
m["nci"] = {
 "Classical Nahuatl",
 559242,
 "azc-nah",
 "Latn",
 entry_name = {remove_diacritics = c.macron},
}
m["ncj"] = {
 "Northern Puebla Nahuatl",
 15705671,
 "azc-nah",
 "Latn",
}
m["nck"] = {
 "Nakara",
 6960662,
 "aus-arn",
 "Latn",
}
m["ncl"] = {
 "Michoacán Nahuatl",
 2896217,
 "azc-nah",
 "Latn",
}
m["ncm"] = {
 "Nambo",
 42173731,
 nil,
 "Latn",
}
m["ncn"] = {
 "Nauna",
 3337158,
 "poz-aay",
 "Latn",
}
m["nco"] = {
 "Sibe",
 56806,
 "paa-sbo",
 "Latn",
}
m["ncr"] = {
 "Ncane",
 11297920,
 "nic-bbe",
 "Latn",
 ancestors = "nhu",
}
m["ncs"] = {
 "Nicaraguan Sign Language",
 33765,
 "sgn",
 "Sgnw",
}
m["nct"] = {
 "Chothe Naga",
 5105385,
 "tbq-kuk",
 "Beng, Latn",
}
m["ncu"] = {
 "Chumburung",
 35198,
 "alv-gng",
 "Latn",
}
m["ncx"] = {
 "Central Puebla Nahuatl",
 5061727,
 "azc-nah",
 "Latn",
}
m["ncz"] = {
 "Natchez",
 3111838,
 nil,
 "Latn",
}
m["nda"] = {
 "Ndasa",
 35904,
 "bnt-kel",
 "Latn",
}
m["ndb"] = {
 "Kenswei Nsei",
 7067553,
 "nic-rnn",
 "Latn",
}
m["ndc"] = {
 "Ndau",
 13311,
 "bnt-sho",
 "Latn",
}
m["ndd"] = {
 "Nde-Nsele-Nta",
 36131,
 "nic-eko",
 "Latn",
}
m["ndf"] = {
 "Nadruvian",
 6957967,
 nil,
 "Latn",
}
m["ndg"] = {
 "Ndengereko",
 6983726,
 "bnt-mbi",
 "Latn",
}
m["ndh"] = {
 "Ndali",
 6983678,
 "bnt-run",
 "Latn",
}
m["ndi"] = {
 "Chamba Leko",
 36381,
 "alv-lek",
 "Latn",
}
m["ndj"] = {
 "Ndamba",
 6983684,
 "bnt-kil",
 "Latn",
}
m["ndk"] = {
 "Ndaka",
 11164947,
 "bnt-nya",
 "Latn",
}
m["ndl"] = {
 "Ndolo",
 6983788,
 "bnt-zbi",
 "Latn",
 ancestors = "lse",
}
m["ndm"] = {
 "Ndam",
 56283,
 "cdc-est",
 "Latn",
}
m["ndn"] = {
 "Ngundi",
 35916,
 "bnt-ngn",
 "Latn",
}
m["ndp"] = {
 "Ndo",
 6983774,
 "csu-mle",
 "Latn",
}
m["ndq"] = {
 "Ndombe",
 6983792,
 "bnt-swb",
 "Latn",
}
m["ndr"] = {
 "Ndoola",
 35837,
 "nic-mmb",
 "Latn",
}
m["nds"] = {
 "Low German",
 25433,
 "gmw",
 "Latn",
 ancestors = "gml",
}
m["ndt"] = {
 "Ndunga",
 6983857,
 "nic-mbc",
 "Latn",
}
m["ndu"] = {
 "Dugun",
 11015189,
 "alv-dur",
 "Latn",
}
m["ndv"] = {
 "Ndut",
 36028,
 "alv-cng",
 "Latn",
}
m["ndw"] = {
 "Ndobo",
 11008568,
 "bnt-ngn",
 "Latn",
}
m["ndx"] = {
 "Nduga",
 6983833,
 nil,
 "Latn",
}
m["ndy"] = {
 "Lutos",
 6705910,
 "csu-val",
 "Latn",
}
m["ndz"] = {
 "Ndogo",
 35983,
 "nic-ser",
 "Latn",
}
m["nea"] = {
 "Eastern Ngad'a",
 12473454,
 "poz-cet",
}
m["neb"] = {
 "Toura",
 7853636,
 "dmn-mda",
 "Latn",
}
m["nec"] = {
 "Nedebang",
 4925378,
 "ngf",
}
m["ned"] = {
 "Nde-Gbite",
 11010279,
 "nic-grf",
}
m["nee"] = {
 "Kumak",
 3347266,
 "poz-cln",
 "Latn",
}
m["nef"] = {
 "Nefamese",
 6987002,
 "crp",
}
m["neg"] = {
 "Negidal",
 33676,
 "tuw",
 "Cyrl",
}
m["neh"] = {
 "Nyenkha",
 3695185,
 "sit-ebo",
 "Tibt, Latn",
 translit = {Tibt = "Tibt-translit"},
 override_translit = true,
 display_text = {Tibt = s["Tibt-displaytext"]},
 entry_name = {Tibt = s["Tibt-entryname"]},
 sort_key = {Tibt = "Tibt-sortkey"},
}
m["nej"] = {
 "Neko",
 6989840,
 "ngf-fin",
 "Latn",
}
m["nek"] = {
 "Neku",
 14916900,
 "poz-cln",
}
m["nem"] = {
 "Nemi",
 3338008,
 "poz-cln",
 "Latn",
}
m["nen"] = {
 "Nengone",
 3338052,
 "poz-occ",
 "Latn",
}
m["neo"] = {
 "Ná-Meo",
 15977293,
 "hmn",
}
m["neq"] = {
 "North Central Mixe",
 25559729,
 nil,
 "Latn",
}
m["ner"] = {
 "Yahadian",
 8046778,
 nil,
 "Latn",
}
m["nes"] = {
 "Bhoti Kinnauri",
 21179921,
 "sit-las",
}
m["net"] = {
 "Nete",
 6998869,
 "paa-eng",
}
m["neu"] = {
 "Neo",
 606917,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["nev"] = {
 "Nyaheun",
 7070801,
 "mkh-ban",
}
m["new"] = {
 "Newar",
 33979,
 "sit-new",
 "Deva, Newa, Ranj",
 ancestors = "nwx",
 translit = {
  Deva = "new-translit",
  Newa = "new-Newa-translit",
 },
}
m["nex"] = {
 "Neme",
 12952941,
}
m["ney"] = {
 "Neyo",
 36410,
 "kro",
}
m["nez"] = {
 "Nez Perce",
 3339226,
 "nai-shp",
 "Latn",
}
m["nfa"] = {
 "Dhao",
 2053828,
 "poz",
}
m["nfd"] = {
 "Ahwai",
 3913957,
 "nic-plt",
 "Latn",
}
m["nfl"] = {
 "Aiwoo",
 56742,
 "poz-oce",
 "Latn",
}
m["nfr"] = {
 "Nafaanra",
 13297,
 "alv-snf",
 "Latn",
}
m["nfu"] = {
 "Mfumte",
 6826794,
 "nic-nka",
 "Latn",
}
m["nga"] = {
 "Ngbaka",
 36022,
 "alv-gbf",
 "Latn",
}
m["ngb"] = {
 "Northern Ngbandi",
 17522631,
 "nic-ngd",
 "Latn",
}
m["ngc"] = {
 "Ngombe (Congo)",
 3123524,
 "bnt-bun",
}
m["ngd"] = {
 "Ngando (Central African Republic)",
 35910,
 "bnt-ngn",
}
m["nge"] = {
 "Ngemba",
 6750551,
 "nic-nge",
 "Latn",
}
m["ngg"] = { -- compare 'aiy'
 "Ngbaka Manza",
 11033316,
 "alv-gbf",
 "Latn",
}
m["ngh"] = {
 "Nǀuu",
 2618974,
 "khi-tuu",
 "Latn",
}
m["ngi"] = {
 "Ngizim",
 3914924,
 "cdc-wst",
 "Latn",
}
m["ngj"] = {
 "Ngie",
 36361,
 "nic-mom",
 "Latn",
}
m["ngk"] = {
 "Ngalkbun",
 3913790,
 "aus-gun",
 "Latn",
}
m["ngl"] = {
 "Lomwe",
 35824,
 "bnt-mak",
 "Latn",
}
m["ngm"] = {
 "Ngatik Men's Creole",
 36400,
 "crp",
 ancestors = "en, pon",
}
m["ngn"] = {
 "Ngwo",
 36051,
 "nic-mom",
 "Latn",
}
m["ngo"] = {
 "Ngoni",
 7022547,
 "bnt-ngu",
 "Latn",
}
m["ngp"] = {
 "Ngulu",
 7193332,
 "bnt-seu",
 "Latn",
}
m["ngq"] = {
 "Ngoreme",
 7022573,
 "bnt-lok",
 "Latn",
}
m["ngr"] = {
 "Nagu",
 3063524,
 "poz-oce",
 "Latn",
}
m["ngs"] = {
 "Gvoko",
 3441188,
 "cdc-cbm",
 "Latn",
}
m["ngt"] = {
 "Ngeq",
 25559548,
 "mkh-kat",
}
m["ngu"] = {
 "Guerrero Nahuatl",
 5614980,
 "azc-nah",
 "Latn",
}
m["ngv"] = {
 "Nagumi",
 35842,
 "nic-jrn",
}
m["ngw"] = {
 "Ngwaba",
 3440480,
 "cdc-cbm",
 "Latn",
}
m["ngx"] = {
 "Nggwahyi",
 56265,
 "cdc-cbm",
 "Latn",
}
m["ngy"] = {
 "Tibea",
 36598,
 "bnt-baf",
 "Latn",
}
m["ngz"] = {
 "Ngungwel",
 35920,
 "bnt-tkc",
 "Latn",
}
m["nha"] = {
 "Nhanda",
 3339380,
 "aus-psw",
 "Latn",
}
m["nhb"] = {
 "Beng",
 3913311,
 "dmn-nbe",
 "Latn",
}
m["nhc"] = {
 "Tabasco Nahuatl",
 6047326,
 "azc-nah",
 "Latn",
}
m["nhd"] = {
 "Chiripá",
 2873230,
 "tup-gua",
 ancestors = "gn",
}
m["nhe"] = {
 "Eastern Huasteca Nahuatl",
 4358289,
 "azc-nah",
 "Latn",
}
m["nhf"] = {
 "Nhuwala",
 10600396,
 "aus-nga",
 "Latn",
}
m["nhg"] = {
 "Tetelcingo Nahuatl",
 3450252,
 "azc-nah",
 "Latn",
}
m["nhh"] = {
 "Nahari",
 6583560,
 "inc-eas",
 ancestors = "pra-mag",
}
m["nhi"] = {
 "Zacatlán-Ahuacatlán-Tepetzintla Nahuatl",
 12953764,
 "azc-nah",
 "Latn",
}
m["nhk"] = {
 "Cosoleacaque Nahuatl",
 12953757,
 "azc-nah",
 "Latn",
}
m["nhm"] = {
 "Morelos Nahuatl",
 4800819,
 "azc-nah",
 "Latn",
}
m["nhn"] = {
 "Central Nahuatl",
 6047309,
 "azc-nah",
 "Latn",
}
m["nho"] = {
 "Takuu",
 3409818,
 "poz-pnp",
 "Latn",
}
m["nhp"] = {
 "Pajapan Nahuatl",
 12953760,
 "azc-nah",
 "Latn",
}
m["nhq"] = {
 "Huaxcaleca Nahuatl",
 12953758,
 "azc-nah",
 "Latn",
}
m["nhr"] = {
 "Naro",
 2164778,
 "khi-kal",
 "Latn",
}
m["nht"] = {
 "Ometepec Nahuatl",
 7090132,
 "azc-nah",
 "Latn",
}
m["nhu"] = {
 "Noone",
 36072,
 "nic-bbe",
 "Latn",
}
m["nhv"] = {
 "Temascaltepec Nahuatl",
 2379405,
 "azc-nah",
 "Latn",
}
m["nhw"] = {
 "Western Huasteca Nahuatl",
 2678840,
 "azc-nah",
 "Latn",
}
m["nhx"] = {
 "Mecayapan Nahuatl",
 12953756,
 "azc-nah",
 "Latn",
}
m["nhy"] = {
 "Northern Oaxaca Nahuatl",
 12953763,
 "azc-nah",
 "Latn",
}
m["nhz"] = {
 "Santa María La Alta Nahuatl",
 15705753,
 "azc-nah",
 "Latn",
}
m["nia"] = {
 "Nias",
 2407831,
 "poz-nws",
 "Latn",
}
m["nib"] = {
 "Nakame",
 11732495,
 "ngf-fin",
 "Latn",
}
m["nid"] = {
 "Ngandi",
 7021977,
 "aus-arn",
 "Latn",
}
m["nie"] = {
 "Niellim",
 33662,
 "alv-bua",
}
m["nif"] = {
 "Nek",
 6989781,
 "ngf-fin",
 "Latn",
}
m["nig"] = {
 "Ngalakan",
 3913796,
 "aus-gun",
 "Latn",
}
m["nih"] = {
 "Nyiha",
 11128374,
 "bnt-mby",
 "Latn",
}
m["nii"] = {
 "Nii",
 35237,
 "ngf",
 "Latn",
}
m["nij"] = {
 "Ngaju",
 2992872,
 "poz-brw",
 "Latn",
}
m["nik"] = {
 "Southern Nicobarese",
 7570194,
 "aav-nic",
}
m["nil"] = {
 "Nila",
 7036821,
}
m["nim"] = {
 "Nilamba",
 4121200,
 "bnt-tkm",
 "Latn",
}
m["nin"] = {
 "Ninzo",
 3914021,
 "nic-nin",
}
m["nio"] = {
 "Nganasan",
 36743,
 "syd",
 "Cyrl",
}
m["niq"] = {
 "Nandi",
 6956591,
 "sdv-nma",
}
m["nir"] = {
 "Nimboran",
 301116,
 "paa-nim",
}
m["nis"] = {
 "Nimi",
 11732523,
 "ngf-fin",
 "Latn",
}
m["nit"] = {
 "Southeastern Kolami",
 56767,
 "dra",
 "Deva, Telu",
 translit = {
  Telu = "te-translit"
 },
}
m["niu"] = {
 "Niuean",
 33790,
 "poz-pol",
 "Latn",
}
m["niv"] = {
 "Nivkh",
 36464,
 "qfa-iso",
 "Cyrl",
 translit = "niv-translit",
 entry_name = {
  from = {"['’]"},
  to   = {"ʼ"}
 },
 sort_key = "niv-sortkey",
}
m["niw"] = {
 "Nimo",
 3504126,
 "paa-asa",
}
m["nix"] = {
 "Hema",
 5710904,
 "bnt-nyg",
 "Latn",
}
m["niy"] = {
 "Ngiti",
 7022396,
 "csu-lnd",
}
m["niz"] = {
 "Ningil",
 11732527,
 "qfa-tor",
}
m["nja"] = {
 "Nzanyi",
 3441299,
 "cdc-cbm",
 "Latn",
}
m["njb"] = {
 "Nocte Naga",
 7046410,
 "sit-tno",
}
m["njh"] = {
 "Lotha Naga",
 33590,
 "sit-aao",
}
m["nji"] = {
 "Gudanji",
 3915692,
 "aus-mir",
}
m["njj"] = {
 "Njen",
 36112,
 "nic-mom",
 "Latn",
}
m["njl"] = {
 "Njalgulgule",
 7071229,
 "sdv-daj",
}
m["njm"] = {
 "Angami",
 56761,
 "tbq-anp",
}
m["njn"] = {
 "Liangmai Naga",
 14194500,
 "sit-zem",
}
m["njo"] = {
 "Ao",
 28433,
 "sit-aao",
 "Latn",
}
m["njr"] = {
 "Njerep",
 35844,
 "nic-mmb",
 "Latn",
}
m["njs"] = {
 "Nisa",
 13593518,
 "paa-egb",
}
m["njt"] = {
 "Ndyuka-Trio Pidgin",
 13591205,
 "crp",
 ancestors = "djk, tri",
}
m["nju"] = {
 "Ngadjunmaya",
 7021846,
 "aus-pam",
}
m["njx"] = {
 "Kunyi",
 3196559,
 "bnt-kng",
 "Latn",
}
m["njy"] = {
 "Njyem",
 35898,
 "bnt-ndb",
 "Latn",
}
m["njz"] = {
 "Nyishi",
 56870,
 "sit-tan",
 "Latn",
}
m["nka"] = {
 "Nkoya",
 7042633,
 "bnt-lbn",
 "Latn",
}
m["nkb"] = {
 "Khoibu Naga",
 21481876,
 "sit-mar",
}
m["nkc"] = {
 "Nkongho",
 35863,
 "bnt-saw",
 "Latn",
}
m["nkd"] = {
 "Koireng",
 6426342,
 "sit-zem",
}
m["nke"] = {
 "Duke",
 3041075,
 "poz-ocw",
}
m["nkf"] = {
 "Inpui Naga",
 21481817,
 "sit-zem",
}
m["nkg"] = {
 "Nekgini",
 11732509,
 "ngf-fin",
 "Latn",
}
m["nkh"] = {
 "Khezha Naga",
 6401519,
 "tbq-anp",
}
m["nki"] = {
 "Thangal Naga",
 56374,
 "sit-zem",
}
m["nkj"] = {
 "Nakai",
 14916897,
 "ngf-okk",
 "Latn",
}
m["nkk"] = {
 "Nokuku",
 7048122,
 "poz-vnc",
}
m["nkm"] = {
 "Namat",
 15634505,
}
m["nkn"] = {
 "Nkangala",
 10962292,
 "bnt-clu",
 "Latn",
 ancestors = "mck",
}
m["nko"] = {
 "Nkonya",
 35867,
 "alv-gng",
 "Latn",
}
m["nkp"] = {
 "Niuatoputapu",
 3399095,
 "poz-pnp",
}
m["nkq"] = {
 "Nkami",
 7042522,
 "alv-gng",
 "Latn",
}
m["nkr"] = {
 "Nukuoro",
 2635961,
 "poz-pnp",
 "Latn",
}
m["nks"] = {
 "North Asmat",
 11732049,
}
m["nkt"] = {
 "Nyika",
 16917497,
 "bnt-mwi",
 "Latn",
}
m["nku"] = {
 "Bouna Kulango",
 20668241,
 "alv-kul",
}
-- nkv is treated as nkt, see WT:LT
m["nkw"] = {
 "Nkutu",
 7193313,
 "bnt-tet",
 "Latn",
}
m["nkx"] = {
 "Nkoroo",
 36000,
 "ijo",
}
m["nkz"] = {
 "Nkari",
 11130307,
 "nic-ief",
 ancestors = "ibr",
}
m["nla"] = {
 "Ngombale",
 36292,
 "bai",
 "Latn",
}
m["nlc"] = {
 "Nalca",
 6960839,
 "ngf",
 "Latn",
}
m["nle"] = {
 "East Nyala",
 25559347,
 "bnt-msl",
 "Latn",
 ancestors = "luy",
}
m["nlg"] = {
 "Gela",
 3063531,
 "poz-sls",
 "Latn",
}
m["nli"] = {
 "Grangali",
 3444203,
 "inc-dar",
}
m["nlj"] = {
 "Nyali",
 7070830,
 "bnt-nya",
 "Latn",
}
m["nlk"] = {
 "Ninia Yali",
 12953310,
}
m["nll"] = {
 "Nihali",
 33904,
 "qfa-iso",
 "Deva, Latn",
}
m["nlm"] = {
 "Mankiyali",
 47522426,
 "inc-dar",
}
m["nlo"] = {
 "Ngul",
 35894,
 "bnt-bdz",
 "Latn",
}
m["nlq"] = {
 "Lao Naga",
 63283609,
 "sit-tno",
}
m["nlu"] = {
 "Nchumbulu",
 36143,
 "alv-gng",
 "Latn",
}
m["nlv"] = {
 "Orizaba Nahuatl",
 3086050,
 "azc-nah",
 "Latn",
}
m["nlw"] = {
 "Walangama",
 7961277,
}
m["nlx"] = {
 "Nahali",
 33361,
 "inc-bhi",
}
m["nly"] = {
 "Nyamal",
 7070837,
 "aus-nga",
 "Latn",
}
m["nlz"] = {
 "Nalögo",
 20527138,
 "poz-oce",
}
m["nma"] = {
 "Maram Naga",
 56378,
 "sit-zem",
}
m["nmb"] = {
 "Big Nambas",
 2902304,
 "poz-vnc",
}
m["nmc"] = {
 "Ngam",
 3915446,
 "csu-sar",
 "Latn",
}
m["nmd"] = {
 "Ndumu",
 35901,
 "bnt-mbt",
 "Latn",
}
m["nme"] = {
 "Mzieme Naga",
 6949473,
 "sit-zem",
}
m["nmf"] = {
 "Tangkhul Naga",
 7682992,
 "sit-tng",
}
m["nmg"] = {
 "Kwasio",
 34098,
 "bnt-mnj",
 "Latn",
}
m["nmh"] = {
 "Monsang Naga",
 6902496,
}
m["nmi"] = {
 "Nyam",
 3438738,
 "cdc-wst",
 "Latn",
}
m["nmj"] = {
 "Ngombe (Central African Republic)",
 3913949,
 "alv-gbs",
}
m["nmk"] = {
 "Namakura",
 3335410,
 "poz-vnc",
}
m["nml"] = {
 "Ndemli",
 36089,
 "nic-grf",
 "Latn",
}
m["nmm"] = {
 "Manangba",
 6746900,
 "sit-tam",
 "Tibt, Deva",
 translit = {Tibt = "Tibt-translit"},
 override_translit = true,
 display_text = {Tibt = s["Tibt-displaytext"]},
 entry_name = {Tibt = s["Tibt-entryname"]},
 sort_key = {Tibt = "Tibt-sortkey"},
}
m["nmn"] = {
 "ǃXóõ",
 13229,
 "khi-tuu",
 "Latn",
}
m["nmo"] = {
 "Moyon Naga",
 6927748,
 "tbq-kuk",
}
m["nmp"] = {
 "Nimanbur",
 nil,
}
m["nmq"] = {
 "Nambya",
 11008869,
 "bnt-sho",
 "Latn",
}
m["nmr"] = {
 "Nimbari",
 36069,
 "alv-lni",
}
m["nms"] = {
 "Letemboi",
 3236886,
 "poz-vnc",
}
m["nmt"] = {
 "Namonuito",
 12908815,
 "poz-mic",
}
m["nmu"] = {
 "Northeast Maidu",
 3278074,
 "nai-mdu",
 "Latn",
}
m["nmv"] = {
 "Ngamini",
 7021944,
 "aus-kar",
 "Latn",
}
m["nmw"] = {
 "Nimoa",
 7037729,
 "poz-ocw",
}
m["nmy"] = {
 "Namuyi",
 56844,
 "sit-nax",
 "Latn",
}
m["nmz"] = {
 "Nawdm",
 36085,
 "nic-yon",
 "Latn",
}
m["nna"] = {
 "Nyangumarta",
 33653,
}
m["nnb"] = {
 "Nande",
 3196953,
 "bnt-glb",
 "Latn",
}
m["nnc"] = {
 "Nancere",
 3140491,
 "cdc-est",
 "Latn",
}
m["nnd"] = {
 "West Ambae",
 2841479,
 "poz-vnc",
 "Latn",
}
m["nne"] = {
 "Ngandyera",
 10961003,
 "bnt-ova",
 "Latn",
}
m["nnf"] = {
 "Ngaing",
 11732510,
 "ngf-fin",
 "Latn",
}
m["nng"] = {
 "Maring Naga",
 12952908,
 "sit-mar",
}
m["nnh"] = {
 "Ngiemboon",
 36286,
 "bai",
 "Latn",
}
m["nni"] = {
 "North Nuaulu",
 12952968,
 "poz-cma",
}
m["nnj"] = {
 "Nyangatom",
 4662604,
 "sdv-ttu",
}
m["nnk"] = {
 "Nankina",
 11732502,
 "ngf-fin",
 "Latn",
}
m["nnl"] = {
 "Northern Rengma Naga",
 7067615,
 "tbq-anp",
}
m["nnm"] = {
 "Namia",
 56363,
 "paa-spk",
 "Latn",
}
m["nnn"] = {
 "Ngete",
 56625,
 "cdc-mas",
 "Latn",
}
m["nnp"] = {
 "Wancho",
 7967085,
 "sit-kch",
 "Wcho, Deva, Latn",
}
m["nnq"] = {
 "Ngindo",
 7022366,
 "bnt-mbi",
 "Latn",
}
m["nnr"] = {
 "Narungga",
 13591127,
 "aus-pam",
}
m["nnt"] = {
 "Nanticoke",
 3915517,
 "alg-eas",
 "Latn",
}
m["nnu"] = {
 "Dwang",
 35258,
 "alv-gng",
 "Latn",
}
m["nnv"] = {
 "Nukunu",
 10604066,
}
m["nnw"] = {
 "Southern Nuni",
 11152248,
 "nic-gnn",
 "Latn",
}
m["nnx"] = {
 "Ngong",
 12952915,
}
m["nny"] = { -- contrast aus-ynk
 "Nyangga",
 10604331,
 "aus-tnk",
 "Latn",
}
m["nnz"] = {
 "Nda'nda'",
 36016,
 "bai",
 "Latn",
}
m["noa"] = {
 "Woun Meu",
 3111873,
 "sai-chc",
 "Latn",
}
m["noc"] = {
 "Nuk",
 11732534,
 "ngf-fin",
 "Latn",
}
m["nod"] = {
 "Northern Thai",
 565110,
 "tai-swe",
 "Lana, Thai",
 entry_name = {remove_diacritics = c.ZWNJ},
 sort_key = "nod-sortkey",
}
m["noe"] = {
 "Nimadi",
 3502294,
 "inc-wes",
 "Deva",
 ancestors = "raj",
 translit = "hi-translit",
}
m["nof"] = {
 "Nomane",
 11732531,
}
m["nog"] = {
 "Nogai",
 33871,
 "trk-kno",
 "Cyrl, Arab, Latn",
 translit = "nog-translit",
 override_translit = true,
}
m["noh"] = {
 "Nomu",
 11732532,
}
m["noi"] = {
 "Noiri",
 12953774,
 "inc-bhi",
}
m["noj"] = {
 "Nonuya",
 5372139,
 "sai-wit",
 "Latn",
}
m["nok"] = {
 "Nooksack",
 3343396,
}
m["nol"] = {
 "Nomlaki",
 3343229,
 "nai-wtq",
 "Latn",
}
m["nom"] = {
 "Nocamán",
 7046289,
 "sai-pan",
 "Latn",
}
m["non"] = {
 "Old Norse",
 35505,
 "gmq",
 "Latn, Runr",
 translit = {Runr = "Runr-translit"},
}
m["nop"] = {
 "Numanggang",
 7069052,
 "ngf-fin",
 "Latn",
}
m["noq"] = {
 "Ngongo",
 11057478,
 "bnt-yak",
 "Latn",
}
m["nos"] = {
 "Eastern Nisu",
 25559419,
 "tbq-lol",
}
m["not"] = {
 "Nomatsiguenga",
 3342992,
 "awd",
 "Latn",
}
m["nou"] = {
 "Ewage-Notu",
 5418860,
}
m["nov"] = {
 "Novial",
 36738,
 "art",
 "Latn",
 type = "appendix-constructed"
}
m["now"] = {
 "Nyambo",
 4967930,
 "bnt-haj",
 "Latn",
}
m["noy"] = {
 "Noy",
 36321,
 "alv-bua",
}
m["noz"] = {
 "Nayi",
 3183349,
 "omv-diz",
}
m["npa"] = {
 "Nar Phu",
 4926353,
 "sit-tam",
}
m["npb"] = {
 "Nupbikha",
 3695201,
 "sit-ebo",
}
m["npg"] = {
 "Ponyo",
 7228475,
 "sit-kch",
}
m["nph"] = {
 "Phom",
 7187109,
 "sit-kch",
}
m["npl"] = {
 "Southeastern Puebla Nahuatl",
 4632950,
 "azc-nah",
 "Latn",
}
m["npn"] = {
 "Mondropolon",
 3320594,
 "poz-aay",
}
m["npo"] = {
 "Pochuri Naga",
 7206342,
 "tbq-anp",
}
m["nps"] = {
 "Nipsan",
 11732528,
}
m["npu"] = {
 "Puimei Naga",
 7259044,
 "sit-zem",
}
m["npy"] = {
 "Napu",
 12953768,
}
m["nqg"] = {
 "Ede Nago",
 12952408,
 "alv-ede",
}
m["nqk"] = {
 "Kura Ede Nago",
 12952409,
 "alv-ede",
}
m["nql"] = {
 "Ngendelengo",
 63283693,
 "bnt-swb",
 "Latn",
}
m["nqm"] = {
 "Ndom",
 6983791,
 "ngf",
 "Latn",
}
m["nqn"] = {
 "Nen",
 20816352,
 "paa-yam",
}
m["nqo"] = {
 "N'Ko",
 18546266,
 "dmn-man",
 "Nkoo",
}
m["nqq"] = {
 "Kyan-Karyaw Naga",
 63283784,
 "sit-tno",
}
m["nqy"] = {
 "Akyaung Ari",
 4702035,
 "sit-tng",
}
m["nra"] = {
 "Ngom",
 36087,
 "bnt-kel",
 "Latn",
}
m["nrb"] = {
 "Nara",
 36179,
 "sdv-nes",
}
m["nrc"] = {
 "Noric",
 37023,
 "cel",
 "Ital",
}
m["nre"] = {
 "Southern Rengma Naga",
 7313205,
 "tbq-anp",
}
m["nrf"] = {
 "Norman",
 33850,
 "roa-oil",
 "Latn",
 wikimedia_codes = "nrm",
 ancestors = "frm",
 sort_key = s["roa-oil-sortkey"],
}
m["nrg"] = {
 "Narango",
 12952929,
 "poz-vnc",
}
m["nri"] = {
 "Chokri Naga",
 5104247,
 "tbq-anp",
}
m["nrk"] = {
 "Ngarla",
 3915860,
 "aus-nga",
 "Latn",
}
m["nrl"] = {
 "Ngarluma",
 7022078,
 "aus-nga",
 "Latn",
}
m["nrm"] = {
 "Narom",
 3336135,
 "poz-swa",
 "Latn",
}
m["nrn"] = {
 "Norn",
 36708,
 "gmq",
 "Latn",
 ancestors = "non",
}
m["nrp"] = {
 "North Picene",
 430138,
 nil,
 "Ital",
 translit = "Ital-translit",
}
m["nrr"] = {
 "Norra",
 12952967,
 "tai",
}
m["nrt"] = {
 "Northern Kalapuya",
 3192121,
 "nai-klp",
}
m["nru"] = {
 "Narua",
 21658869,
 "sit-nax",
 "Latn",
}
m["nrx"] = {
 "Ngurmbur",
 2591251,
}
m["nrz"] = {
 "Lala (New Guinea)",
 6480151,
 "poz-ocw",
}
m["nsa"] = {
 "Sangtam Naga",
 7418144,
 "sit-aao",
}
m["nsb"] = {
 "Lower Nossob",
 6693681,
 "khi-tuu",
 "Latn",
}
m["nsc"] = {
 "Nshi",
 11129508,
 "nic-rnn",
 "Latn",
}
m["nsd"] = {
 "Southern Nisu",
 nil,
 "tbq-lol",
}
m["nse"] = {
 "Nsenga",
 3081996,
 "bnt-sna",
 "Latn",
}
m["nsg"] = {
 "Ngasa",
 56345,
 "sdv-lma",
}
m["nsh"] = {
 "Ngoshie",
 7022582,
 "nic-mom",
 "Latn",
}
m["nsi"] = {
 "Nigerian Sign Language",
 7033021,
 "sgn",
}
m["nsk"] = {
 "Naskapi",
 1704302,
 "alg",
 "Cans",
 ancestors = "cr",
 translit = "nsk-translit",
}
m["nsl"] = {
 "Norwegian Sign Language",
 1781613,
 "sgn",
}
m["nsm"] = {
 "Sema",
 3478238,
 "tbq-anp",
}
m["nsn"] = {
 "Nehan",
 3337774,
 "poz-ocw",
}
m["nso"] = {
 "Northern Sotho",
 33890,
 "bnt-sts",
 "Latn",
}
m["nsp"] = {
 "Nepalese Sign Language",
 3915492,
 "sgn",
}
m["nsq"] = {
 "Northern Sierra Miwok",
 3344226,
 "nai-utn",
 "Latn",
}
m["nsr"] = {
 "Maritime Sign Language",
 3915483,
 "sgn",
}
m["nss"] = {
 "Nali",
 3335385,
 "poz-aay",
}
m["nst"] = {
 "Tangsa",
 56350,
 "sit-tno",
 "Latn, Tnsa",
}
m["nsu"] = {
 "Sierra Negra Nahuatl",
 nil,
 "azc-nah",
 "Latn",
}
m["nsv"] = {
 "Southwestern Nisu",
 nil,
 "tbq-lol",
}
m["nsw"] = {
 "Navut",
 3337327,
 "poz-vnc",
}
m["nsx"] = {
 "Nsongo",
 7067577,
 "bnt-tmb",
 "Latn",
}
m["nsy"] = {
 "Nasal",
 6966574,
}
m["nsz"] = {
 "Nisenan",
 33665,
 "nai-mdu",
 "Latn",
}
m["ntd"] = {
 "Northern Tidong",
 nil,
 "poz-san",
}
m["nte"] = {
 "Nathembo",
 11030947,
 "bnt-mak",
}
m["ntg"] = {
 "Ngantangarra",
 33060509,
}
m["nti"] = {
 "Natioro",
 36140,
 "alv-wan",
}
m["ntj"] = {
 "Ngaanyatjarra",
 3915409,
 "aus-pam",
 "Latn",
}
m["ntk"] = {
 "Ikoma",
 5996114,
 "bnt-lok",
 "Latn",
}
m["ntm"] = {
 "Nateni",
 3070731,
 "nic-grm",
 "Latn",
}
m["nto"] = {
 "Ntomba",
 11130292,
 "bnt-mon",
 "Latn",
}
m["ntp"] = {
 "Northern Tepehuan",
 15615651,
 "azc",
 "Latn",
 sort_key = {remove_diacritics = c.acute},
}
m["ntr"] = {
 "Delo",
 35195,
 "nic-gne",
 "Latn",
}
m["nts"] = {
 "Natagaimas",
 6967931,
}
m["ntu"] = {
 "Natügu",
 nil,
 "poz-oce",
}
m["ntw"] = {
 "Nottoway",
 3344791,
 "iro-nor",
}
m["ntx"] = {
 "Somra",
 7560536,
 "sit-tng",
}
m["nty"] = {
 "Mantsi",
 56878,
 "sit-mnz",
}
m["nua"] = {
 "Yuaga",
 3573088,
 "poz-cln",
 "Latn",
}
m["nuc"] = {
 "Nukuini",
 3346231,
}
m["nud"] = {
 "Ngala",
 7021893,
 "paa-spk",
 "Latn",
}
m["nue"] = {
 "Ngundu",
 12952953,
 "bad-cnt",
 "Latn",
}
m["nuf"] = {
 "Nusu",
 56413,
 "tbq-lol",
}
m["nug"] = {
 "Nungali",
 7069826,
 "aus-mir",
}
m["nuh"] = {
 "Ndunda",
 3913968,
 "nic-mmb",
 "Latn",
}
m["nui"] = {
 "Ngumbi",
 36459,
 "bnt-yko",
}
m["nuj"] = {
 "Nyole (Uganda)",
 3739448,
 "bnt-msl",
 "Latn",
}
m["nuk"] = {
 "Nootka",
 2992876,
 "wak",
 "Latn",
}
m["nul"] = {
 "Nusa Laut",
 7070332,
 "poz-cma",
}
m["num"] = {
 "Niuafo'ou",
 36173,
 "poz-pol",
 "Latn",
}
m["nun"] = {
 "Anong",
 2748232,
 "sit-nng",
}
m["nuo"] = {
 "Nguôn",
 3915785,
 "mkh-vie",
 "Latn",
 sort_key = "vi-sortkey",
}
m["nup"] = {
 "Nupe",
 36720,
 "alv-ngb",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.macron .. c.caron},
 sort_key = "nup-sortkey",
}
m["nuq"] = {
 "Nukumanu",
 12909019,
 "poz-pnp",
}
m["nur"] = {
 "Nuguria",
 7068910,
 "poz-pnp",
}
m["nus"] = {
 "Nuer",
 33675,
 "sdv-dnu",
 "Latn",
}
m["nut"] = {
 "Nung",
 72695,
 "tai",
 "Latn, Hani",
 sort_key = {Hani = "Hani-sortkey"},
}
m["nuu"] = {
 "Ngbundu",
 11126081,
 "bad",
 "Latn",
}
m["nuv"] = {
 "Northern Nuni",
 11016572,
 "nic-gnn",
 "Latn",
}
m["nuw"] = {
 "Nguluwan",
 6528643,
}
m["nux"] = {
 "Mehek",
 6809452,
 "paa-spk",
 "Latn",
}
m["nuy"] = {
 "Nunggubuyu",
 1747811,
 "aus-arn",
}
m["nuz"] = {
 "Tlamacazapa Nahuatl",
 2073277,
 "azc-nah",
 "Latn",
}
m["nvh"] = {
 "Nasarian",
 6966614,
 "poz-vnc",
}
m["nvm"] = {
 "Namiae",
 12952922,
}
m["nvo"] = {
 "Nyokon",
 nil,
 "nic-mbw",
 "Latn",
}
m["nwa"] = {
 "Nawathinehena",
 6982892,
 "alg-ara",
 "Latn",
}
m["nwb"] = {
 "Nyabwa",
 33664,
 "kro-wee",
}
m["nwc"] = {
 "Classical Newar",
 5128301,
 "sit-new",
}
m["nwe"] = {
 "Ngwe",
 36181,
 "bai",
 "Latn",
}
m["nwi"] = {
 "Southwest Tanna",
 3504488,
}
m["nwm"] = {
 "Nyamusa-Molo",
 12747951,
 "csu-bbk",
}
m["nwo"] = {
 "Nauo",
 6981305,
 "aus-pam",
 "Latn",
}
m["nwr"] = {
 "Nawaru",
 12638166,
 "ngf",
}
m["nwx"] = {
 "Middle Newar",
 nil,
 "sit-new",
 "Deva, Newa, Ranj",
 ancestors = "nwc",
}
m["nwy"] = {
 "Nottoway-Meherrin",
 nil,
 "iro-nor",
}
m["nxa"] = {
 "Nauete",
 6981095,
 "poz-tim",
}
m["nxd"] = {
 "Ngando (Congo)",
 3913277,
 "bnt-ske",
}
m["nxe"] = {
 "Nage",
 2295569,
 "poz-cet",
}
m["nxg"] = {
 "Ngadha",
 1516651,
 "poz-cet",
 "Latn",
}
m["nxi"] = {
 "Nindi",
 7038230,
 "bnt-mbi",
 "Latn",
}
m["nxl"] = {
 "South Nuaulu",
 18544857,
 "poz-cma",
}
m["nxm"] = {
 "Numidian",
 35761,
 "afa",
 "Tfng, Latn", --Tfng may not support all the needed characters
}
m["nxn"] = {
 "Ngawun",
 3915711,
 "aus-pam",
 "Latn",
}
m["nxo"] = {
 "Ndambomo",
 6983681,
 "bnt-kel",
 "Latn",
}
m["nxq"] = {
 "Naxi",
 2478711,
 "sit-nax",
 "Nkdb, Nkgb, Latn, Lisu",
}
m["nxr"] = {
 "Ninggerum",
 11732526,
 "ngf-okk",
 "Latn",
}
m["nxu"] = {
 "Narau",
 6965452,
 "ngf",
 "Latn",
}
m["nxx"] = {
 "Nafri",
 6958211,
 "paa-sen",
 "Latn",
}
m["nyb"] = {
 "Nyangbo",
 36256,
 "alv-ktg",
 "Latn",
}
m["nyc"] = {
 "Nyanga-li",
 7070876,
 "bnt-boa",
 "Latn",
}
m["nyd"] = {
 "Nyole (Kenya)",
 7071227,
 "bnt-msl",
 "Latn",
}
m["nye"] = {
 "Nyengo",
 7071068,
 "bnt-clu",
 "Latn",
}
m["nyf"] = {
 "Giryama",
 3107606,
 "bnt-mij",
 "Latn",
}
m["nyg"] = {
 "Nyindu",
 11030685,
 "bnt-shh",
 "Latn",
}
m["nyh"] = {
 "Nyigina",
 3913780,
 "aus-nyu",
 "Latn",
}
m["nyi"] = {
 "Nyimang",
 34846,
 "sdv-nyi",
 "Latn",
}
m["nyj"] = {
 "Nyanga (Congo)",
 7070879,
 "bnt-nyb",
 "Latn",
}
m["nyk"] = {
 "Nyaneka",
 10962298,
 "bnt-swb",
 "Latn",
}
m["nyl"] = {
 "Nyeu",
 3033578,
 "mkh-kat",
}
m["nym"] = {
 "Nyamwezi",
 4121131,
 "bnt-tkm",
 "Latn",
}
m["nyn"] = {
 "Nyankole",
 13207,
 "bnt-nyg",
 "Latn",
}
m["nyo"] = {
 "Nyoro",
 33794,
 "bnt-nyg",
 "Latn",
}
m["nyp"] = {
 "Nyang'i",
 7070894,
 "ssa-klk",
}
m["nys"] = {
 "Nyunga",
 7049771,
 "aus-pam",
 "Latn",
}
m["nyt"] = {
 "Nyawaygi",
 3915783,
 "aus-dyb",
}
m["nyu"] = {
 "Nyungwe",
 7071318,
 "bnt-sna",
 "Latn",
}
m["nyv"] = {
 "Nyulnyul",
 3442732,
 "aus-nyu",
 "Latn",
}
m["nyw"] = {
 "Nyaw",
 26425602,
 "tai",
 "Thai, Latn", -- Vietnamese alphabet
 sort_key = "Thai-sortkey", -- no effect on Latn
}
m["nyx"] = {
 "Nganyaywana",
 3913800,
 "aus-cww",
 "Latn",
}
m["nyy"] = {
 "Nyakyusa",
 3272620,
 "bnt-run",
 "Latn",
}
m["nza"] = {
 "Tigon Mbembe",
 36518,
 "nic-jkn",
 "Latn",
}
m["nzb"] = {
 "Njebi",
 35923,
 "bnt-nze",
 "Latn",
}
m["nzd"] = {
 "Nzadi",
 17152586,
 "bnt-bdz",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.caron},
}
m["nzi"] = {
 "Nzima",
 36337,
 "alv-ctn",
}
m["nzk"] = {
 "Nzakara",
 3913339,
 "znd",
 "Latn",
}
m["nzm"] = {
 "Zeme Naga",
 21491053,
 "sit-zem",
}
m["nzs"] = {
 "New Zealand Sign Language",
 36239,
 "sgn",
}
m["nzu"] = {
 "Central Teke",
 36473,
 "bnt-tkc",
}
m["nzy"] = {
 "Nzakambay",
 36374,
 "alv-mbm",
 "Latn",
}
m["nzz"] = {
 "Nanga Dama Dogon",
 6963443,
 "nic-nwa",
}
m["oaa"] = {
 "Orok",
 33928,
 "tuw",
 "Cyrl, Latn",
}
m["oac"] = {
 "Oroch",
 33650,
 "tuw",
 "Latn, Cyrl",
}
m["oav"] = {
 "Old Avar",
 nil,
 "cau-ava",
 "Geor",
}
m["obi"] = {
 "Obispeño",
 1288385,
 "nai-chu",
 "Latn",
}
m["obk"] = {
 "Southern Bontoc",
 nil,
 "phi",
 "Latn",
}
m["obl"] = {
 "Oblo",
 36309,
}
m["obm"] = {
 "Moabite",
 36385,
 "sem-can",
 "Phnx",
 translit = "Phnx-translit",
}
m["obo"] = {
 "Obo Manobo",
 12953699,
 "mno",
 "Latn",
}
m["obr"] = {
 "Old Burmese",
 17006600,
 "tbq-brm",
 "Mymr, Latn", --and also Pallava
}
m["obt"] = {
 "Old Breton",
 3558112,
 "cel-bry",
 "Latn",
}
m["obu"] = {
 "Obulom",
 3813403,
 "nic-cde",
 "Latn",
}
m["oca"] = {
 "Ocaina",
 3182577,
 "sai-wit",
 "Latn",
}
m["och"] = {
 "Old Chinese",
 35137,
 "zhx",
 "Hant",
 translit = "zh-translit",
 sort_key = "Hani-sortkey",
}
m["oco"] = {
 "Old Cornish",
 48304520,
 "cel-bry",
 "Latn",
}
m["ocu"] = {
 "Tlahuica",
 10751739,
 "omq",
 "Latn",
}
m["oda"] = {
 "Odut",
 3915388,
 "nic-uce",
 "Latn",
 ancestors = "mfn",
}
m["odk"] = {
 "Od",
 7077191,
 "inc-wes",
 "Arab",
}
m["odt"] = {
 "Old Dutch",
 443089,
 "gmw",
 "Latn, Runr",
 ancestors = "frk",
 entry_name = {remove_diacritics = c.circ .. c.macron},
}
m["odu"] = {
 "Odual",
 3813392,
 "nic-cde",
 "Latn",
}
m["ofo"] = {
 "Ofo",
 3349758,
 "sio-ohv",
}
m["ofs"] = {
 "Old Frisian",
 35133,
 "gmw-fri",
 "Latn",
 entry_name = {remove_diacritics = c.circ .. c.macron},
}
m["ofu"] = {
 "Efutop",
 35297,
 "nic-eko",
 "Latn",
}
m["ogb"] = {
 "Ogbia",
 3813400,
 "nic-cde",
 "Latn",
}
m["ogc"] = {
 "Ogbah",
 36291,
 "alv-igb",
 "Latn",
}
m["oge"] = {
 "Old Georgian",
 34834,
 "ccs-gzn",
 "Geor, Geok",
 translit = {
  Geor = "Geor-translit",
  Geok = "Geok-translit",
 },
 override_translit = true,
 entry_name = {remove_diacritics = c.circ},
}
m["ogg"] = {
 "Ogbogolo",
 3813405,
 "nic-cde",
 "Latn",
}
m["ogo"] = {
 "Khana",
 3914409,
 "nic-ogo",
 "Latn",
}
m["ogu"] = {
 "Ogbronuagum",
 3914485,
 "nic-cde",
 "Latn",
}
m["ohu"] = {
 "Old Hungarian",
 nil,
 "urj-ugr",
 "Latn",
}
m["oia"] = {
 "Oirata",
 56738,
 "ngf",
 "Latn",
}
m["oin"] = {
 "Inebu One",
 12953782,
 "qfa-tor",
}
m["ojb"] = {
 "Northwestern Ojibwa",
 7060356,
 "alg",
 "Latn",
 ancestors = "oj",
}
m["ojc"] = {
 "Central Ojibwa",
 5061548,
 "alg",
 "Latn",
 ancestors = "oj",
}
m["ojg"] = {
 "Eastern Ojibwa",
 5330342,
 "alg",
 "Latn",
 ancestors = "oj",
}
m["ojp"] = {
 "Old Japanese",
 5736700,
 "jpx",
 "Jpan",
 sort_key = s["Jpan-sortkey"],
}
m["ojs"] = {
 "Severn Ojibwa",
 56494,
 "alg",
 "Latn",
 ancestors = "oj",
}
m["ojv"] = {
 "Ontong Java",
 7095071,
 "poz-pnp",
 "Latn",
}
m["ojw"] = {
 "Western Ojibwa",
 3474222,
 "alg",
 "Latn",
 ancestors = "oj",
}
m["oka"] = {
 "Okanagan",
 2984602,
 "sal",
 "Latn",
}
m["okb"] = {
 "Okobo",
 3813398,
 "nic-lcr",
 "Latn",
}
m["okd"] = {
 "Okodia",
 36300,
 "ijo",
}
m["oke"] = {
 "Okpe (Southwestern Edo)",
 268924,
 "alv-swd",
 "Latn",
}
m["okg"] = {
 "Kok-Paponk",
 nil,
 "aus-pmn",
 "Latn",
}
m["okh"] = {
 "Koresh-e Rostam",
 6432160,
 "xme-ttc",
 ancestors = "xme-ttc-cen",
}
m["oki"] = {
 "Okiek",
 56367,
 "sdv-kln",
 "Latn",
}
m["okj"] = {
 "Oko-Juwoi",
 3436832,
 "qfa-adc",
}
m["okk"] = {
 "Kwamtim One",
 19830649,
 "qfa-tor",
 "Latn",
}
m["okl"] = {
 "Old Kentish Sign Language",
 7084319,
 "sgn",
}
m["okm"] = {
 "Middle Korean",
 715339,
 "qfa-kor",
 "Kore",
 ancestors = "oko",
 translit = "okm-translit",
 entry_name = s["Kore-entryname"],
}
m["okn"] = {
 "Oki-No-Erabu",
 3350036,
 "jpx-ryu",
 "Jpan",
 translit = s["Jpan-translit"],
 sort_key = s["Jpan-sortkey"],
}
m["oko"] = {
 "Old Korean",
 715364,
 "qfa-kor",
 "Kore",
 entry_name = s["Kore-entryname"],
}
m["okr"] = {
 "Kirike",
 11006763,
 "ijo",
}
m["oks"] = {
 "Oko-Eni-Osayen",
 36302,
 "alv-von",
 "Latn",
}
m["oku"] = {
 "Oku",
 36289,
 "nic-rnc",
 "Latn",
}
m["okv"] = {
 "Orokaiva",
 7103752,
 "ngf",
 "Latn",
}
m["okx"] = {
 "Okpe (Northwestern Edo)",
 7082547,
 "alv-nwd",
 "Latn",
}
m["okz"] = {
 "Old Khmer",
 9205,
 "mkh-kmr",
 "Latnx, Khmr", --and also Pallava
}
m["old"] = {
 "Mochi",
 12952852,
 "bnt-chg",
 "Latn",
}
m["ole"] = {
 "Olekha",
 3695204,
 "sit-bdi",
 "Tibt, Latn",
 translit = {Tibt = "Tibt-translit"},
 override_translit = true,
 display_text = {Tibt = s["Tibt-displaytext"]},
 entry_name = {Tibt = s["Tibt-entryname"]},
 sort_key = {Tibt = "Tibt-sortkey"},
}
m["olm"] = {
 "Oloma",
 3441166,
 "alv-nwd",
 "Latn",
}
m["olo"] = {
 "Livvi",
 36584,
 "urj-fin",
 "Latn",
}
m["olr"] = {
 "Olrat",
 3351562,
 "poz-vnc",
}
m["olt"] = {
 "Old Lithuanian",
 17417801,
 "bat",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.tilde},
}
m["olu"] = {
 "Kuvale",
 6448765,
 "bnt-swb",
 "Latn",
}
m["oma"] = {
 "Omaha-Ponca",
 2917968,
 "sio-dhe",
 "Latn",
}
m["omb"] = {
 "Omba",
 2841471,
 "poz-vnc",
 "Latn",
}
m["omc"] = {
 "Mochica",
 1951641,
}
m["omg"] = {
 "Omagua",
 33663,
 "tup-gua",
 "Latn",
}
m["omi"] = {
 "Omi",
 56795,
 "csu-mma",
}
m["omk"] = {
 "Omok",
 4334657,
 "qfa-yuk",
 "Cyrl",
 translit = "omk-translit",
}
m["oml"] = {
 "Ombo",
 7089928,
 "bnt-tet",
 "Latn",
}
m["omn"] = {
 "Minoan",
 1669994,
 nil,
 "Lina",
}
m["omo"] = {
 "Utarmbung",
 7902577,
 "ngf",
 "Latn",
}
m["omp"] = {
 "Old Manipuri",
 nil,
 "sit",
 "Mtei",
 translit = "Mtei-translit",
}
m["omr"] = {
 "Old Marathi",
 nil,
 "inc-sou",
 "Deva, Modi",
 ancestors = "pra-mah",
 translit = {
  Deva = "sa-translit",
  Modi = "Modi-translit",
 },
}
m["omt"] = {
 "Omotik",
 36313,
 "sdv-nis",
}
m["omu"] = {
 "Omurano",
 1957612,
}
m["omw"] = {
 "South Tairora",
 20210553,
 "paa-kag",
 "Latn",
}
m["omx"] = {
 "Old Mon",
 nil,
 "mkh-mnc",
 "Mymr, Latn", --and also Pallava
}
m["ona"] = {
 "Selk'nam",
 2721227,
 "sai-cho",
 "Latn",
}
m["onb"] = {
 "Lingao",
 7093790,
 "qfa-onb",
 "Latn",
}
m["one"] = {
 "Oneida",
 857858,
 "iro-nor",
 "Latn",
}
m["ong"] = {
 "Olo",
 592162,
 "qfa-tor",
 "Latn",
}
m["oni"] = {
 "Onin",
 7093910,
 "poz-cet",
 "Latn",
}
m["onj"] = {
 "Onjob",
 7093968,
 "ngf",
 "Latn",
}
m["onk"] = {
 "Kabore One",
 12953783,
 "qfa-tor",
 "Latn",
}
m["onn"] = {
 "Onobasulu",
 7094437,
 "ngf",
 "Latn",
}
m["ono"] = {
 "Onondaga",
 1077450,
 "iro-nor",
 "Latn",
 ancestors = "iro-oon",
}
m["onp"] = {
 "Sartang",
 7424639,
 "sit-khb",
}
m["onr"] = {
 "Northern One",
 19830648,
 "qfa-tor",
 "Latn",
}
m["ons"] = {
 "Ono",
 11732548,
 "ngf",
 "Latn",
}
m["ont"] = {
 "Ontenu",
 3352827,
}
m["onu"] = {
 "Unua",
 3552042,
 "poz-vnc",
 "Latn",
}
m["onw"] = {
 "Old Nubian",
 2268,
 "nub",
 "Copt",
 translit = "Copt-translit",
 sort_key = "cop-sortkey",
}
m["onx"] = {
 "Pidgin Onin",
 12953788,
 "crp",
 "Latn",
 ancestors = "oni",
}
m["ood"] = {
 "O'odham",
 2393095,
 "azc",
 "Latn",
}
m["oog"] = {
 "Ong",
 12953787,
 "mkh-kat",
}
m["oon"] = {
 "Önge",
 2475551,
 "qfa-ong",
}
m["oor"] = {
 "Oorlams",
 2484337,
}
m["oos"] = {
 "Old Ossetic",
 nil,
 "xsc",
 "Grek, Latn",
 translit = "grc-translit",
 ancestors = "os-pro",
}
m["opa"] = {
 "Okpamheri",
 3913331,
 "alv-nwd",
 "Latn",
}
m["opk"] = {
 "Kopkaka",
 6431129,
 "ngf-okk",
 "Latn",
}
m["opm"] = {
 "Oksapmin",
 1068097,
 "ngf",
 "Latn",
}
m["opo"] = {
 "Opao",
 7095585,
 "ngf",
 "Latn",
}
m["opt"] = {
 "Opata",
 2304583,
 "azc-trc",
 "Latn",
}
m["opy"] = {
 "Ofayé",
 3446691,
 "sai-mje",
 "Latn",
}
m["ora"] = {
 "Oroha",
 36298,
 "poz-sls",
}
m["ore"] = {
 "Orejón",
 3355834,
 "sai-tuc",
 "Latn",
}
m["org"] = {
 "Oring",
 3915308,
 "nic-ucn",
 "Latn",
}
m["orh"] = {
 "Oroqen",
 1367309,
 "tuw",
 "Latn",
}
m["oro"] = {
 "Orokolo",
 7103758,
 "ngf",
 "Latn",
}
m["orr"] = {
 "Oruma",
 36299,
 "ijo",
 "Latn",
}
m["ort"] = {
 "Adivasi Odia",
 12953791,
 "inc-eas",
 "Orya",
 ancestors = "or",
}
m["oru"] = {
 "Ormuri",
 33740,
 "ira-orp",
 "fa-Arab",
}
m["orv"] = {
 "Old East Slavic",
 35228,
 "zle",
 "Cyrs",
 translit = {Cyrs = "Cyrs-translit"},
 entry_name = s["Cyrs-entryname"],
 sort_key = { from = {"Ꙑ", "ꙑ"} ,  to =  { "ы" .. p[1], "ы" .. p[1],} },
}
m["orw"] = {
 "Oro Win",
 3450423,
 "sai-cpc",
 "Latn",
}
m["orx"] = {
 "Oro",
 3813396,
 "nic-lcr",
 "Latn",
}
m["orz"] = {
 "Ormu",
 7103494,
 "poz-ocw",
 "Latn",
}
m["osa"] = {
 "Osage",
 2600085,
 "sio-dhe",
 "Latn, Osge",
}
m["osc"] = {
 "Oscan",
 36653,
 "itc-sbl",
 "Ital, Latn",
 translit = "Ital-translit",
}
m["osi"] = {
 "Osing",
 2701322,
 "poz-sus",
 "Latn",
}
m["osn"] = {
 "Old Sundanese",
 56197074,
 "poz-msa",
 "Latn, Sund, Kawi",
}
m["oso"] = {
 "Ososo",
 3913398,
 "alv-yek",
 "Latn",
}
m["osp"] = {
 "Old Spanish",
 1088025,
 "roa-ibe",
 "Latn",
}
m["ost"] = {
 "Osatu",
 36243,
 "nic-grs",
 "Latn",
}
m["osu"] = {
 "Southern One",
 12953785,
 "qfa-tor",
 "Latn",
}
m["osx"] = {
 "Old Saxon",
 35219,
 "gmw",
 "Latn",
 entry_name = {remove_diacritics = c.circ .. c.macron},
}
m["ota"] = {
 "Ottoman Turkish",
 36730,
 "trk-ogz",
 "ota-Arab, Armn",
 ancestors = "trk-oat",
 entry_name = {remove_diacritics = c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun .. c.superalef},
 translit = {Armn = "ota-Armn-translit"},
}
m["otb"] = {
 "Old Tibetan",
 7085214,
 "sit-tib",
 "Tibt",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["otd"] = {
 "Ot Danum",
 3033781,
 "poz-brw",
 "Latn",
}
m["ote"] = {
 "Mezquital Otomi",
 23755711,
 "oto-otm",
 "Latn",
}
m["oti"] = {
 "Oti",
 3357881,
}
m["otk"] = {
 "Old Turkic",
 34988,
 "trk",
 "Orkh",
 translit = "Orkh-translit",
}
m["otl"] = {
 "Tilapa Otomi",
 7802050,
 "oto-otm",
 "Latn",
}
m["otm"] = {
 "Eastern Highland Otomi",
 13581718,
 "oto-otm",
 "Latn",
}
m["otn"] = {
 "Tenango Otomi",
 25559589,
 "oto-otm",
 "Latn",
}
m["otq"] = {
 "Querétaro Otomi",
 23755688,
 "oto-otm",
 "Latn",
}
m["otr"] = {
 "Otoro",
 36328,
 "alv-hei",
}
m["ots"] = {
 "Estado de México Otomi",
 7413841,
 "oto-otm",
 "Latn",
}
m["ott"] = {
 "Temoaya Otomi",
 7698191,
 "oto-otm",
 "Latn",
}
m["otu"] = {
 "Otuke",
 7110049,
 "sai-mje",
 "Latn",
}
m["otw"] = {
 "Ottawa",
 133678,
 "alg",
 "Latn",
 ancestors = "oj",
}
m["otx"] = {
 "Texcatepec Otomi",
 25559590,
 "oto-otm",
 "Latn",
}
m["oty"] = {
 "Old Tamil",
 20987452,
 "dra",
 "Brah",
 translit = "Brah-translit",
}
m["otz"] = {
 "Ixtenco Otomi",
 6101171,
 "oto-otm",
 "Latn",
}
m["oub"] = {
 "Glio-Oubi",
 3914977,
 "kro-grb",
}
m["oue"] = {
 "Oune",
 7110521,
 "paa-sbo",
}
m["oui"] = {
 "Old Uyghur",
 nil,
 "trk-sib",
 "Ougr, Latn, Brah, Mani, Syrc, Phag",
}
m["oum"] = {
 "Ouma",
 7110494,
 "poz-ocw",
 "Latn",
}
m["ovd"] = {
 "Elfdalian",
 254950,
 "gmq",
 "Latn",
 ancestors = "non",
}
m["owi"] = {
 "Owiniga",
 56454,
 "qfa-mal",
 "Latn",
}
m["owl"] = {
 "Old Welsh",
 2266723,
 "cel-bry",
 "Latn",
}
m["oyb"] = {
 "Oy",
 13593748,
 "mkh-ban",
}
m["oyd"] = {
 "Oyda",
 7116251,
 "omv-nom",
}
m["oym"] = {
 "Wayampi",
 7975842,
 "tup-gua",
 "Latn",
}
m["oyy"] = {
 "Oya'oya",
 7116243,
 "poz-ocw",
 "Latn",
}
m["ozm"] = {
 "Koonzime",
 35566,
 "bnt-ndb",
 "Latn",
}
m["pab"] = {
 "Pareci",
 3504312,
 "awd",
 "Latn",
}
m["pac"] = {
 "Pacoh",
 3441136,
 "mkh-kat",
 "Latn",
}
m["pad"] = {
 "Paumarí",
 389827,
 "auf",
 "Latn",
}
m["pae"] = {
 "Pagibete",
 7124357,
 "bnt-bta",
 "Latn",
}
m["paf"] = {
 "Paranawát",
 12953806,
 "tup-gua",
 "Latn",
}
m["pag"] = {
 "Pangasinan",
 33879,
 "phi",
 "Latn, Tglg",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.diaer},
}
m["pah"] = {
 "Tenharim",
 10266010,
 "tup-gua",
 "Latn",
}
m["pai"] = {
 "Pe",
 3914871,
 "nic-tar",
 "Latn",
}
m["pak"] = {
 "Parakanã",
 12953804,
 "tup-gua",
 "Latn",
}
m["pal"] = {
 "Middle Persian",
 32063,
 "ira-swi",
 "Latn, Phli, pal-Avst, Mani, Phlp, Phlv", -- Latn for translit; Phlv not in Unicode
 translit = {
  Phli = "Phli-translit",
  ["pal-Avst"] = "Avst-translit",
  Mani = "Mani-translit",
 },
 ancestors = "peo",
}
m["pam"] = {
 "Kapampangan",
 36121,
 "phi",
 "Latn", --also Kulitan, which lacks a code
 entry_name = {Latn = {remove_diacritics = c.grave .. c.acute .. c.circ}},
 standardChars = {
  Latn = "AaBbDdEeGgHhIiKkLlMmNnOoPpRrSsTtUuWwYy",
  c.punc
 },
 sort_key = {
  Latn = "tl-sortkey"
 },
}
m["pao"] = {
 "Northern Paiute",
 3360656,
 "azc-num",
 "Latn",
}
m["pap"] = {
 "Papiamentu",
 33856,
 "crp",
 "Latn",
 ancestors = "pt",
}
m["paq"] = {
 "Parya",
 1135134,
 "inc-cen",
 ancestors = "pra-sau",
}
m["par"] = {
 "Panamint",
 33926,
 "azc-num",
 "Latn",
}
m["pas"] = {
 "Papasena",
 7132508,
 "paa-lkp",
 "Latn",
}
m["pat"] = {
 "Papitalai",
 6528659,
 "poz-aay",
 "Latn",
}
m["pau"] = {
 "Palauan",
 33776,
 "poz-sus",
 "Latn",
}
m["pav"] = {
 "Wari'",
 3027909,
 "sai-cpc",
 "Latn",
}
m["paw"] = {
 "Pawnee",
 56751,
 "cdd",
 "Latn",
}
m["pax"] = {
 "Pankararé",
 25559779,
 nil,
 "Latn",
}
m["pay"] = {
 "Pech",
 4898889,
 "cba",
 "Latn",
}
m["paz"] = {
 "Pankararú",
 7131310,
 nil,
 "Latn",
}
m["pbb"] = {
 "Páez",
 33677,
 nil,
 "Latn",
}
m["pbc"] = {
 "Patamona",
 3915921,
 "sai-pem",
 "Latn",
}
m["pbe"] = {
 "Mezontla Popoloca",
 42365630,
 "omq-pop",
 "Latn",
}
m["pbf"] = {
 "Coyotepec Popoloca",
 5180100,
 "omq-pop",
 "Latn",
}
m["pbg"] = {
 "Paraujano",
 3501747,
 "awd-taa",
 "Latn",
}
m["pbh"] = {
 "Panare",
 56610,
 "sai-ven",
 "Latn",
}
m["pbi"] = {
 "Podoko",
 3515096,
 "cdc-cbm",
 "Latn",
}
m["pbl"] = {
 "Mak (Nigeria)",
 3915349,
 "alv-bwj",
 "Latn",
}
m["pbm"] = {
 "Puebla Mazatec",
 nil,
 "omq-maz",
 "Latn",
}
m["pbn"] = {
 "Kpasam",
 3914902,
 "alv-mye",
 "Latn",
}
m["pbo"] = {
 "Papel",
 36314,
 "alv-pap",
 "Latn",
}
m["pbp"] = {
 "Badyara",
 35095,
 "alv-ten",
 "Latn",
}
m["pbr"] = {
 "Pangwa",
 3847550,
 "bnt-bki",
 "Latn",
}
m["pbs"] = {
 "Central Pame",
 3361763,
 "omq",
 "Latn",
}
m["pbv"] = {
 "Pnar",
 3501850,
 "aav-pkl",
 "Latn",
}
m["pby"] = {
 "Pyu",
 2567925,
 "paa-asa",
 "Latn",
}
m["pca"] = {
 "Santa Inés Ahuatempan Popoloca",
 42365276,
 "omq-pop",
 "Latn",
}
m["pcb"] = {
 "Pear",
 6583669,
 "mkh-pea",
 "Khmr",
}
m["pcc"] = {
 "Bouyei",
 35100,
 "tai-nor",
 "Latn, Hani",
 sort_key = {Hani = "Hani-sortkey"},
}
m["pcd"] = {
 "Picard",
 34024,
 "roa-oil",
 "Latn",
 ancestors = "fro",
 sort_key = s["roa-oil-sortkey"],
}
m["pce"] = {
 "Ruching Palaung",
 12953798,
 "mkh-pal",
}
m["pcf"] = {
 "Paliyan",
 7127643,
 "dra",
}
m["pcg"] = {
 "Paniya",
 7131211,
 "dra",
}
m["pch"] = {
 "Pardhan",
 7133207,
 "dra",
 ancestors = "gon",
}
m["pci"] = {
 "Duruwa",
 56753,
 "dra",
 "Deva, Orya",
}
m["pcj"] = {
 "Parenga",
 3111396,
 "mun",
}
m["pck"] = {
 "Paite",
 12952337,
 "tbq-kuk",
}
m["pcl"] = {
 "Pardhi",
 7136554,
 "inc-bhi",
}
m["pcm"] = {
 "Nigerian Pidgin",
 33655,
 "crp",
 "Latn",
 ancestors = "en",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ .. c.caron .. c.macronbelow},
 sort_key = {
  remove_diacritics = c.tilde,
  from = {"ẹ", "gb", "kp", "ọ", "sh", "zh"},
  to = {"e" .. p[1], "g" .. p[1], "k" .. p[1], "o" .. p[1], "s" .. p[1], "z" .. p[1]}
 },
}
m["pcn"] = {
 "Piti",
 3913375,
 "nic-kne",
 "Latn",
}
m["pcp"] = {
 "Pacahuara",
 2591165,
 "sai-pan",
 "Latn",
}
m["pcw"] = {
 "Pyapun",
 3438807,
 nil,
 "Latn",
}
m["pda"] = {
 "Anam",
 3501930,
 "ngf-mad",
 "Latn",
}
m["pdc"] = {
 "Pennsylvania German",
 22711,
 "gmw",
 "Latn",
 ancestors = "gmw-rfr",
}
m["pdi"] = {
 "Pa Di",
 3359940,
 nil,
 "Latn",
}
m["pdn"] = {
 "Fedan",
 7206699,
 "poz-ocw",
 "Latn",
}
m["pdo"] = {
 "Padoe",
 3360370,
 "poz-btk",
 "Latn",
}
m["pdt"] = {
 "Plautdietsch",
 1751432,
 "gmw",
 "Latn",
 ancestors = "nds-de",
}
m["pdu"] = {
 "Kayan",
 7123283,
 "kar",
 "Latn",
}
m["pea"] = {
 "Peranakan Indonesian",
 653415,
 nil,
 "Latn",
}
m["peb"] = {
 "Eastern Pomo",
 3396032,
 "nai-pom",
 "Latn",
}
m["ped"] = {
 "Mala (New Guinea)",
 11732569,
 "ngf-mad",
 "Latn",
}
m["pee"] = {
 "Taje",
 12953902,
 nil,
 "Latn",
}
m["pef"] = {
 "Northeastern Pomo",
 3396018,
 "nai-pom",
 "Latn",
}
m["peg"] = {
 "Pengo",
 56758,
 "dra",
 "Orya",
 translit = "kxv-translit",
}
m["peh"] = {
 "Bonan",
 32983,
 "xgn-shr",
}
m["pei"] = {
 "Chichimeca-Jonaz",
 3915427,
 "omq-otp",
 "Latn",
}
m["pej"] = {
 "Northern Pomo",
 3396021,
 "nai-pom",
 "Latn",
}
m["pek"] = {
 "Penchal",
 3374631,
 "poz-aay",
 "Latn",
}
m["pel"] = {
 "Pekal",
 3241781,
 nil,
 "Latn",
}
m["pem"] = {
 "Phende",
 7162372,
 "bnt-pen",
 "Latn",
}
m["peo"] = {
 "Old Persian",
 35225,
 "ira-swi",
 "Xpeo, Latnx",
 translit = "peo-translit",
}
m["pep"] = {
 "Kunja",
 6444807,
 nil,
 "Latn",
}
m["peq"] = {
 "Southern Pomo",
 3396023,
 "nai-pom",
 "Latn",
}
-- "pes" IS TREATED AS "fa" (or as etymology-only), SEE WT:LT
m["pev"] = {
 "Pémono",
 3439012,
 "sai-map",
 "Latn",
}
m["pex"] = {
 "Petats",
 3376353,
 "poz-ocw",
 "Latn",
}
m["pey"] = {
 "Petjo",
 940486,
 nil,
 "Latn",
}
m["pez"] = {
 "Eastern Penan",
 18638342,
 "poz-swa",
 "Latn",
}
m["pfa"] = {
 "Pááfang",
 3063517,
 "poz-mic",
 "Latn",
}
m["pfe"] = {
 "Peere",
 36377,
 "alv-dur",
 "Latn",
}
m["pga"] = {
 "Juba Arabic",
 1262143,
 "crp",
 "Latn",
 ancestors = "apd",
}
m["pgd"] = {
 "Gandhari",
 nil,
 "inc-mid",
 "Deva, Khar",
 ancestors = "inc-ash",
 translit = "Khar-translit",
}
m["pgg"] = {
 "Pangwali",
 13600429,
 "him",
 "Deva, Takr",
 translit = "hi-translit",
}
m["pgi"] = {
 "Pagi",
 7124354,
 "paa-brd",
 "Latn",
}
m["pgk"] = {
 "Rerep",
 586907,
 "poz-vnc",
 "Latn",
}
m["pgl"] = {
 "Primitive Irish",
 3320030,
 "cel-gae",
 "Ogam",
 translit = "pgl-translit",
}
m["pgn"] = {
 "Paelignian",
 nil,
 "itc-sbl",
 "Latn",
}
m["pgs"] = {
 "Pangseng",
 3914027,
 "alv-mum",
 "Latn",
}
m["pgu"] = {
 "Pagu",
 7124462,
 "paa-nha",
 "Latn",
}
m["pgz"] = {
 "Papua New Guinean Sign Language",
 25044405,
 "sgn",
}
m["pha"] = {
 "Pa-Hng",
 2625410,
 "hmn",
}
m["phd"] = {
 "Phudagi",
 7188289,
}
m["phg"] = {
 "Phuong",
 7188376,
 "mkh-kat",
}
m["phh"] = {
 "Phukha",
 7188298,
 "tbq-lol",
}
m["phk"] = {
 "Phake",
 7675798,
 "tai-swe",
 "Mymr",
 translit = "aio-phk-translit",
 entry_name = {remove_diacritics = c.VS01},
}
m["phl"] = {
 "Phalura",
 2449549,
 "inc-dar",
 "Latn, ur-Arab",
}
m["phm"] = {
 "Phimbi",
 11007144,
 "bnt-sna",
 "Latn",
}
m["phn"] = {
 "Phoenician",
 36734,
 "sem-can",
 "Phnx",
 translit = "Phnx-translit",
}
m["pho"] = {
 "Phunoi",
 7188361,
 "tbq-lol",
}
m["phq"] = {
 "Phana'",
 7180427,
 "tbq-lol",
}
m["phr"] = {
 "Pahari-Potwari",
 33739,
 "inc-pan",
 "pa-Arab, Guru",
 ancestors = "lah",
 translit = {
  Guru = "Guru-translit",
  ["pa-Arab"] = "pa-Arab-translit",
 },
 entry_name = {
  ["pa-Arab"] = {
   remove_diacritics = c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun .. c.nunghunna,
   from = {"ݨ", "ࣇ"},
   to = {"ن", "ل"}
  },
 }
}
m["pht"] = {
 "Phu Thai",
 3626597,
 "tai-swe",
}
m["phu"] = {
 "Phuan",
 3915665,
}
m["phv"] = {
 "Pahlavani",
 7124567,
}
m["phw"] = {
 "Phangduwali",
 12953036,
 "sit-kie",
 ancestors = "ybh",
}
m["pia"] = {
 "Pima Bajo",
 3388544,
 "azc",
 "Latn",
}
m["pib"] = {
 "Yine",
 3135432,
 "awd",
 "Latn",
}
m["pic"] = {
 "Pinji",
 36296,
 "bnt-tso",
 "Latn",
}
m["pid"] = {
 "Piaroa",
 3382207,
 nil,
 "Latn",
}
m["pie"] = {
 "Piro",
 7198055,
 "nai-kta",
 "Latn",
}
m["pif"] = {
 "Pingelapese",
 36421,
 "poz-mic",
 "Latn",
}
m["pig"] = {
 "Pisabo",
 966883,
 "sai-pan",
 "Latn",
}
m["pih"] = {
 "Pitcairn-Norfolk",
 36554,
 "crp",
 "Latn",
 ancestors = "en",
}
m["pii"] = {
 "Pini",
 10631925,
}
m["pij"] = {
 "Pijao",
 7193519,
}
m["pil"] = {
 "Yom",
 36893,
 "nic-yon",
}
m["pim"] = {
 "Powhatan",
 2270532,
 "alg-eas",
 "Latn",
}
m["pin"] = {
 "Piame",
 7190042,
}
m["pio"] = {
 "Piapoco",
 3382208,
 "awd-nwk",
 "Latn",
}
m["pip"] = {
 "Pero",
 2411063,
 "cdc-wst",
}
m["pir"] = {
 "Piratapuyo",
 3389119,
 "sai-tuc",
 "Latn",
}
m["pis"] = {
 "Pijin",
 36699,
 "crp",
 "Latn",
 ancestors = "en",
}
m["pit"] = {
 "Pitta-Pitta",
 6433116,
 "aus-kar",
 "Latn",
}
m["piu"] = {
 "Pintupi-Luritja",
 2591175,
 "aus-pam",
}
m["piv"] = {
 "Pileni",
 2976736,
 "poz-pnp",
 "Latn",
}
m["piw"] = {
 "Pimbwe",
 3894132,
 "bnt-mwi",
}
m["pix"] = {
 "Piu",
 7199578,
}
m["piy"] = {
 "Piya-Kwonci",
 3440492,
}
m["piz"] = {
 "Pije",
 3388339,
 "poz-cln",
 "Latn",
}
m["pjt"] = {
 "Pitjantjatjara",
 2982063,
 "aus-pam",
 "pjt-Latn",
}
m["pkb"] = {
 "Kipfokomo",
 7208693,
 "bnt-sab",
 "Latn",
}
m["pkc"] = {
 "Baekje",
 4841264,
 "qfa-kor",
 "Hani, Kana",
 sort_key = {
  Hani = "Hani-sortkey",
  Kana = "Kana-sortkey"
 },
}
m["pkg"] = {
 "Pak-Tong",
 3360711,
}
m["pkh"] = {
 "Pankhu",
 7130962,
 "tbq-kuk",
}
m["pkn"] = {
 "Pakanha",
 954916,
 "aus-pmn",
}
m["pko"] = {
 "Pökoot",
 36323,
 "sdv-kln",
}
m["pkp"] = {
 "Pukapukan",
 36447,
 "poz-pnp",
 "Latn",
}
m["pkr"] = {
 "Attapady Kurumba",
 16835180,
 "dra",
}
m["pks"] = {
 "Pakistan Sign Language",
 22964057,
 "sgn",
}
m["pkt"] = {
 "Maleng",
 6583562,
 "mkh-vie",
}
m["pku"] = {
 "Paku",
 2932604,
}
m["pla"] = {
 "Miani",
 12952844,
 nil,
 "Latn",
}
m["plb"] = {
 "Polonombauk",
 7225957,
 "poz-vnc",
 "Latn",
}
m["plc"] = {
 "Central Palawano",
 12953795,
 "phi",
 "Latn",
}
m["ple"] = {
 "Palu'e",
 2196866,
 "poz-cet",
 "Latn",
}
m["plg"] = {
 "Pilagá",
 2748259,
 "sai-guc",
 "Latn",
}
m["plh"] = {
 "Paulohi",
 7155331,
 "poz-cma",
}
m["plj"] = {
 "Polci",
 3914383,
}
m["plk"] = {
 "Kohistani Shina",
 12953882,
 "inc-dar",
}
m["pll"] = {
 "Shwe Palaung",
 27941664,
 "mkh-pal",
}
m["pln"] = {
 "Palenquero",
 36665,
 "crp",
 "Latn",
 ancestors = "es",
}
m["plo"] = {
 "Oluta Popoluca",
 5908687,
 "nai-miz",
 "Latn",
}
m["plq"] = {
 "Palaic",
 36582,
 "ine-ana",
 "Xsux",
}
m["plr"] = {
 "Palaka Senoufo",
 36346,
 "alv-snf",
 "Latn",
}
m["pls"] = {
 "San Marcos Tlalcoyalco Popoloca",
 12641692,
 "omq-pop",
 "Latn",
}
m["plu"] = {
 "Palikur",
 3073448,
 "awd",
 "Latn",
}
m["plv"] = {
 "Southwest Palawano",
 15614922,
 "phi",
 "Latn",
}
m["plw"] = {
 "Brooke's Point Palawano",
 12953796,
 "phi",
 "Latn",
}
m["ply"] = {
 "Bolyu",
 3361723,
 "mkh-pkn",
 "Latn",
}
m["plz"] = {
 "Paluan",
 7128795,
 nil,
 "Latn",
}
m["pma"] = {
 "Paama",
 3130286,
 "poz-vnc",
 "Latn",
}
m["pmb"] = {
 "Pambia",
 36267,
 "znd",
 "Latn",
}
m["pmd"] = {
 "Pallanganmiddang",
 7127734,
 "aus-pam",
 "Latn",
}
m["pme"] = {
 "Pwaamei",
 3411152,
 "poz-cln",
 "Latn",
}
m["pmf"] = {
 "Pamona",
 3513320,
 "poz-kal",
 "Latn",
}
m["pmi"] = {
 "Northern Pumi",
 3403245,
 "sit-qia",
}
m["pmj"] = {
 "Southern Pumi",
 3403246,
 "sit-qia",
}
m["pmk"] = {
 "Pamlico",
 nil,
 "alg-eas",
 "Latn",
}
m["pml"] = {
 "Sabir",
 636479,
 "crp",
 "Latn",
 ancestors = "lij, pro, vec",
}
m["pmm"] = {
 "Pol",
 36408,
 "bnt-kak",
 "Latn",
}
m["pmn"] = {
 "Pam",
 7129017,
 "alv-mbm",
}
m["pmo"] = {
 "Pom",
 7227178,
 "poz-hce",
 "Latn",
}
m["pmq"] = {
 "Northern Pame",
 3361762,
 "omq",
 "Latn",
}
m["pmr"] = {
 "Paynamar",
 3450824,
}
m["pms"] = {
 "Piedmontese",
 15085,
 "roa-git",
 "Latn",
}
m["pmt"] = {
 "Tuamotuan",
 36763,
 "poz-pep",
 "Latn",
}
m["pmu"] = {
 "Mirpur Panjabi",
 6874480,
}
m["pmw"] = {
 "Plains Miwok",
 3391031,
 "nai-you",
 "Latn",
}
m["pmx"] = {
 "Poumei Naga",
 12952910,
 "tbq-anp",
}
m["pmy"] = {
 "Papuan Malay",
 12473446,
 nil,
 "Latn",
}
m["pmz"] = {
 "Southern Pame",
 3361765,
 "omq",
 "Latn",
}
m["pna"] = {
 "Punan Bah-Biau",
 4842201,
}
m["pnb"] = {
 "Western Panjabi",
 58635,
 "inc-pan",
 "pa-Arab",
 ancestors = "pa",
}
m["pnc"] = {
 "Pannei",
 7131391,
}
m["pnd"] = {
 "Mpinda",
 63308194,
 "bnt-kmb",
}
m["pne"] = {
 "Western Penan",
 12953808,
 "poz-swa",
 "Latn",
}
m["png"] = {
 "Pongu",
 36282,
 "nic-shi",
}
m["pnh"] = {
 "Penrhyn",
 3130301,
 "poz-pep",
 "Latn",
}
m["pni"] = {
 "Aoheng",
 4778608,
 "poz",
}
m["pnj"] = {
 "Pinjarup",
 33103591,
}
m["pnk"] = {
 "Paunaca",
 2064378,
 "awd",
 "Latn",
}
m["pnl"] = {
 "Paleni",
 7127118,
 "alv-wan",
 "Latn",
}
m["pnm"] = {
 "Punan Batu",
 7259892,
}
m["pnn"] = {
 "Pinai-Hagahai",
 5638511,
}
m["pno"] = {
 "Panobo",
 3141869,
 "sai-pan",
 "Latn",
}
m["pnp"] = {
 "Pancana",
 7130204,
}
m["pnq"] = {
 "Pana (West Africa)",
 7129739,
 "nic-gnn",
 "Latn",
}
m["pnr"] = {
 "Panim",
 11732562,
 "ngf-mad",
}
m["pns"] = {
 "Ponosakan",
 7227956,
 "phi",
}
m["pnt"] = {
 "Pontic Greek",
 36748,
 "grk",
 "Grek, Latn, Cyrl",
 ancestors = "gkm",
 translit = {Grek = "el-translit"},
 entry_name = {remove_diacritics = c.caron .. c.diaerbelow .. c.brevebelow},
 sort_key = s["Grek-sortkey"],
}
m["pnu"] = {
 "Jiongnai Bunu",
 56325,
 "hmn",
}
m["pnv"] = {
 "Pinigura",
 10631927,
 "aus-psw",
 "Latn",
}
m["pnw"] = {
 "Panyjima",
 3913830,
 "aus-nga",
 "Latn",
}
m["pnx"] = {
 "Phong-Kniang",
 3914627,
 "mkh",
}
m["pny"] = {
 "Pinyin",
 36250,
 "nic-nge",
 "Latn",
}
m["pnz"] = {
 "Pana (Central Africa)",
 36241,
 "alv-mbm",
 "Latn",
}
m["poc"] = {
 "Poqomam",
 36416,
 "myn",
 "Latn",
}
m["poe"] = {
 "San Juan Atzingo Popoloca",
 12953819,
 "omq-pop",
 "Latn",
}
m["pof"] = {
 "Poke",
 7208577,
 "bnt-ske",
}
m["pog"] = {
 "Potiguára",
 56722,
 "tup-gua",
 "Latn",
}
m["poh"] = {
 "Poqomchi'",
 36414,
 "myn",
 "Latn",
}
m["poi"] = {
 "Highland Popoluca",
 7511556,
 "nai-miz",
 "Latn",
}
m["pok"] = {
 "Pokangá",
 25559704,
 "sai-tuc",
 "Latn",
}
m["pom"] = {
 "Southeastern Pomo",
 3396025,
 "nai-pom",
 "Latn",
}
m["pon"] = {
 "Pohnpeian",
 28422,
 "poz-mic",
 "Latn",
}
m["poo"] = {
 "Central Pomo",
 3396020,
 "nai-pom",
 "Latn",
}
m["pop"] = {
 "Pwapwa",
 3411153,
 "poz-cln",
 "Latn",
}
m["poq"] = {
 "Texistepec Popoluca",
 5908707,
 "nai-miz",
 "Latn",
}
m["pos"] = {
 "Sayula Popoluca",
 5908722,
 "nai-miz",
 "Latn",
}
m["pot"] = {
 "Potawatomi",
 56749,
 "alg",
 "Latn",
}
m["pov"] = {
 "Guinea-Bissau Creole",
 33339,
 "crp",
 "Latn",
 ancestors = "pt",
}
m["pow"] = {
 "San Felipe Otlaltepec Popoloca",
 25559598,
 "omq-pop",
 "Latn",
}
m["pox"] = {
 "Polabian",
 36741,
 "zlw-lch",
 "Latn",
}
m["poy"] = {
 "Pogolo",
 2429648,
 "bnt-kil",
}
m["ppa"] = {
 "Pao",
 7132069,
}
m["ppe"] = {
 "Papi",
 7132809,
}
m["ppi"] = {
 "Paipai",
 56726,
 "nai-yuc",
 "Latn",
}
m["ppk"] = {
 "Uma",
 7881036,
 "poz-kal",
 "Latn",
}
m["ppl"] = {
 "Pipil",
 1186896,
 "azc-nah",
 "Latn",
 entry_name = {remove_diacritics = c.acute .. c.macron},
}
m["ppm"] = {
 "Papuma",
 7133239,
 "poz-hce",
 "Latn",
}
m["ppn"] = {
 "Papapana",
 3362757,
 "poz-ocw",
 "Latn",
}
m["ppo"] = {
 "Folopa",
 5464843,
 "paa",
 "Latn",
}
m["ppq"] = {
 "Pei",
 7160903,
}
m["pps"] = {
 "San Luís Temalacayuca Popoloca",
 25559602,
 "omq-pop",
 "Latn",
}
m["ppt"] = {
 "Pa",
 3504757,
 "ngf",
 "Latn",
}
m["ppu"] = {
 "Papora",
 2094884,
 "map",
 "Latn",
}
m["pqa"] = {
 "Pa'a",
 3441315,
 "cdc-wst",
}
m["pqm"] = {
 "Malecite-Passamaquoddy",
 3183144,
 "alg-eas",
 "Latn",
}
m["prc"] = {
 "Parachi",
 2640637,
 "ira-orp",
}
-- "prd" IS NOT INCLUDED, SEE WT:LT
m["pre"] = {
 "Principense",
 36520,
 "crp",
 "Latn",
 ancestors = "pt",
}
m["prf"] = {
 "Paranan",
 7135433,
 "phi",
}
m["prg"] = {
 "Old Prussian",
 35501,
 "bat",
 "Latn",
}
m["prh"] = {
 "Porohanon",
 6583710,
 "phi",
}
m["pri"] = {
 "Paicî",
 732131,
 "poz-cln",
 "Latn",
}
m["prk"] = {
 "Parauk",
 3363719,
 "mkh-pal",
}
m["prl"] = {
 "Peruvian Sign Language",
 3915508,
 "sgn",
}
m["prm"] = {
 "Kibiri",
 56745,
 "paa",
}
m["prn"] = {
 "Prasuni",
 32689,
 "nur-nor",
}
m["pro"] = {
 "Old Occitan",
 2779185,
 "roa-ocr",
 "Latn",
 sort_key = {remove_diacritics = c.cedilla},
}
-- "prp" IS NOT INCLUDED, SEE WT:LT
m["prq"] = {
 "Ashéninka Perené",
 3450601,
 "awd",
 "Latn",
}
m["prr"] = {
 "Puri",
 7261687,
}
-- "prs" IS TREATED AS "fa" (or as etymology-only), SEE WT:LT
m["prt"] = {
 "Phai",
 7180184,
 "mkh",
}
m["pru"] = {
 "Puragi",
 7260800,
 "ngf-sbh",
}
m["prw"] = {
 "Parawen",
 7136291,
 "ngf-mad",
}
m["prx"] = {
 "Purik",
 567905,
 "sit-lab",
}
m["prz"] = {
 "Providencia Sign Language",
 3322084,
 "sgn",
}
m["psa"] = {
 "Asue Awyu",
 11266334,
}
m["psc"] = {
 "Persian Sign Language",
 7170221,
 "sgn",
}
m["psd"] = {
 "Plains Indian Sign Language",
 2380124,
 "sgn",
}
m["pse"] = {
 "Central Malay",
 3367751,
 "poz-mly",
}
m["psg"] = {
 "Penang Sign Language",
 4924925,
 "sgn",
}
m["psh"] = {
 "Southwest Pashayi",
 16112270,
 "inc-dar",
}
m["psi"] = {
 "Southeast Pashayi",
 23713536,
 "inc-dar",
 "Arab",
}
m["psl"] = {
 "Puerto Rican Sign Language",
 7258608,
 "sgn-fsl",
}
m["psm"] = {
 "Pauserna",
 2912846,
 "tup-gua",
 "Latn",
}
m["psn"] = {
 "Panasuan",
 7130113,
 "poz",
}
m["pso"] = {
 "Polish Sign Language",
 3915194,
 "sgn-gsl",
}
m["psp"] = {
 "Philippine Sign Language",
 3551357,
 "sgn-fsl",
}
m["psq"] = {
 "Pasi",
 7142091,
}
m["psr"] = {
 "Portuguese Sign Language",
 3915472,
 "sgn",
}
m["pss"] = {
 "Kaulong",
 3194294,
 "poz-ocw",
}
m["psw"] = {
 "Port Sandwich",
 3398324,
 "poz-vnc",
 "Latn",
}
m["psy"] = {
 "Piscataway",
 3504233,
 "alg-eas",
}
m["pta"] = {
 "Pai Tavytera",
 7124619,
 "tup-gua",
 "Latn",
}
m["pth"] = {
 "Pataxó Hã-Ha-Hãe",
 7144304,
}
m["pti"] = {
 "Pintiini",
 10632026,
 "aus-pam",
}
m["ptn"] = {
 "Patani",
 7144242,
 "poz-hce",
 "Latn",
}
m["pto"] = {
 "Zo'é",
 8073148,
 "tup-gua",
 "Latn",
}
m["ptp"] = {
 "Patep",
 3368679,
 "poz-ocw",
 "Latn",
}
m["ptq"] = {
 "Pattapu",
 nil,
 "dra",
}
m["ptr"] = {
 "Piamatsina",
 7190040,
 "poz-vnc",
 "Latn",
}
m["ptt"] = {
 "Enrekang",
 12953520,
}
m["ptu"] = {
 "Bambam",
 4853321,
 "poz-ssw",
}
m["ptv"] = {
 "Port Vato",
 3398323,
 nil,
 "Latn",
}
m["ptw"] = {
 "Pentlatch",
 2069475,
}
m["pty"] = {
 "Pathiya",
 7144790,
 "dra",
}
m["pua"] = {
 "Purepecha",
 16114351,
 "qfa-iso",
 "Latn",
 sort_key = {remove_diacritics = c.acute},
}
m["pub"] = {
 "Purum",
 6400562,
 "tbq-kuk",
 "Latn",
}
m["puc"] = {
 "Punan Merap",
 7259895,
}
m["pud"] = {
 "Punan Aput",
 4782333,
}
m["pue"] = {
 "Puelche",
 33660,
}
m["puf"] = {
 "Punan Merah",
 7259894,
}
m["pug"] = {
 "Phuie",
 36375,
 "nic-gnw",
}
m["pui"] = {
 "Puinave",
 3027918,
}
m["puj"] = {
 "Punan Tubu",
 7259896,
 "poz-swa",
}
m["pum"] = {
 "Puma",
 33736,
 "sit-kic",
}
m["puo"] = {
 "Puoc",
 6440803,
 "mkh",
}
m["pup"] = {
 "Pulabu",
 7259163,
 "ngf-mad",
}
m["puq"] = {
 "Puquina",
 1207739,
}
m["pur"] = {
 "Puruborá",
 7261619,
 "tup",
}
m["put"] = {
 "Putoh",
 12953832,
 "poz-swa",
 "Latn",
}
m["puu"] = {
 "Punu",
 36401,
 "bnt-sir",
 "Latn",
}
m["puw"] = {
 "Puluwat",
 36397,
 "poz-mic",
 "Latn",
}
m["pux"] = {
 "Puare",
 3507983,
}
m["puy"] = {
 "Purisimeño",
 2967638,
 "nai-chu",
 "Latn",
}
m["pwa"] = {
 "Pawaia",
 7156099,
 "paa",
 "Latn",
}
m["pwb"] = {
 "Panawa",
 47385077,
 "nic-jer",
 "Latn",
 ancestors = "jer",
}
m["pwg"] = {
 "Gapapaiwa",
 3095245,
 "poz-ocw",
 "Latn",
}
m["pwi"] = {
 "Patwin",
 3370188,
 "nai-wtq",
 "Latn",
}
m["pwm"] = {
 "Molbog",
 6895718,
 "poz-san",
 "Latn",
}
m["pwn"] = {
 "Paiwan",
 715755,
 "map",
 "Latn",
}
m["pwo"] = {
 "Western Pwo",
 7988202,
 "kar",
 "Mymr",
}
m["pwr"] = {
 "Powari",
 12640277,
 "inc-hie",
 "Deva",
}
m["pww"] = {
 "Northern Pwo",
 7058885,
 "kar",
 "Thai",
}
m["pxm"] = {
 "Quetzaltepec Mixe",
 6842374,
 "nai-miz",
 "Latn",
}
m["pye"] = {
 "Pye Krumen",
 11157382,
 "kro-grb",
}
m["pym"] = {
 "Fyam",
 3914025,
 "nic-ple",
 "Latn",
}
m["pyn"] = {
 "Poyanáwa",
 3401023,
 "sai-pan",
}
m["pys"] = {
 "Paraguayan Sign Language",
 7134698,
 "sgn",
}
m["pyu"] = {
 "Puyuma",
 716690,
 "map",
 "Latn",
}
m["pyx"] = {
 "Tircul",
 36259,
 "sit",
}
m["pyy"] = {
 "Pyen",
 7262966,
 "tbq-lol",
}
m["pzh"] = {
 "Pazeh",
 36435,
 "map",
 "Latn",
}
m["pzn"] = {
 "Para Naga",
 7133667,
 "sit-aao",
}
m["qua"] = {
 "Quapaw",
 3412974,
 "sio-dhe",
 "Latn",
}
m["quc"] = {
 "K'iche'",
 36494,
 "myn",
 "Latn",
}
m["qui"] = {
 "Quileute",
 3414490,
 "chi",
 "Latn",
}
m["qum"] = {
 "Sipakapense",
 36589,
 "myn",
 "Latn",
}
m["qun"] = {
 "Quinault",
 3414522,
 "sal",
 "Latn",
}
m["quq"] = { -- should this continue to be considered separate language?
 "Quinqui",
 5908714,
 nil,
 "Latn",
}
m["quv"] = {
 "Sacapulteco",
 36412,
 "myn",
 "Latn",
}
m["qvy"] = {
 "Queyu",
 3414352,
 "sit-qia",
}
m["qwc"] = {
 "Classical Quechua",
 35882,
 "qwe",
 "Latn",
}
m["qwm"] = {
 "Kipchak",
 1199226,
 "trk-kip",
 "Latn, Armn, Arab",
 translit = {Armn = "Armn-translit"},
}
m["qwt"] = {
 "Kwalhioqua-Tlatskanai",
 20641,
 "ath-nor",
 "Latn",
}
m["qxs"] = {
 "Southern Qiang",
 56563,
 "sit-qia",
 "Latn",
}
m["qya"] = {
 "Quenya",
 56383,
 "art",
 "Latn, Teng",
 type = "appendix-constructed",
}
m["qyp"] = {
 "Quiripi",
 3414714,
 "alg-eas",
 "Latn",
}
m["raa"] = {
 "Dungmali",
 56871,
 "sit-kic",
}
m["rab"] = {
 "Chamling",
 3436664,
 "sit-kic",
 "Deva",
}
m["rac"] = {
 "Rasawa",
 56443,
 "paa-lkp",
 "Latn",
}
m["rad"] = {
 "Rade",
 3429088,
 "cmc",
 "Latn",
}
m["raf"] = {
 "Western Meohang",
 17442461,
 "sit-kie",
}
m["rag"] = {
 "Logooli",
 6667767,
 "bnt-lok",
 "Latn",
}
m["rah"] = {
 "Rabha",
 7278686,
 "tbq-bdg",
 "Beng, Latn",
}
m["rai"] = {
 "Ramoaaina",
 3418509,
 "poz-ocw",
 "Latn",
}
m["raj"] = {
 "Rajasthani",
 13196,
 "inc-wes",
 "Deva",
 ancestors = "inc-ogu",
}
m["rak"] = {
 "Tulu-Bohuai",
 2908807,
 "poz-aay",
 "Latn",
}
m["ral"] = {
 "Ralte",
 7288392,
 "tbq-kuk",
 "Latn",
}
m["ram"] = {
 "Canela",
 2936334,
 "sai-nje",
 "Latn",
}
m["ran"] = {
 "Riantana",
 7322169,
 "ngf",
 "Latn",
}
m["rao"] = {
 "Rao",
 11732596,
 "paa",
 "Latn",
}
m["rap"] = {
 "Rapa Nui",
 36746,
 "poz-pep",
 "Latn",
}
m["raq"] = {
 "Saam",
 7395644,
 "sit-kic",
}
m["rar"] = {
 "Rarotongan",
 36745,
 "poz-pep",
 "Latn",
}
m["ras"] = {
 "Tegali",
 36522,
 "nic-ras",
 "Latn",
}
m["rat"] = {
 "Razajerdi",
 7299461,
 "xme-ttc",
 ancestors = "xme-ttc-eas",
}
m["rau"] = {
 "Raute",
 7296262,
 "sit-gma",
 "Deva, Latn",
}
m["rav"] = {
 "Sampang",
 3449115,
 "sit-kic",
}
m["raw"] = {
 "Rawang",
 542564,
 "sit-nng",
 "Latn",
 sort_key = {remove_diacritics = c.grave .. c.acute .. c.macron},
}
m["rax"] = {
 "Rang",
 3913345,
 "alv-mum",
}
m["ray"] = {
 "Rapa",
 36417,
 "poz-pep",
}
m["raz"] = {
 "Rahambuu",
 3417555,
 "poz-btk",
}
m["rbb"] = {
 "Rumai Palaung",
 12953797,
 "mkh-pal",
}
m["rbk"] = {
 "Northern Bontoc",
 nil,
 "phi",
}
m["rbl"] = {
 "Miraya Bikol",
 18664557,
 "phi",
}
m["rcf"] = {
 "Réunion Creole French",
 13198,
 "crp",
 "Latn",
 ancestors = "fr",
 sort_key = s["roa-oil-sortkey"],
}
m["rdb"] = {
 "Rudbari",
 12953072,
 "xme",
 ancestors = "xme-mid",
}
m["rea"] = {
 "Rerau",
 7314883,
 "ngf-mad",
}
m["reb"] = {
 "Rembong",
 7311570,
 "poz-cet",
}
m["ree"] = {
 "Rejang Kayan",
 3423957,
 "poz",
}
m["reg"] = {
 "Kara (Tanzania)",
 6367567,
 "bnt-haj",
}
m["rei"] = {
 "Reli",
 7310982,
}
m["rej"] = {
 "Rejang",
 3056339,
 "poz-sus",
 "Rjng",
}
m["rel"] = {
 "Rendille",
 3447297,
 "cus-som",
}
m["rem"] = {
 "Remo",
 3501825,
 "sai-pan",
 "Latn",
}
m["ren"] = {
 "Rengao",
 6583692,
 "mkh",
}
m["rer"] = {
 "Rer Bare",
 12953857,
}
m["res"] = {
 "Reshe",
 36258,
 "nic-knj",
}
m["ret"] = {
 "Retta",
 7317113,
 "ngf",
}
m["rey"] = {
 "Reyesano",
 3111857,
 "sai-tac",
 "Latn",
}
m["rga"] = {
 "Roria",
 7366825,
 "poz-vnc",
}
m["rge"] = {
 "Romani Greek",
 3915435,
}
m["rgk"] = {
 "Rangkas",
 7292645,
 "sit-alm",
}
m["rgn"] = {
 "Romagnol",
 1641543,
 "roa-git",
 "Latn",
 wikimedia_codes = "eml",
}
m["rgr"] = {
 "Resígaro",
 3450504,
 "awd",
 "Latn",
}
m["rgs"] = {
 "Southern Roglai",
 12953069,
}
m["rgu"] = {
 "Ringgou",
 7334886,
 "poz-tim",
}
m["rhg"] = {
 "Rohingya",
 3241177,
 "inc-eas",
 "Rohg, Arab, Mymr, Latn, Beng",
 ancestors = "inc-obn",
 translit = {Rohg = "Rohg-translit"},
}
m["rhp"] = {
 "Yahang",
 8046792,
 "qfa-tor",
}
m["ria"] = {
 "Reang",
 12953063,
 "tbq-bdg",
}
m["rif"] = {
 "Tarifit",
 34174,
 "ber",
 "Latn, Tfng, Arab",
 translit = { Tfng = "Tfng-translit" },
 standardChars = "AaBbCcDdḌḍEeƐɛFfGgƔɣĞğHhḤḥIiJjKkLlMmNnPpQqRrŘřSsṢṣTtṬṭUuWwXxYyZzẒẓʷ" .. c.punc,
}
m["ril"] = {
 "Riang",
 2741615,
 "mkh-pal",
}
m["rim"] = {
 "Nyaturu",
 7193418,
 "bnt-tkm",
 "Latn",
}
m["rin"] = {
 "Nungu",
 3913350,
 "nic-nin",
 "Latn",
}
m["rir"] = {
 "Ribun",
 7322443,
 "day",
 "Latn",
}
m["rit"] = {
 "Ritarungo",
 7336730,
 "aus-yol",
 "Latn",
}
m["riu"] = {
 "Riung",
 7336938,
 "poz-cet",
 "Latn",
}
m["rjg"] = {
 "Rajong",
 7286370,
 "poz-cet",
 "Latn",
}
m["rji"] = {
 "Raji",
 7286138,
 "sit-gma",
}
m["rjs"] = {
 "Rajbanshi",
 12640969,
 "inc-eas",
 "Deva, as-Beng",
 ancestors = "pra-mag",
}
m["rka"] = {
 "Kraol",
 3199593,
 "mkh-ban",
 "Khmr", -- also Latn?
}
m["rkb"] = {
 "Rikbaktsa",
 2585357,
 "sai-mje",
 "Latn",
}
m["rkh"] = {
 "Rakahanga-Manihiki",
 3119695,
 "poz-pep",
 "Latn",
}
m["rki"] = {
 "Rakhine",
 3450749,
 "tbq-brm",
 "Mymr",
 ancestors = "obr",
}
m["rkm"] = {
 "Marka",
 36030,
 "dmn-wmn",
 "Latn",
}
m["rkt"] = {
 "Kamta",
 3241618,
 "inc-eas",
 "as-Beng",
 ancestors = "inc-ork",
 translit = "as-translit",
}
m["rkw"] = {
 "Arakwal",
 34295800,
 "aus-pam",
 "Latn",
}
m["rma"] = {
 "Rama",
 3444486,
 "cba",
}
m["rmb"] = {
 "Rembarunga",
 7311553,
 "aus-gun",
 "Latn",
}
m["rmc"] = {
 "Carpathian Romani",
 5045611,
 "inc-rom",
}
m["rmd"] = {
 "Traveller Danish",
 12640779,
 "inc-rom",
}
m["rme"] = {
 "Angloromani",
 541279,
 "crp",
 "Latn",
 ancestors = "en, rom",
}
m["rmf"] = {
 "Kalo Finnish Romani",
 2093214,
 "inc-rom",
}
m["rmg"] = {
 "Traveller Norwegian",
 3177352,
 "inc-rom",
}
m["rmh"] = {
 "Murkim",
 4308074,
 "paa-pau",
}
m["rmi"] = {
 "Lomavren",
 2495696,
 "qfa-mix",
 "Latn, Armn",
 ancestors = "pra-sau, hy",
 translit = {Armn = "Armn-translit"},
 override_translit = true,
}
m["rmk"] = {
 "Romkun",
 7363236,
 "paa",
 "Latn",
}
m["rml"] = {
 "Baltic Romani",
 513736,
 "inc-rom",
}
m["rmm"] = {
 "Roma",
 4414831,
}
m["rmn"] = {
 "Balkan Romani",
 1256701,
 "inc-rom",
}
m["rmo"] = {
 "Sinte Romani",
 1793299,
 "qfa-mix",
 "Latn",
 ancestors = "rom",
}
m["rmp"] = {
 "Rempi",
 7312214,
 "ngf-mad",
}
m["rmq"] = {
 "Caló",
 35466,
 "qfa-mix",
 "Latn",
 ancestors = "rom, osp, roa-opt",
}
m["rms"] = {
 "Romanian Sign Language",
 7362575,
 "sgn",
}
m["rmt"] = {
 "Domari",
 35394,
 "inc-cen",
 ancestors = "pra-sau",
}
m["rmu"] = {
 "Tavringer Romani",
 27808413,
 "inc-rom",
}
m["rmv"] = {
 "Romanova",
 1298715,
 "art",
 type = "appendix-constructed",
}
m["rmw"] = {
 "Welsh Romani",
 2097387,
 "inc-rom",
}
m["rmx"] = {
 "Romam",
 22694600,
 "mkh",
}
m["rmy"] = {
 "Vlax Romani",
 2669199,
 "inc-rom",
}
m["rmz"] = {
 "Marma",
 21403256,
 "tbq-brm",
 "Mymr",
 ancestors = "obr",
}
m["rnd"] = {
 "Ruwund",
 7383564,
 "bnt-lun",
}
m["rng"] = {
 "Ronga",
 2520717,
 "bnt-tsr",
 "Latn",
}
m["rnl"] = {
 "Ranglong",
 7292878,
}
m["rnn"] = {
 "Roon",
 7366335,
 "poz-hce",
}
m["rnp"] = {
 "Rongpo",
 7365672,
 "sit-whm",
}
m["rnw"] = {
 "Rungwa",
 7379873,
 "bnt-mwi",
 "Latn",
}
m["rob"] = {
 "Tae'",
 12473476,
 "poz-ssw",
 "Latn",
}
m["roc"] = {
 "Cacgia Roglai",
 2932485,
}
m["rod"] = {
 "Rogo",
 3914894,
 "nic-kmk",
}
m["roe"] = {
 "Ronji",
 3441763,
 "poz-ocw",
}
m["rof"] = {
 "Rombo",
 33330,
 "bnt-chg",
 "Latn",
}
m["rog"] = {
 "Northern Roglai",
 3439680,
 "cmc",
 "Latn",
}
m["rol"] = {
 "Romblomanon",
 13202,
 "phi",
}
m["rom"] = {
 "Romani",
 13201,
 "inc-rom",
 "Latn, Cyrl",
 ancestors = "pra-sau",
}
m["roo"] = {
 "Rotokas",
 13203,
 "paa-nbo",
 "Latn",
}
m["rop"] = {
 "Kriol",
 35671,
 "crp",
 "Latn",
 ancestors = "en",
}
m["ror"] = {
 "Rongga",
 12473464,
}
m["rou"] = {
 "Runga",
 56793,
}
m["row"] = {
 "Dela-Oenale",
 5253046,
 "poz-tim",
}
m["rpn"] = {
 "Repanbitip",
 7313900,
 "poz-vnc",
}
m["rpt"] = {
 "Rapting",
 7294362,
 "ngf-mad",
}
m["rri"] = {
 "Ririo",
 2404190,
 "poz-ocw",
}
m["rro"] = {
 "Roro",
 34197,
 "poz-ocw",
 "Latn",
}
m["rrt"] = {
 "Arritinngithigh",
 4796002,
 nil,
 "Latn",
}
m["rsb"] = {
 "Romano-Serbian",
 1268244,
}
m["rsl"] = {
 "Russian Sign Language",
 13210,
 "sgn",
}
m["rsm"] = {
 "Miriwoong Sign Language",
 24090240,
 "sgn",
}
m["rtc"] = {
 "Rungtu",
 7379867,
 "tbq-kuk",
}
m["rth"] = {
 "Ratahan",
 3420026,
 "phi",
 "Latn",
}
m["rtm"] = {
 "Rotuman",
 36754,
 "poz-occ",
 "Latn",
}
m["rtw"] = {
 "Rathawi",
 12953854,
 "inc-bhi",
}
m["rub"] = {
 "Gungu",
 11165235,
 "bnt-glb",
}
m["ruc"] = {
 "Ruuli",
 7383562,
 "bnt-nyg",
}
m["rue"] = {
 "Rusyn",
 26245,
 "zle",
 "Cyrl",
 ancestors = "zle-ort",
 translit = "rue-translit",
 entry_name = {remove_diacritics = c.grave .. c.acute},
 sort_key = "rue-sortkey",
}
m["ruf"] = {
 "Luguru",
 3437661,
 "bnt-ruv",
 "Latn",
}
m["rug"] = {
 "Roviana",
 3445546,
 "poz-ocw",
 "Latn",
}
m["ruh"] = {
 "Ruga",
 7378127,
}
m["rui"] = {
 "Rufiji",
 7377946,
 "bnt-mbi",
}
m["ruk"] = {
 "Che",
 3915445,
 "nic-nin",
}
m["ruo"] = {
 "Istro-Romanian",
 33622,
 "roa-eas",
 "Latn",
}
m["rup"] = {
 "Aromanian",
 29316,
 "roa-eas",
 "Latn, Grek",
 wikimedia_codes = "roa-rup",
}
m["ruq"] = {
 "Megleno-Romanian",
 13358,
 "roa-eas",
 "Latn",
}
m["rut"] = {
 "Rutul",
 36757,
 "cau-wsm",
 "Cyrl, Latn",
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
}
m["ruu"] = {
 "Lanas Lobu",
 12953676,
}
m["ruy"] = {
 "Mala (Nigeria)",
 3913381,
 "nic-kau",
}
m["ruz"] = {
 "Ruma",
 3913326,
 "nic-kau",
}
m["rwa"] = {
 "Rawo",
 3504269,
}
m["rwk"] = {
 "Rwa",
 7985624,
 "bnt-chg",
}
m["rwm"] = {
 "Amba",
 788423,
 "bnt-kbi",
 "Latn",
}
m["rwo"] = {
 "Rawa",
 11732598,
 "ngf-fin",
 "Latn",
}
m["rxd"] = {
 "Ngardi",
 7022063,
}
m["rxw"] = {
 "Karuwali",
 6881575,
}
m["ryn"] = {
 "Northern Amami-Oshima",
 2840988,
 "jpx-ryu",
 "Jpan",
 translit = s["Jpan-translit"],
 sort_key = s["Jpan-sortkey"],
}
m["rys"] = {
 "Yaeyama",
 34203,
 "jpx-ryu",
 "Jpan",
 translit = s["Jpan-translit"],
 sort_key = s["Jpan-sortkey"],
}
m["ryu"] = {
 "Okinawan",
 34233,
 "jpx-ryu",
 "Jpan",
 translit = s["Jpan-translit"],
 sort_key = s["Jpan-sortkey"],
}
m["rzh"] = {
 "Razihi",
 16911222,
 "sem-osa",
 "Arab",
 ancestors = "sem-srb",
}
m["saa"] = {
 "Saba",
 3914885,
 "cdc-est",
 "Latn",
}
m["sab"] = {
 "Buglere",
 3368506,
 "cba",
 "Latn",
}
m["sac"] = {
 "Fox",
 12714767,
 "alg-sfk",
 "Latn",
}
m["sad"] = {
 "Sandawe",
 34016,
 "qfa-iso",
 "Latn",
}
m["sae"] = {
 "Sabanê",
 3460478,
 "sai-nmk",
 "Latn",
}
m["saf"] = {
 "Safaliba",
 36432,
 "nic-mre",
 "Latn",
}
m["sah"] = {
 "Yakut",
 34299,
 "trk-sib",
 "Cyrl",
 translit = "sah-translit",
 override_translit = true,
}
m["saj"] = {
 "Sahu",
 7399757,
 "paa-nha",
 "Latn",
}
m["sak"] = {
 "Sake",
 36425,
 "bnt-kel",
 "Latn",
}
m["sam"] = {
 "Samaritan Aramaic",
 56612,
 "sem-arw",
 "Samr",
 entry_name = {remove_diacritics = u(0x0816) .. "-" .. u(0x082D)},
 translit = "Samr-translit",
}
m["sao"] = {
 "Sause",
 4409155,
 "paa-tkw",
 "Latn",
}
m["saq"] = {
 "Samburu",
 56536,
 "sdv-lma",
}
m["sar"] = {
 "Saraveca",
 3450556,
 "awd",
}
m["sas"] = {
 "Sasak",
 1294047,
 "poz-mcm",
 "Latn",
}
m["sat"] = {
 "Santali",
 33965,
 "mun",
 "Olck",
 translit = "Olck-translit",
 override_translit = true,
}
m["sau"] = {
 "Saleman",
 7404262,
 "poz-cet",
}
m["sav"] = {
 "Saafi-Saafi",
 36308,
 "alv-cng",
 "Arab, Latn",
}
m["saw"] = {
 "Sawi",
 677064,
 "ngf",
 "Latn",
}
m["sax"] = {
 "Sa",
 3460352,
 "poz-vnc",
 "Latn",
}
m["say"] = {
 "Saya",
 3914431,
 "cdc-wst",
 "Latn",
}
m["saz"] = {
 "Saurashtra",
 13292,
 "inc-wes",
 "Saur, Latn, Taml, Deva",
 translit = "saz-translit",
 ancestors = "inc-ogu",
}
m["sba"] = {
 "Ngambay",
 2372207,
 "csu-sar",
}
m["sbb"] = {
 "Simbo",
 3484101,
 "poz-ocw",
}
m["sbc"] = {
 "Gele'",
 3194847,
 "poz-oce",
}
m["sbd"] = {
 "Southern Samo",
 33122730,
 "dmn-sam",
 "Latn",
}
m["sbe"] = {
 "Saliba (New Guinea)",
 3469737,
 "poz-ocw",
}
m["sbf"] = {
 "Shabo",
 36342,
 "ssa",
 "Latn",
}
m["sbg"] = {
 "Seget",
 7446237,
}
m["sbh"] = {
 "Sori-Harengan",
 36515,
 "poz-aay",
 "Latn",
}
m["sbi"] = {
 "Seti",
 7456682,
 "qfa-tor",
 "Latn",
}
m["sbj"] = {
 "Surbakhal",
 759995,
}
m["sbk"] = {
 "Safwa",
 4121160,
 "bnt-mby",
 "Latn",
}
m["sbl"] = {
 "Botolan Sambal",
 4095195,
 "phi",
}
m["sbm"] = {
 "Sagala",
 11732610,
 "bnt-ruv",
 "Latn",
}
m["sbn"] = {
 "Sindhi Bhil",
 25559289,
 "inc-nwe",
 "Arab, Deva, Sind, Guru",
 ancestors = "sd",
}
m["sbo"] = {
 "Sabüm",
 7396535,
 "mkh-asl",
}
m["sbp"] = {
 "Sangu (Tanzania)",
 7418149,
 "bnt-bki",
 "Latn",
}
m["sbq"] = {
 "Sileibi",
 7514337,
 "ngf-mad",
}
m["sbr"] = {
 "Sembakung Murut",
 7449148,
 "poz-san",
}
m["sbs"] = {
 "Subiya",
 6442073,
 "bnt-bot",
 "Latn",
}
m["sbt"] = {
 "Kimki",
 6410160,
 "paa-pau",
}
m["sbu"] = {
 "Stod Bhoti",
 15622700,
 "sit-las",
}
m["sbv"] = {
 "Sabine",
 nil,
 "itc-sbl",
 "Latn",
}
m["sbw"] = {
 "Simba",
 36430,
 "bnt-tso",
 "Latn",
}
m["sbx"] = {
 "Seberuang",
 12473470,
 "poz-mly",
}
m["sby"] = {
 "Soli",
 7557754,
 "bnt-bot",
 "Latn",
}
m["sbz"] = {
 "Sara Kaba",
 25559318,
 "csu-kab",
 "Latn",
}
m["scb"] = {
 "Chut",
 2967709,
 "mkh-vie",
}
m["sce"] = {
 "Dongxiang",
 32947,
 "xgn-shr",
 "Arab, Latn",
}
m["scf"] = {
 "San Miguel Creole French",
 12953094,
 "crp",
 "Latn",
 ancestors = "gcf",
 sort_key = s["roa-oil-sortkey"],
}
m["scg"] = {
 "Sanggau",
 12473466,
 "day",
}
m["sch"] = {
 "Sakachep",
 37054,
 "tbq-kuk",
}
m["sci"] = {
 "Sri Lankan Creole Malay",
 1089151,
 "crp",
 "Latn",
 ancestors = "ms",
}
m["sck"] = {
 "Sadri",
 765922,
 "inc-eas",
 ancestors = "bh",
}
m["scl"] = {
 "Shina",
 1353320,
 "inc-dar",
 "ur-Arab, Deva",
}
m["scn"] = {
 "Sicilian",
 33973,
 "roa-itd",
 "Latn",
}
m["sco"] = {
 "Scots",
 14549,
 "gmw",
 "Latn",
 ancestors = "sco-smi",
}
m["scp"] = {
 "Yolmo",
 22662107,
 "sit-kyk",
 "Deva",
}
m["scq"] = {
 "Sa'och",
 6583617,
 "mkh-pea",
}
m["scs"] = {
 "North Slavey",
 20628,
 "den",
 "Latn",
}
m["scu"] = {
 "Shumcho",
 22077739,
 "sit-kin",
}
m["scv"] = {
 "Sheni",
 11015820,
 "nic-jer",
 "Latn",
 ancestors = "zir",
}
m["scw"] = {
 "Sha",
 3438816,
 "cdc-wst",
 "Latn",
}
m["scx"] = {
 "Sicel",
 36667,
 "ine",
 "Grek",
}
m["sda"] = {
 "Toraja-Sa'dan",
 36673,
 "poz-ssw",
}
m["sdb"] = {
 "Shabak",
 3289596,
 "ira-zgr",
 ancestors = "hac",
}
m["sdc"] = {
 "Sassarese",
 845441,
 "roa-itd",
 "Latn",
}
m["sde"] = {
 "Surubu",
 3913336,
 "nic-kau",
 "Latn",
}
m["sdf"] = {
 "Sarli",
 7424256,
 "ira-zgr",
 ancestors = "hac",
}
m["sdg"] = {
 "Savi",
 3474654,
 "inc-dar",
}
m["sdh"] = {
 "Southern Kurdish",
 1496597,
 "ku",
 "ku-Arab",
 translit = "sdh-translit",
 entry_name = {remove_diacritics = c.kasra .. c.sukun},
}
m["sdj"] = {
 "Suundi",
 7650407,
 "bnt-kng",
 "Latn",
}
m["sdk"] = {
 "Sos Kundi",
 7563811,
 "paa-spk",
 "Latn",
}
m["sdl"] = {
 "Saudi Arabian Sign Language",
 3504160,
 "sgn",
}
m["sdm"] = {
 "Semandang",
 7449012,
 "day",
}
m["sdn"] = {
 "Gallurese",
 612220,
 "roa-itd",
 "Latn",
 ancestors = "co",
}
m["sdo"] = {
 "Bukar-Sadung Bidayuh",
 2927799,
 "day",
}
m["sdp"] = {
 "Sherdukpen",
 7494785,
 "sit-khb",
}
m["sdr"] = {
 "Oraon Sadri",
 12953860,
 "inc-eas",
 ancestors = "bh",
}
m["sds"] = {
 "Tunisian Berber",
 5329732,
 "ber",
}
m["sdu"] = {
 "Sarudu",
 7424700,
 "poz-cet",
}
m["sdx"] = {
 "Sibu Melanau",
 18642842,
 "poz-bnn",
}
m["sea"] = {
 "Semai",
 3135426,
 "mkh-asl",
 "Latn",
}
-- seb is a duplicate code of spp
m["sec"] = {
 "Sechelt",
 7442898,
 "sal",
 "Latn",
}
m["sed"] = {
 "Sedang",
 56448,
 "mkh-nbn",
}
m["see"] = {
 "Seneca",
 1185133,
 "iro-nor",
 "Latn",
}
m["sef"] = {
 "Cebaara Senoufo",
 10975121,
 "alv-snr",
}
m["seg"] = {
 "Segeju",
 17584599,
 "bnt-mij",
 "Latn",
}
m["seh"] = {
 "Sena",
 2964008,
 "bnt-sna",
 "Latn",
}
m["sei"] = {
 "Seri",
 36583,
 "qfa-iso",
 "Latn",
}
m["sej"] = {
 "Sene",
 7450252,
}
m["sek"] = {
 "Sekani",
 28562,
 "ath-nor",
 "Latn",
}
m["sen"] = {
 "Nanerigé Sénoufo",
 36002,
 "alv-sma",
}
m["seo"] = {
 "Suarmin",
 7630513,
 "paa",
}
m["sep"] = {
 "Sìcìté Sénoufo",
 56787,
 "alv-sma",
}
m["seq"] = {
 "Senara Sénoufo",
 35210,
 "alv-snr",
}
m["ser"] = {
 "Serrano",
 3479942,
 "azc-tak",
 "Latn",
}
m["ses"] = {
 "Koyraboro Senni",
 35655,
 "son",
 "Latn",
}
m["set"] = {
 "Sentani",
 3441672,
 "paa-sen",
 "Latn",
}
m["seu"] = {
 "Serui-Laut",
 7455503,
 "poz-hce",
 "Latn",
}
m["sev"] = {
 "Nyarafolo Senoufo",
 36306,
 "alv-snr",
}
m["sew"] = {
 "Sewa Bay",
 7458126,
 "poz-ocw",
}
m["sey"] = {
 "Secoya",
 3477218,
 "sai-tuc",
 "Latn",
}
m["sez"] = {
 "Senthang Chin",
 7451223,
 "tbq-kuk",
}
m["sfb"] = {
 "French Belgian Sign Language",
 3217332,
 "sgn",
}
m["sfm"] = {
 "Small Flowery Miao",
 7542773,
 "hmn",
}
m["sfs"] = {
 "South African Sign Language",
 3322093,
 "sgn",
}
m["sfw"] = {
 "Sehwi",
 36593,
 "alv-ctn",
 "Latn",
}
m["sga"] = {
 "Old Irish",
 35308,
 "cel-gae",
 "Latn",
 ancestors = "pgl",
 entry_name = {remove_diacritics = c.dotabove .. c.diaer .. "·"},
 sort_key = "sga-sortkey",
 standardChars = "AaÁáBbCcDdEeÉéFfGgHhIiÍíLlMmNnOoÓóPpRrSsTtUuÚú0123456789" .. c.punc,
}
m["sgb"] = {
 "Mag-Anchi Ayta",
 4356243,
 "phi",
}
m["sgc"] = {
 "Kipsigis",
 56339,
 "sdv-nma",
}
m["sgd"] = {
 "Surigaonon",
 34140,
 "phi",
 "Latn",
}
m["sge"] = {
 "Segai",
 7446180,
}
m["sgg"] = {
 "Swiss-German Sign Language",
 35150,
 "sgn",
}
m["sgh"] = {
 "Shughni",
 34053,
 "ira-shy",
 "Latn, Cyrl",
 ancestors = "ira-shr-pro",
 translit = "sgh-translit",
 override_translit = true,
}
m["sgi"] = {
 "Suga",
 36475,
 "nic-mmb",
 "Latn",
}
m["sgk"] = {
 "Sangkong",
 2945610,
 "tbq-lol",
}
m["sgm"] = {
 "Singa",
 7522797,
 "bnt-lok",
 "Latn",
}
m["sgp"] = {
 "Singpho",
 7524158,
 "sit-jnp",
}
m["sgr"] = {
 "Sangisari",
 3394363,
 "ira-kms",
 "Arab",
}
m["sgs"] = {
 "Samogitian",
 213434,
 "bat",
 "Latn",
 ancestors = "olt",
 wikimedia_codes = "bat-smg",
}
m["sgt"] = {
 "Brokpake",
 56603,
 "sit-tib",
 "Tibt",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["sgu"] = {
 "Salas",
 7403694,
 "poz-cma",
}
m["sgw"] = {
 "Sebat Bet Gurage",
 2707343,
 "sem-eth",
 "Ethi",
}
m["sgx"] = {
 "Sierra Leone Sign Language",
 7511448,
 "sgn",
}
m["sgy"] = {
 "Sanglechi",
 3472220,
 "ira-sgi",
}
m["sgz"] = {
 "Sursurunga",
 36511,
 "poz-ocw",
 "Latn",
}
m["sha"] = {
 "Shall-Zwall",
 3915355,
 "nic-beo",
}
m["shb"] = {
 "Ninam",
 3436586,
}
m["shc"] = {
 "Sonde",
 7560881,
 "bnt-pen",
 "Latn",
}
m["shd"] = {
 "Kundal Shahi",
 6444265,
 "inc-dar",
}
m["she"] = {
 "Sheko",
 3183355,
 "omv-diz",
}
m["shg"] = {
 "Shua",
 3501092,
 "khi-kal",
 "Latn",
}
m["shh"] = {
 "Shoshone",
 33811,
 "azc-num",
 "Latn",
}
m["shi"] = {
 "Tashelhit",
 34152,
 "ber",
 "Tfng, Arab, Latn",
 translit = "Tfng-translit",
 -- put Judeo-Berber (Hebrew-script Tashelhit) under the category header
 -- U+FB21 HEBREW LETTER WIDE ALEF so that it sorts after Tifinagh script titles
 sort_key = {
  from = {"^%f[" .. u(0x5D0) .. "-" .. u(0x5EA) .. "]"},
  to   = {u(0xFB21)},
 },
}
m["shj"] = {
 "Shatt",
 56344,
 "sdv-daj",
}
m["shk"] = {
 "Shilluk",
 36486,
 "sdv-lon",
 "Latn",
}
m["shl"] = {
 "Shendu",
 22074616,
 "tbq-kuk",
}
m["shm"] = {
 "Shahrudi",
 7462280,
 "xme-ttc",
 ancestors = "xme-ttc-cen",
}
m["shn"] = {
 "Shan",
 56482,
 "tai-swe",
 "Mymr",
 translit = "shn-translit",
 sort_key = {
  from = {"[ၢႃ]", "ဵ", "ႅ", "ႇ", "ႈ", "း", "ႉ", "ႊ"},
  to   = {"ာ", "ေ", "ႄ", "႒", "႓", "႔", "႕", "႖"}
 },
}
m["sho"] = {
 "Shanga",
 3913931,
 "dmn-bbu",
 "Latn",
}
m["shp"] = {
 "Shipibo-Conibo",
 2671988,
 "sai-pan",
 "Latn",
}
m["shq"] = {
 "Sala",
 10961665,
 "bnt-bot",
 "Latn",
}
m["shr"] = {
 "Shi",
 3481999,
 "bnt-shh",
 "Latn",
}
m["shs"] = {
 "Shuswap",
 3482685,
 "sal",
 "Latn",
}
m["sht"] = {
 "Shasta",
 56396,
 "nai-shs",
 "Latn",
}
m["shu"] = {
 "Chadian Arabic",
 56497,
 "sem-arb",
 "Arab",
 entry_name = {
  remove_diacritics = c.kashida .. c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun .. c.superalef,
  from = {u(0x0671)},
  to   = {u(0x0627)}
 },
}
m["shv"] = {
 "Shehri",
 33445,
 "sem-sar",
 "Arab, Latn",
 ancestors = "sem-pro",
}
m["shw"] = {
 "Shwai",
 36527,
 "alv-hei",
}
m["shx"] = {
 "She",
 2605689,
 "hmn",
}
m["shy"] = {
 "Tachawit",
 33274,
 "ber",
 "Tfng, Arab, Latn",
 translit = "Tfng-translit",
}
m["shz"] = {
 "Syenara Senoufo",
 36316,
 "alv-snr",
}
m["sia"] = {
 "Akkala Sami",
 35241,
 "smi",
 "Cyrl, Latn",
 translit = "sia-translit",
 display_text = {
  from = {"'"},
  to = {"ˈ"}
 },
 entry_name = {remove_diacritics = "'ˈ"},
}
m["sib"] = {
 "Sebop",
 7442799,
 "poz-swa",
 "Latn",
}
m["sid"] = {
 "Sidamo",
 33786,
 "cus-hec",
 "Latn, Ethi",
}
m["sie"] = {
 "Simaa",
 7517329,
 "bnt-kav",
 "Latn",
}
m["sif"] = {
 "Siamou",
 36252,
}
m["sig"] = {
 "Paasaal",
 36426,
 "nic-sis",
 "Latn",
}
m["sih"] = {
 "Zire",
 8072753,
 "poz-cln",
}
m["sii"] = {
 "Shom Peng",
 1039346,
 "aav",
}
m["sij"] = {
 "Numbami",
 3346277,
 "poz-ocw",
}
m["sik"] = {
 "Sikiana",
 3443734,
 "sai-prk",
 "Latn",
}
m["sil"] = {
 "Tumulung Sisaala",
 25383006,
 "nic-sis",
 "Latn",
}
m["sim"] = {
 "Seim",
 7446815,
 "paa-spk",
}
m["sip"] = {
 "Sikkimese",
 35285,
 "sit-tib",
 "Tibt",
 ancestors = "xct",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["siq"] = {
 "Sonia",
 7561770,
}
m["sir"] = {
 "Siri",
 3438729,
 "cdc-wst",
 "Latn",
}
m["sis"] = {
 "Siuslaw",
 2315424,
}
m["siu"] = {
 "Sinagen",
 7521655,
 "qfa-tor",
 "Latn",
}
m["siv"] = {
 "Sumariup",
 7636966,
 "paa-spk",
 "Latn",
}
m["siw"] = {
 "Siwai",
 7532519,
 "paa-sbo",
}
m["six"] = {
 "Sumau",
 7637021,
 "ngf-mad",
 "Latn",
}
m["siy"] = {
 "Sivandi",
 13269,
 "xme",
 ancestors = "xme-mid",
}
m["siz"] = {
 "Siwi",
 36814,
 "ber",
 "Tfng, Arab, Latn",
}
m["sja"] = {
 "Epena",
 3055682,
 "sai-chc",
}
m["sjb"] = {
 "Sajau Basap",
 4684353,
 "poz-bnn",
}
m["sjd"] = {
 "Kildin Sami",
 33656,
 "smi",
 "Cyrl",
 translit = "sjd-translit",
 display_text = {
  from = {"'"},
  to = {"ˈ"}
 },
 entry_name = {remove_diacritics = "'ˈ"},
}
m["sje"] = {
 "Pite Sami",
 56314,
 "smi",
 "Latn",
 display_text = {
  from = {"'"},
  to = {"ˈ"}
 },
 entry_name = {remove_diacritics = c.macron .. "'ˈ"},
 sort_key = "sje-sortkey",
}
m["sjg"] = {
 "Assangori",
 3502255,
 "sdv-tmn",
}
m["sjk"] = {
 "Kemi Sami",
 35871,
 "smi",
 "Latn",
 display_text = {
  from = {"'"},
  to = {"ˈ"}
 },
 entry_name = {remove_diacritics = "'ˈ"},
}
m["sjl"] = {
 "Miji",
 6845470,
 "sit-hrs",
}
m["sjm"] = {
 "Mapun",
 3287253,
 "poz-sbj",
}
m["sjn"] = {
 "Sindarin",
 56437,
 "art",
 "Latn, Teng",
 type = "appendix-constructed",
}
m["sjo"] = {
 "Xibe",
 13223,
 "tuw",
 "sjo-Mong",
}
m["sjp"] = {
 "Surjapuri",
 7645351,
 "inc-eas",
 ancestors = "pra-mag",
}
m["sjr"] = {
 "Siar-Lak",
 3482907,
 "poz-ocw",
}
m["sjs"] = {
 "Senhaja De Srair",
 56744,
 "ber",
}
m["sjt"] = {
 "Ter Sami",
 36656,
 "smi",
 "Latn",
 display_text = {
  from = {"'"},
  to = {"ˈ"}
 },
 entry_name = {remove_diacritics = "'ˈ"},
}
m["sju"] = {
 "Ume Sami",
 56415,
 "smi",
 "Latn",
 entry_name = {remove_diacritics = c.macron .. "'ˈ"},
 display_text = {
  from = {"'"},
  to = {"ˈ"}
 },
 sort_key = "sju-sortkey",
}
m["sjw"] = {
 "Shawnee",
 2669206,
 "alg",
 "Latn",
}
m["ska"] = {
 "Skagit",
 25559652,
 "sal",
 "Latn",
}
m["skb"] = {
 "Saek",
 36437,
 "tai-nor",
 "Thai",
 sort_key = "Thai-sortkey",
}
m["skc"] = {
 "Ma Manda",
 6720783,
 "ngf-fin",
}
m["skd"] = {
 "Southern Sierra Miwok",
 3492334,
 "nai-utn",
 "Latn",
}
m["ske"] = {
 "Ske",
 7534244,
 "poz-vnc",
 "Latn",
}
m["skf"] = {
 "Mekéns",
 3304806,
 "tup",
 "Latn",
}
m["skh"] = {
 "Sikule",
 3121081,
 "poz-nws",
}
m["ski"] = {
 "Sika",
 33960,
 "poz-cet",
 "Latn",
}
m["skj"] = { -- compare 'ths'
 "Seke",
 30226846,
 "sit-tam",
}
m["skk"] = {
 "Sok",
 12953887,
 "mkh-ban",
}
m["skm"] = {
 "Sakam",
 6448517,
 "ngf-fin",
}
m["skn"] = {
 "Kolibugan Subanon",
 18755617,
 "phi",
}
m["sko"] = {
 "Seko Tengah",
 15613270,
 "poz",
}
m["skp"] = {
 "Sekapan",
 7447132,
 "poz-bnn",
}
m["skq"] = {
 "Sininkere",
 3914896,
 "dmn-man",
 "Latn",
}
m["skr"] = {
 "Saraiki",
 33902,
 "inc-pan",
 "pa-Arab, Mult, Deva",
 ancestors = "lah",
 entry_name = {remove_diacritics = c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun},
 translit = {
  ["pa-Arab"] = "pa-Arab-translit",
  Mult = "Mult-translit",
 },
}
m["sks"] = {
 "Maia",
 12952760,
 "ngf-mad",
 "Latn",
}
m["skt"] = {
 "Sakata",
 36691,
 "bnt-bnm",
 "Latn",
}
m["sku"] = {
 "Sakao",
 3298421,
 "poz-vnc",
 "Latn",
}
m["skv"] = {
 "Skou",
 3915200,
 "paa-msk",
 "Latn",
}
m["skw"] = {
 "Skepi Creole Dutch",
 2522153,
 "crp",
 ancestors = "nl",
}
m["skx"] = {
 "Seko Padang",
 15613282,
 "poz-ssw",
}
m["sky"] = {
 "Sikaiana",
 7439242,
 "poz-pnp",
 "Latn",
}
m["skz"] = {
 "Sekar",
 7447136,
 "poz-cet",
}
m["slc"] = {
 "Saliba (Colombia)",
 3441097,
}
m["sld"] = {
 "Sissala",
 11020264,
 "nic-sis",
 "Latn",
}
m["sle"] = {
 "Sholaga",
 7500203,
 "dra",
 "Knda",
 translit = "kn-translit"
}
m["slf"] = {
 "Swiss-Italian Sign Language",
 12953479,
 "sgn",
}
m["slg"] = {
 "Selungai Murut",
 7448844,
 "poz-san",
}
m["slh"] = {
 "Southern Puget Sound Salish",
 12642471,
 "sal",
 "Latn",
}
-- "sli" "Silesian German" IS SUBSUMED INTO "gmw-ecg" "East Central German"
m["slj"] = {
 "Salumá",
 7406296,
 "sai-prk",
 "Latn",
}
m["sll"] = {
 "Salt-Yui",
 7405785,
}
m["slm"] = {
 "Pangutaran Sama",
 3362086,
 "poz-sbj",
}
m["sln"] = {
 "Salinan",
 1568938,
}
m["slp"] = {
 "Lamaholot",
 6480777,
 "poz-cet",
 "Latn",
}
m["slq"] = {
 "Salchuq",
 56752,
 "trk",
}
m["slr"] = {
 "Salar",
 33963,
 "trk",
 "Arab, Latn",
}
m["sls"] = {
 "Singapore Sign Language",
 7512563,
 "sgn",
}
m["slt"] = {
 "Sila",
 7514021,
 "tbq-lol",
}
m["slu"] = {
 "Selaru",
 7447500,
 "poz-cet",
}
m["slw"] = {
 "Sialum",
 7506694,
 "ngf",
}
m["slx"] = {
 "Salampasu",
 7403607,
 "bnt-lun",
 "Latn",
}
m["sly"] = {
 "Selayar",
 7447520,
 "poz-ssw",
}
m["slz"] = {
 "Ma'ya",
 2291492,
 "poz-hce",
}
m["sma"] = {
 "Southern Sami",
 13293,
 "smi",
 "Latn",
 display_text = {
  from = {"'"},
  to = {"ˈ"}
 },
 entry_name = {remove_diacritics = "'ˈ"},
 sort_key = "sma-sortkey",
}
m["smb"] = {
 "Simbari",
 7517427,
 "ngf",
}
m["smc"] = {
 "Som",
 7559081,
 "ngf-fin",
 "Latn",
}
m["smd"] = {
 "Sama",
 6407456,
 "bnt-kmb",
 "Latn",
}
m["smf"] = {
 "Auwe",
 3502072,
 "paa-brd",
 ancestors = "dnd",
}
m["smg"] = {
 "Simbali",
 56692,
 "paa-bng",
}
m["smh"] = {
 "Samei",
 7409269,
 "tbq-lol",
}
m["smj"] = {
 "Lule Sami",
 56322,
 "smi",
 "Latn",
 display_text = {
  from = {"'"},
  to = {"ˈ"}
 },
 entry_name = {remove_diacritics = c.macron .. "'ˈ"},
 sort_key = "smj-sortkey",
}
m["smk"] = {
 "Bolinao",
 2669235,
 "phi",
}
m["sml"] = {
 "Central Sama",
 3470593,
 "poz-sbj",
}
m["smm"] = {
 "Musasa",
 6940122,
 "inc-eas",
 ancestors = "bh",
}
m["smn"] = {
 "Inari Sami",
 33462,
 "smi",
 "Latn",
 display_text = {
  from = {"'"},
  to = {"ˈ"}
 },
 entry_name = {remove_diacritics = c.dotbelow .. "'ˈ"},
 sort_key = "smn-sortkey",
}
m["smp"] = {
 "Samaritan Hebrew",
 56502,
 "sem-can",
 "Samr",
 entry_name = {remove_diacritics = u(0x0816) .. "-" .. u(0x082D)},
}
m["smq"] = {
 "Samo",
 7409884,
 "ngf",
}
m["smr"] = {
 "Simeulue",
 2992833,
 "poz-nws",
 "Latn",
}
m["sms"] = {
 "Skolt Sami",
 13271,
 "smi",
 "Latn",
 display_text = {
  from = {"'"},
  to = {"ˈ"}
 },
 entry_name = {remove_diacritics = c.dotbelow .. "'ˈ"},
 sort_key = "sms-sortkey",
}
m["smt"] = {
 "Simte",
 7521268,
 "tbq-kuk",
}
m["smu"] = {
 "Somray",
 6583612,
 "mkh-pea",
}
m["smv"] = {
 "Samvedi",
 6345632,
 "inc-sou",
 ancestors = "pra-mah",
}
m["smw"] = {
 "Sumbawa",
 3182585,
 "poz-mcm",
 "Latn",
}
m["smx"] = {
 "Samba",
 11120157,
 "bnt-pen",
 "Latn",
}
m["smy"] = {
 "Semnani",
 14531212,
 "xme",
 ancestors = "xme-old",
}
m["smz"] = {
 "Simeku",
 7517534,
 "paa-sbo",
}
m["snb"] = {
 "Sebuyau",
 7442836,
 "poz-mly",
}
m["snc"] = {
 "Sinaugoro",
 4170719,
 "poz-ocw",
}
m["sne"] = {
 "Bau Bidayuh",
 2891938,
 "day",
 "Latn",
}
m["snf"] = {
 "Noon",
 36304,
 "alv-cng",
 "Latn",
}
m["sng"] = {
 "Sanga (Congo)",
 3438316,
 "bnt-lub",
 "Latn",
}
m["sni"] = {
 "Sensi",
 7451029,
 "sai-pan",
 "Latn",
}
m["snj"] = {
 "Riverain Sango",
 25559751,
 "crp",
 "Latn",
 ancestors = "ngb",
}
m["snk"] = {
 "Soninke",
 36660,
 "dmn-snb",
 "Latn",
}
m["snl"] = {
 "Sangil",
 3472206,
 "phi",
}
m["snm"] = {
 "Southern Ma'di",
 15637273,
 "csu-mma",
}
m["snn"] = {
 "Siona",
 3485116,
 "sai-tuc",
 "Latn",
}
m["sno"] = {
 "Snohomish",
 25559662,
 "sal",
 "Latn",
}
m["snp"] = {
 "Siane",
 7506812,
 "paa-kag",
 "Latn",
}
m["snq"] = {
 "Sangu (Gabon)",
 36609,
 "bnt-sir",
 "Latn",
}
m["snr"] = {
 "Sihan",
 7513400,
 "ngf-mad",
}
m["sns"] = {
 "Nahavaq",
 2160435,
 "poz-vnc",
}
m["snu"] = {
 "Senggi",
 7929052,
 "paa-brd"
}
m["snv"] = {
 "Sa'ban",
 3474891,
 "poz-swa",
 "Latn",
}
m["snw"] = {
 "Selee",
 36272,
 "alv-ntg",
 "Latn",
}
m["snx"] = {
 "Sam",
 7408387,
}
m["sny"] = {
 "Saniyo-Hiyewe",
 7418302,
 "paa-spk",
 "Latn",
}
m["snz"] = {
 "Kou",
 7525035, -- also 4803639
 "ngf-mad",
 "Latn",
}
m["soa"] = {
 "Thai Song",
 7709159,
 "tai-swe",
 "Tavt, Thai",
 --translit = "Tavt-translit",
  sort_key = {
  from = {"([ꪵꪶꪹꪻꪼ])([ꪀ-ꪯ])", "([เแโใไ])([ก-ฮ])"},
  to   = {"%2%1", "%2%1"}
 },
}
m["sob"] = {
 "Sobei",
 3121035,
 "poz-ocw",
}
m["soc"] = {
 "Soko",
 7555138,
 "bnt-ske",
 "Latn",
}
m["sod"] = {
 "Songoora",
 7561296,
 "bnt-lgb",
 "Latn",
}
m["soe"] = {
 "Songomeno",
 5713543,
 "bnt-bsh",
 "Latn",
}
m["sog"] = {
 "Sogdian",
 205979,
 "ira-sgc",
 "Sogd, Mani, Syrc, Sogo",
 translit = {
  Sogd = "Sogd-translit",
  Mani = "Mani-translit",
  Sogo = "Sogo-translit",
 },
}
m["soh"] = {
 "Aka (Sudan)",
 3450949,
 "sdv-eje",
 "Latn",
}
m["soi"] = {
 "Sonha",
 12953890,
 "inc-eas",
 ancestors = "pra-mag",
}
m["sok"] = {
 "Sokoro",
 3441303,
 "cdc-est",
 "Latn",
}
m["sol"] = {
 "Solos",
 3489591,
 "poz-ocw",
}
m["soo"] = {
 "Nsong",
 12953148,
 "bnt-bdz",
 "Latn",
}
m["sop"] = {
 "Songe",
 3130911,
 "bnt-lbn",
 "Latn",
}
m["soq"] = {
 "Kanasi",
 11732656,
}
m["sor"] = {
 "Somrai",
 3123566,
 "cdc-est",
 "Latn",
}
m["sos"] = {
 "Seenku",
 36274,
 "dmn-smg",
}
m["sou"] = {
 "Southern Thai",
 56508,
 "tai-swe",
 "Thai",
 sort_key = "Thai-sortkey",
}
m["sov"] = {
 "Sonsorolese",
 13281,
 "poz-mic",
 "Latn",
}
m["sow"] = {
 "Sowanda",
 7571845,
 "paa-brd"
}
m["sox"] = {
 "Swo",
 36604,
 "bnt-mka",
 "Latn",
}
m["soy"] = {
 "Miyobe",
 35913,
 "alv-sav",
 "Latn",
}
m["soz"] = {
 "Temi",
 13278,
 "bnt-kka",
 "Latn",
}
m["spb"] = {
 "Sepa (Indonesia)",
 18603687,
 "poz-cma",
 "Latn",
}
m["spc"] = {
 "Sapé",
 2888158,
 nil,
 "Latn",
}
m["spd"] = {
 "Saep",
 7398312,
 "ngf-mad",
}
m["spe"] = {
 "Sepa (New Guinea)",
 7451725,
 "poz-ocw",
 "Latn",
}
m["spg"] = {
 "Sian",
 7506806,
 "poz-bnn",
}
m["spi"] = {
 "Saponi",
 3915418,
 "paa",
}
m["spk"] = {
 "Sengo",
 7450584,
 "paa-spk",
 "Latn",
}
m["spl"] = {
 "Selepet",
 7447917,
 "ngf",
}
m["spm"] = {
 "Sepen",
 4701931,
 "paa",
 "Latn",
}
m["spn"] = {
 "Sanapaná",
 3033556,
 "sai-mas",
 "Latn",
}
m["spo"] = {
 "Spokane",
 3493704,
 "sal",
}
m["spp"] = {
 "Supyire",
 56284,
 "alv-sma",
 "Latn",
}
m["spr"] = {
 "Saparua",
 7420921,
 "poz-cma",
}
m["sps"] = {
 "Saposa",
 3473187,
 "poz-ocw",
}
m["spt"] = {
 "Spiti Bhoti",
 22080879,
 "sit-las",
}
m["spu"] = {
 "Sapuan",
 7421168,
 "mkh-ban",
}
m["spv"] = {
 "Sambalpuri",
 6433240,
 "inc-eas",
 "Orya",
 translit = "or-translit",
 ancestors = "or",
}
m["spx"] = {
 "South Picene",
 36688,
 "itc-sbl",
 "Ital, Latn",
 translit = "Ital-translit",
}
m["spy"] = {
 "Sabaot",
 7395896,
 "sdv-kln",
}
m["sqa"] = {
 "Shama-Sambuga",
 3914392,
 "nic-kmk",
 "Latn",
}
m["sqh"] = {
 "Shau",
 3913925,
 "nic-jer",
 "Latn",
}
m["sqk"] = {
 "Albanian Sign Language",
 4709168,
 "sgn",
}
m["sqm"] = {
 "Suma",
 11008431,
 "alv-gbw",
}
m["sqn"] = {
 "Susquehannock",
 3505736,
 "iro-nor",
}
m["sqo"] = {
 "Sorkhei",
 3491964,
 "ira-kms",
}
m["sqq"] = {
 "Sou",
 16979751,
 "mkh-ban",
}
m["sqr"] = {
 "Siculo-Arabic",
 1069489,
 "sem-arb",
}
m["sqs"] = {
 "Sri Lankan Sign Language",
 3915466,
 "sgn",
}
m["sqt"] = {
 "Soqotri",
 13283,
 "sem-sar",
 "Arab, Latn",
}
m["squ"] = {
 "Squamish",
 2484579,
 "sal",
 "Latn",
}
m["sra"] = {
 "Saruga",
 7424699,
 "ngf-mad",
 "Latn",
}
m["srb"] = {
 "Sora",
 13284,
 "mun",
 "Sora",
}
m["sre"] = {
 "Sara",
 33957,
 "day",
}
m["srf"] = {
 "Nafi",
 6958174,
 "poz-ocw",
}
m["srg"] = {
 "Sulod",
 7636489,
 "phi",
}
m["srh"] = {
 "Sarikoli",
 33873,
 "ira-shy",
 "Latn, ug-Arab, Cyrl",
 ancestors = "ira-shr-pro",
}
m["sri"] = {
 "Siriano",
 3485264,
 "sai-tuc",
 "Latn",
}
m["srk"] = {
 "Serudung Murut",
 7455497,
 "poz-san",
}
m["srl"] = {
 "Isirawa",
 4203802,
 "paa-tkw",
}
m["srm"] = {
 "Saramaccan",
 33779,
 "crp",
 "Latn",
 ancestors = "en, pt",
}
m["srn"] = {
 "Sranan Tongo",
 33989,
 "crp",
 "Latn",
}
m["srq"] = {
 "Sirionó",
 3027953,
 "tup-gua",
 "Latn",
}
m["srr"] = {
 "Serer",
 36284,
 "alv-fwo",
 "Latn",
}
m["srs"] = {
 "Tsuut'ina",
 20825,
 "ath-nor",
 "Latn",
}
m["srt"] = {
 "Sauri",
 7427547,
 "paa-egb",
}
m["sru"] = {
 "Suruí",
 7646993,
 "tup",
 "Latn",
}
m["srv"] = {
 "Waray Sorsogon",
 18755610,
 "phi",
}
m["srw"] = {
 "Serua",
 14916905,
 "poz-cet",
}
m["srx"] = {
 "Sirmauri",
 7530505,
 "him",
}
m["sry"] = {
 "Sera",
 7452602,
 "poz-ocw",
 "Latn",
}
m["srz"] = {
 "Shahmirzadi",
 12953126,
 "ira-msh",
 "fa-Arab",
}
m["ssb"] = {
 "Southern Sama",
 3470594,
 "poz-sbj",
 "Latn",
}
m["ssc"] = {
 "Suba-Simbiti",
 7630687,
 "bnt-lok",
 "Latn",
}
m["ssd"] = {
 "Siroi",
 10771067,
 "ngf-mad",
 "Latn",
}
m["sse"] = {
 "Balangingi",
 2880535,
 "poz-sbj",
 "Latn",
}
m["ssf"] = {
 "Thao",
 676492,
 "map",
 "Latn",
}
m["ssg"] = {
 "Seimat",
 3182581,
 "poz-aay",
}
m["ssh"] = {
 "Shihhi Arabic",
 56571,
 "sem-arb",
 "Arab",
 entry_name = {
  remove_diacritics = c.kashida .. c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun .. c.superalef,
  from = {u(0x0671)},
  to   = {u(0x0627)}
 },
}
m["ssi"] = {
 "Sansi",
 3309366,
 "inc-nwe",
 ancestors = "pra-sau",
}
m["ssj"] = {
 "Sausi",
 7427605,
 "ngf-mad",
 "Latn",
}
m["ssk"] = {
 "Sunam",
 11002210,
 "sit-kin",
}
m["ssl"] = {
 "Western Sisaala",
 11154776,
 "nic-sis",
 "Latn",
}
m["ssm"] = {
 "Semnam",
 7449713,
 "mkh-asl",
}
m["sso"] = {
 "Sissano",
 7530937,
 "poz-ocw",
 "Latn",
}
m["ssp"] = {
 "Spanish Sign Language",
 3100814,
 "sgn",
}
m["ssq"] = {
 "So'a",
 7572120,
 "poz-cet",
 "Latn",
}
m["ssr"] = {
 "Swiss-French Sign Language",
 12953483,
 "sgn",
}
m["sss"] = {
 "Sô",
 3082037,
 "mkh-kat",
}
m["sst"] = {
 "Sinasina",
 7521813,
 "ngf",
 "Latn",
}
m["ssu"] = {
 "Susuami",
 7649752,
 "ngf",
 "Latn",
}
m["ssv"] = {
 "Shark Bay",
 7489783,
 "poz-vnc",
}
m["ssx"] = {
 "Samberigi",
 7409020,
 "paa-eng",
 "Latn",
}
m["ssy"] = {
 "Saho",
 36353,
 "cus-eas",
 "Latn, Ethi, Arab",
}
m["ssz"] = {
 "Sengseng",
 7450601,
 "poz-ocw",
 "Latn",
}
m["stb"] = {
 "Northern Subanen",
 12953892,
 "phi",
}
m["std"] = {
 "Sentinelese",
 568377,
}
m["ste"] = {
 "Liana-Seti",
 6539924,
 "poz-cma",
}
m["stf"] = {
 "Seta",
 7456326,
 "qfa-tor",
 "Latn",
}
m["stg"] = {
 "Trieng",
 22694648,
 "mkh-ban",
}
m["sth"] = {
 "Shelta",
 36705,
 "crp",
 "Latn",
 ancestors = "en",
}
m["sti"] = {
 "Bulo Stieng",
 15771431,
 "mkh-ban",
}
m["stj"] = {
 "Matya Samo",
 10974879,
 "dmn-sam",
 "Latn",
}
m["stk"] = {
 "Arammba",
 3502094,
 "ngf",
}
m["stm"] = {
 "Setaman",
 7456333,
 "ngf-okk",
 "Latn",
}
m["stn"] = {
 "Owa",
 1324132,
 "poz-sls",
 "Latn",
}
m["sto"] = {
 "Stoney",
 3033570,
 "sio-dkt",
}
m["stp"] = {
 "Southeastern Tepehuan",
 12953917,
 "azc",
 "Latn",
}
m["stq"] = {
 "Saterland Frisian",
 27154,
 "gmw-fri",
 "Latn",
}
m["str"] = {
 "Saanich",
 36444,
 "sal",
 "Latn",
}
m["sts"] = {
 "Shumashti",
 33777,
 "inc-dar",
}
m["stt"] = {
 "Budeh Stieng",
 12953891,
 "mkh-ban",
}
m["stu"] = {
 "Samtao",
 25559550,
 "mkh-pal",
}
m["stv"] = {
 "Silt'e",
 nil,
 "sem-eth",
 "Ethi",
}
m["stw"] = {
 "Satawalese",
 28477,
 "poz-mic",
}
m["sty"] = {
 "Siberian Tatar",
 4418344,
 "trk-kno",
 "Cyrl",
}
m["sua"] = {
 "Sulka",
 7636341,
 "qfa-iso",
}
m["sub"] = {
 "Suku",
 12953160,
 "bnt-yak",
 "Latn",
}
m["suc"] = {
 "Western Subanon",
 16113894,
 "phi",
}
m["sue"] = {
 "Suena",
 7634386,
 "ngf",
 "Latn",
}
m["sug"] = {
 "Suganga",
 7634706,
 "ngf-okk",
 "Latn",
}
m["sui"] = {
 "Suki",
 2089984,
 "ngf",
 "Latn",
}
m["suk"] = {
 "Sukuma",
 2638144,
 "bnt-tkm",
 "Latn",
}
m["suq"] = {
 "Suri",
 5364172,
 "sdv",
}
m["sur"] = {
 "Mwaghavul",
 3440486,
 "cdc-wst",
 "Latn",
}
m["sus"] = {
 "Susu",
 33990,
 "dmn-sya",
 "Latn",
}
m["sut"] = {
 "Subtiaba",
 3915405,
 "omq",
 "Latn",
}
m["suv"] = {
 "Sulung",
 56408,
 "sit-khb",
}
m["suw"] = {
 "Sumbwa",
 7637055,
 "bnt-glb",
 "Latn",
}
m["sux"] = {
 "Sumerian",
 36790,
 "qfa-iso",
 "Xsux",
}
m["suy"] = {
 "Suyá",
 3505859,
 "sai-nje",
 "Latn",
}
m["suz"] = {
 "Sunwar",
 56549,
 "sit-kiw",
}
m["sva"] = {
 "Svan",
 34067,
 "ccs",
 "Geor, Cyrl",
 translit = "sva-translit",
 override_translit = true,
}
m["svb"] = {
 "Ulau-Suain",
 7878769,
 "poz-ocw",
 "Latn",
}
m["svc"] = {
 "Vincentian Creole English",
 3501785,
 "crp",
 "Latn",
 ancestors = "en",
}
m["sve"] = {
 "Serili",
 7454834,
 "poz-tim",
}
m["svk"] = {
 "Slovakian Sign Language",
 7541557,
 "sgn",
}
m["svm"] = {
 "Slavomolisano",
 36254,
 "zls",
 "Latn",
 ancestors = "sh",
}
m["svs"] = {
 "Savosavo",
 3130296,
 "paa",
 "Latn",
}
m["svx"] = {
 "Skalvian",
 3486125,
 "bat",
 "Latn",
}
m["swb"] = {
 "Maore Comorian",
 34075,
 "bnt-com",
 "Latn",
 sort_key = "bnt-com-sortkey",
}
m["swf"] = {
 "Sere",
 7453056,
 "nic-ser",
 "Latn",
}
m["swg"] = {
 "Swabian",
 327274,
 "gmw",
 "Latn",
 ancestors = "gsw",
}
m["swi"] = {
 "Sui",
 3112388,
 "qfa-kms",
 "Latn, Shui, Hani",
 sort_key = {Hani = "Hani-sortkey"},
}
m["swj"] = {
 "Sira",
 36599,
 "bnt-sir",
 "Latn",
}
m["swl"] = {
 "Swedish Sign Language",
 36558,
 "sgn",
}
m["swm"] = {
 "Samosa",
 7410037,
 "ngf-mad",
 "Latn",
}
m["swn"] = {
 "Sokna",
 2988323,
 "ber",
}
m["swo"] = {
 "Shanenawa",
 nil,
 "sai-pan",
 "Latn",
}
m["swp"] = {
 "Suau",
 3502368,
 "poz-ocw",
}
m["swq"] = {
 "Sharwa",
 56791,
 "cdc-cbm",
 "Latn",
}
m["swr"] = {
 "Saweru",
 3474649,
}
m["sws"] = {
 "Seluwasan",
 7448845,
 "poz-cet",
}
m["swt"] = {
 "Sawila",
 7428639,
}
m["swu"] = {
 "Suwawa",
 7650588,
 "phi",
}
m["sww"] = {
 "Sowa",
 7571843,
 "poz-vnc",
}
m["swx"] = {
 "Suruahá",
 3114402,
 "auf",
}
m["swy"] = {
 "Sarua",
 56261,
 "cdc-est",
 "Latn",
}
m["sxb"] = {
 "Suba",
 33916,
 "bnt-lok",
 "Latn",
}
m["sxc"] = {
 "Sicanian",
 36335,
}
m["sxe"] = {
 "Sighu",
 36431,
 "bnt-kel",
 "Latn",
}
m["sxg"] = {
 "Shixing",
 56337,
 "sit-nax",
 "Latn",
}
m["sxk"] = {
 "Southern Kalapuya",
 3192122,
 "nai-klp",
}
m["sxl"] = {
 "Selonian",
 36491,
 "bat",
 "Latn",
}
m["sxm"] = {
 "Samre",
 6583615,
 "mkh-pea",
}
m["sxn"] = {
 "Sangir",
 25714758,
 "phi",
 "Latn",
}
m["sxo"] = {
 "Sorothaptic",
 2762254,
}
m["sxr"] = {
 "Saaroa",
 716599,
 "map",
 "Latn",
}
m["sxs"] = {
 "Sasaru",
 3913384,
 "alv-yek",
 "Latn",
}
-- "sxu" "Upper Saxon" IS SUBSUMED INTO "gmw-ecg" "East Central German"
m["sxw"] = {
 "Saxwe Gbe",
 7428892,
 "alv-pph",
}
m["sya"] = {
 "Siang",
 3482903,
}
m["syb"] = {
 "Central Subanen",
 12953893,
 "phi",
 "Latn",
}
m["syc"] = {
 "Classical Syriac",
 33538,
 "sem-are",
 "Syrc",
 entry_name = {remove_diacritics = c.macron .. c.diaer .. c.macronbelow .. u(0x0730) .. "-" .. u(0x0748)},
}
m["syi"] = {
 "Seki",
 36547,
 "bnt-kel",
 "Latn",
}
m["syk"] = {
 "Sukur",
 56292,
 "cdc-cbm",
 "Latn",
}
m["syl"] = {
 "Sylheti",
 2044560,
 "inc-eas",
 "Sylo, Beng",
 ancestors = "inc-obn",
 translit = "syl-translit",
}
m["sym"] = {
 "Maya Samo",
 10950421,
 "dmn-sam",
 "Latn",
}
m["syn"] = {
 "Senaya",
 33914,
 "sem-nna",
}
m["syo"] = {
 "Suoy",
 7641864,
 "mkh-pea",
}
m["sys"] = {
 "Sinyar",
 56840,
 "csu",
 "Latn",
}
m["syw"] = {
 "Kagate",
 12952538,
 "sit-kyk",
 "Deva",
}
m["syx"] = {
 "Osamayi",
 7408415,
 "bnt-kel",
 "Latn",
}
m["syy"] = {
 "Al-Sayyid Bedouin Sign Language",
 2915457,
 "sgn",
}
m["sza"] = {
 "Semelai",
 3111827,
 "mkh-asl",
}
m["szb"] = {
 "Ngalum",
 11732516,
 "ngf-okk",
 "Latn",
}
m["szc"] = {
 "Semaq Beri",
 7449119,
 "mkh-asl",
}
m["szd"] = {
 "Seru",
 7455488,
 "poz-bnn",
 "Latn",
}
m["sze"] = {
 "Seze",
 373683,
 "omv-mao",
 "Latn",
}
m["szg"] = {
 "Sengele",
 7450555,
 "bnt-mon",
 "Latn",
}
m["szl"] = {
 "Silesian",
 30319,
 "zlw",
 "Latn",
 ancestors = "zlw-opl",
}
m["szn"] = {
 "Sula",
 3503403,
 "poz-cma",
 "Latn",
}
m["szp"] = {
 "Suabo",
 7630429,
 "ngf-sbh",
 "Latn",
}
m["szv"] = {
 "Isubu",
 35431,
 "bnt-saw",
 "Latn",
}
m["szw"] = {
 "Sawai",
 3447258,
 "poz-hce",
 "Latn",
}
m["szy"] = {
 "Sakizaya",
 718269,
 "map",
 "Latn",
}
m["taa"] = {
 "Lower Tanana",
 28565,
 "ath-nor",
 "Latn",
}
m["tab"] = {
 "Tabasaran",
 34079,
 "cau-esm",
 "Cyrl, Latn, Arab",
 translit = "tab-translit",
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
 sort_key = "tab-sortkey",
}
m["tac"] = {
 "Lowland Tarahumara",
 15616384,
 "azc-trc",
 "Latn",
}
m["tad"] = {
 "Tause",
 2356440,
 "paa-lkp",
 "Latn",
}
m["tae"] = {
 "Tariana",
 732726,
 "awd-nwk",
 "Latn",
}
m["taf"] = {
 "Tapirapé",
 7684673,
 "tup-gua",
 "Latn",
}
m["tag"] = {
 "Tagoi",
 36537,
 "nic-ras",
 "Latn",
}
m["taj"] = {
 "Eastern Tamang",
 12953177,
 "sit-tam",
 "sit-tam-Tibt, Deva",
 display_text = {["sit-tam-Tibt"] = s["Tibt-displaytext"]},
 entry_name = {["sit-tam-Tibt"] = s["Tibt-entryname"]},
}
m["tak"] = {
 "Tala",
 3914494,
 "cdc-wst",
 "Latn",
}
m["tal"] = {
 "Tal",
 3440387,
 "cdc-wst",
 "Latn",
}
m["tan"] = {
 "Tangale",
 529921,
 "cdc-wst",
 "Latn",
}
m["tao"] = {
 "Yami",
 715760,
 "phi",
 "Latn",
}
m["tap"] = {
 "Taabwa",
 7673650,
 "bnt-sbi",
 "Latn",
}
m["tar"] = {
 "Central Tarahumara",
 20090009,
 "azc-trc",
 "Latn",
 sort_key = {remove_diacritics = c.acute .. "ꞌ"},
}
m["tas"] = {
 "Tây Bồi",
 2233794,
 "crp",
 "Latn",
 ancestors = "fr",
 sort_key = s["roa-oil-sortkey"],
}
m["tau"] = {
 "Upper Tanana",
 28281,
 "ath-nor",
 "Latn",
}
m["tav"] = {
 "Tatuyo",
 2524007,
 "sai-tuc",
 "Latn",
}
m["taw"] = {
 "Tai",
 7675861,
 "ngf-mad",
 "Latn",
}
m["tax"] = {
 "Tamki",
 3449082,
 "cdc-est",
 "Latn",
}
m["tay"] = {
 "Atayal",
 715766,
 "map-ata",
 "Latn",
}
m["taz"] = {
 "Tocho",
 36680,
 "alv-tal",
 "Latn",
}
m["tba"] = {
 "Aikanã",
 3409307,
 "qfa-iso",
}
m["tbb"] = {
 "Tapeba",
 12953908,
}
m["tbc"] = {
 "Takia",
 3514336,
 "poz-oce",
}
m["tbd"] = {
 "Kaki Ae",
 6349417,
 "poz-ocw",
 "Latn",
}
m["tbe"] = {
 "Tanimbili",
 3515188,
 "poz-oce",
 "Latn",
}
m["tbf"] = {
 "Mandara",
 3285424,
 "poz-ocw",
 "Latn",
}
m["tbg"] = {
 "North Tairora",
 20210398,
 "paa-kag",
}
m["tbh"] = {
 "Thurawal",
 3537135,
 "aus-yuk",
}
m["tbi"] = {
 "Gaam",
 35338,
 "sdv-eje",
 "Latn",
}
m["tbj"] = {
 "Tiang",
 3528020,
 "poz-ocw",
 "Latn",
}
m["tbk"] = {
 "Calamian Tagbanwa",
 3915487,
 "phi-kal",
}
m["tbl"] = {
 "Tboli",
 7690594,
 "phi",
}
m["tbm"] = {
 "Tagbu",
 7675188,
 "nic-ser",
}
m["tbn"] = {
 "Barro Negro Tunebo",
 12953943,
 "cba",
}
m["tbo"] = {
 "Tawala",
 7689206,
 "poz-ocw",
 "Latn",
}
m["tbp"] = {
 "Taworta",
 7689337,
 "paa-lkp",
 "Latn",
}
m["tbr"] = {
 "Tumtum",
 3407029,
 "qfa-kad",
}
m["tbs"] = {
 "Tanguat",
 7683166,
 "paa",
 "Latn",
}
m["tbt"] = {
 "Kitembo",
 13123561,
 "bnt-shh",
 "Latn",
}
m["tbu"] = {
 "Tubar",
 56730,
 "azc-trc",
 "Latn",
}
m["tbv"] = {
 "Tobo",
 7811712,
 "ngf",
}
m["tbw"] = {
 "Tagbanwa",
 3915475,
 "phi",
 "Latn",
}
m["tbx"] = {
 "Kapin",
 6366665,
 "poz-ocw",
 "Latn",
}
m["tby"] = {
 "Tabaru",
 11732670,
 "paa-nha",
}
m["tbz"] = {
 "Ditammari",
 35186,
 "nic-eov",
}
m["tca"] = {
 "Ticuna",
 1815205,
 "sai-tyu",
 "Latn",
}
m["tcb"] = {
 "Tanacross",
 28268,
 "ath-nor",
 "Latn",
}
m["tcc"] = {
 "Datooga",
 35327,
 "sdv-nis",
 "Latn",
}
m["tcd"] = {
 "Tafi",
 36545,
 "alv-ktg",
}
m["tce"] = {
 "Southern Tutchone",
 31091048,
 "ath-nor",
 "Latn",
}
m["tcf"] = {
 "Malinaltepec Tlapanec",
 25559732,
 "omq",
 "Latn",
}
m["tcg"] = {
 "Tamagario",
 7680531,
 "ngf",
}
m["tch"] = {
 "Turks and Caicos Creole English",
 7855478,
 "crp",
 "Latn",
 ancestors = "en",
}
m["tci"] = {
 "Wára",
 20825638,
 "paa-yam",
}
m["tck"] = {
 "Tchitchege",
 36595,
 "bnt-tek",
}
m["tcl"] = {
 "Taman (Myanmar)",
 15616518,
 "sit-jnp",
 "Latn",
}
m["tcm"] = {
 "Tanahmerah",
 3514927,
 "ngf",
}
m["tco"] = {
 "Taungyo",
 12953186,
 "tbq-brm",
 ancestors = "obr",
}
m["tcp"] = {
 "Tawr Chin",
 7689338,
 "tbq-kuk",
}
m["tcq"] = {
 "Kaiy",
 6348709,
 "paa-lkp",
}
m["tcs"] = {
 "Torres Strait Creole",
 36648,
 "crp",
 "Latn",
 ancestors = "en",
}
m["tct"] = {
 "T'en",
 3442330,
 "qfa-kms",
}
m["tcu"] = {
 "Southeastern Tarahumara",
 36807,
 "azc-trc",
 "Latn",
}
m["tcw"] = {
 "Tecpatlán Totonac",
 7692795,
 "nai-ttn",
 "Latn",
}
m["tcx"] = {
 "Toda",
 34042,
 "dra",
}
m["tcy"] = {
 "Tulu",
 34251,
 "dra",
 "Mlym, Knda", -- Tigalari is not available. Mlym is nearer than Knda but both lack ɛ/ɛː.
 translit = {
  Mlym = "ml-translit",
  Knda = "kn-translit",
 },
}
m["tcz"] = {
 "Thado Chin",
 6583558,
 "tbq-kuk",
}
m["tda"] = {
 "Tagdal",
 36570,
 "son",
}
m["tdb"] = {
 "Panchpargania",
 21946879,
 "inc-eas",
 ancestors = "bh",
}
m["tdc"] = {
 "Emberá-Tadó",
 3052041,
 "sai-chc",
 "Latn",
}
m["tdd"] = {
 "Tai Nüa",
 36556,
 "tai-swe",
 "Tale",
 translit = "Tale-translit",
 entry_name = {remove_diacritics = c.ZWNJ .. c.ZWJ},
}
m["tde"] = {
 "Tiranige Diga Dogon",
 5313387,
 "nic-dgw",
}
m["tdf"] = {
 "Talieng",
 37525108,
 "mkh-ban",
}
m["tdg"] = {
 "Western Tamang",
 12953178,
 "sit-tam",
 "sit-tam-Tibt, Deva",
 display_text = {["sit-tam-Tibt"] = s["Tibt-displaytext"]},
 entry_name = {["sit-tam-Tibt"] = s["Tibt-entryname"]},
}
m["tdh"] = {
 "Thulung",
 56553,
 "sit-kiw",
}
m["tdi"] = {
 "Tomadino",
 7818197,
 "poz-btk",
 "Latn",
}
m["tdj"] = {
 "Tajio",
 7676870,
 "poz",
}
m["tdk"] = {
 "Tambas",
 3440392,
 "cdc-wst",
}
m["tdl"] = {
 "Sur",
 3914453,
 "nic-tar",
}
m["tdm"] = {
 "Taruma",
 nil,
}
m["tdn"] = {
 "Tondano",
 3531514,
 "phi",
}
m["tdo"] = {
 "Teme",
 3913994,
 "alv-mye",
}
m["tdq"] = {
 "Tita",
 3914899,
 "nic-bco",
}
m["tdr"] = {
 "Todrah",
 7812881,
 "mkh",
}
m["tds"] = {
 "Doutai",
 5302331,
 "paa-lkp",
}
m["tdt"] = {
 "Tetun Dili",
 12643484,
 "crp",
 "Latn",
 ancestors = "tet",
}
m["tdu"] = {
 "Tempasuk Dusun",
 3529155,
 "poz-san",
}
m["tdv"] = {
 "Toro",
 3438367,
 "nic-alu",
}
m["tdy"] = {
 "Tadyawan",
 7674700,
 "phi",
}
m["tea"] = {
 "Temiar",
 3914693,
 "mkh-asl",
}
m["teb"] = {
 "Tetete",
 7706087,
 "sai-tuc",
 "Latn",
}
m["tec"] = {
 "Terik",
 3518379,
 "sdv-nma",
}
m["ted"] = {
 "Tepo Krumen",
 11152243,
 "kro-grb",
}
m["tee"] = {
 "Huehuetla Tepehua",
 56455,
 "nai-ttn",
}
m["tef"] = {
 "Teressa",
 3518362,
 "aav-nic",
}
m["teg"] = {
 "Teke-Tege",
 36478,
 "bnt-tek",
}
m["teh"] = {
 "Tehuelche",
 33930,
 "sai-cho",
 "Latn",
}
m["tei"] = {
 "Torricelli",
 3450788,
 "qfa-tor",
}
m["tek"] = {
 "Ibali Teke",
 2802914,
 "bnt-tek",
}
m["tem"] = {
 "Temne",
 36613,
 "alv-mel",
}
m["ten"] = {
 "Tama (Colombia)",
 3832969,
 "sai-tuc",
 "Latn",
}
m["teo"] = {
 "Ateso",
 29474,
 "sdv-ttu",
 "Latn",
}
m["tep"] = {
 "Tepecano",
 3915525,
 "azc",
 "Latn",
}
m["teq"] = {
 "Temein",
 7698064,
 "sdv",
}
m["ter"] = {
 "Tereno",
 3314742,
 "awd",
 "Latn",
}
m["tes"] = {
 "Tengger",
 12473479,
 "poz",
}
m["tet"] = {
 "Tetum",
 34125,
 "poz-tim",
 "Latn",
}
m["teu"] = {
 "Soo",
 3437607,
 "ssa-klk",
}
m["tev"] = {
 "Teor",
 12953198,
 "poz-cma",
}
m["tew"] = {
 "Tewa",
 56492,
 "nai-kta",
 "Latn",
}
m["tex"] = {
 "Tennet",
 56346,
 "sdv",
}
m["tey"] = {
 "Tulishi",
 12911106,
 "qfa-kad",
 "Latn",
}
m["tez"] = {
 "Tetserret",
 7706841,
 "ber",
 "Latn",
}
m["tfi"] = {
 "Tofin Gbe",
 3530330,
 "alv-pph",
}
m["tfn"] = {
 "Dena'ina",
 27785,
 "ath-nor",
 "Latn",
}
m["tfo"] = {
 "Tefaro",
 7694618,
 "paa-egb",
}
m["tfr"] = {
 "Teribe",
 36533,
 "cba",
}
m["tft"] = {
 "Ternate",
 3518492,
 "paa-nha",
 "Latn, Arab",
}
m["tga"] = {
 "Sagalla",
 12953082,
 "bnt-cht",
}
m["tgb"] = {
 "Tobilung",
 12953913,
 "poz-san",
}
m["tgc"] = {
 "Tigak",
 3528276,
 "poz-ocw",
}
m["tgd"] = {
 "Ciwogai",
 3438799,
 "cdc-wst",
}
m["tge"] = {
 "Eastern Gorkha Tamang",
 12953175,
 "sit-tam",
 "sit-tam-Tibt, Deva",
 display_text = {["sit-tam-Tibt"] = s["Tibt-displaytext"]},
 entry_name = {["sit-tam-Tibt"] = s["Tibt-entryname"]},
}
m["tgf"] = {
 "Chali",
 3695197,
 "sit-ebo",
 "Tibt, Latn",
 translit = {Tibt = "Tibt-translit"},
 override_translit = true,
 display_text = {Tibt = s["Tibt-displaytext"]},
 entry_name = {Tibt = s["Tibt-entryname"]},
 sort_key = {Tibt = "Tibt-sortkey"},
}
m["tgh"] = {
 "Tobagonian Creole English",
 7811541,
 "crp",
 ancestors = "en",
}
m["tgi"] = {
 "Lawunuia",
 3219937,
 "poz-ocw",
}
m["tgn"] = {
 "Tandaganon",
 nil,
 "phi",
}
m["tgo"] = {
 "Sudest",
 7675351,
 "poz-ocw",
}
m["tgp"] = {
 "Tangoa",
 2410276,
 "poz-vnc",
 "Latn",
}
m["tgq"] = {
 "Tring",
 7842360,
 "poz-swa",
}
m["tgr"] = {
 "Tareng",
 25559541,
 "mkh",
}
m["tgs"] = {
 "Nume",
 3346290,
 "poz-vnc",
}
m["tgt"] = {
 "Central Tagbanwa",
 3915515,
 "phi",
 "Tagb",
}
m["tgu"] = {
 "Tanggu",
 7682930,
 "paa",
 "Latn",
}
m["tgv"] = {
 "Tingui-Boto",
 7808195,
 "sai-mje",
 "Latn",
}
m["tgw"] = {
 "Tagwana Senoufo",
 36514,
 "alv-tdj",
}
m["tgx"] = {
 "Tagish",
 28064,
 "ath-nor",
 "Latn",
}
m["tgy"] = {
 "Togoyo",
 36825,
 "nic-ser",
}
m["thc"] = {
 "Tai Hang Tong",
 7675753,
 "tai-nor",
}
m["thd"] = {
 "Kuuk Thaayorre",
 6448718,
 "aus-pmn",
 "Latn",
}
m["the"] = {
 "Chitwania Tharu",
 22083804,
 "inc-eas",
 ancestors = "pra-mag",
}
m["thf"] = {
 "Thangmi",
 7710314,
 "sit-new",
}
m["thh"] = {
 "Northern Tarahumara",
 15616395,
 "azc-trc",
 "Latn",
}
m["thi"] = {
 "Tai Long",
 25559562,
 "tai-swe",
}
m["thk"] = {
 "Tharaka",
 15407179,
 "bnt-kka",
}
m["thl"] = {
 "Dangaura Tharu",
 22083815,
 "inc-eas",
 ancestors = "pra-mag",
}
m["thm"] = {
 "Thavung",
 34780,
 "mkh-vie",
 "Thai", --Laoo is feasible but no evidence yet.
 sort_key = "Thai-sortkey",
}
m["thn"] = {
 "Thachanadan",
 7708880,
 "dra",
}
m["thp"] = {
 "Thompson",
 1755054,
 "sal",
}
m["thq"] = {
 "Kochila Tharu",
 22083826,
 "inc-eas",
 ancestors = "pra-mag",
}
m["thr"] = {
 "Rana Tharu",
 12953920,
 "inc-eas",
 ancestors = "pra-mag",
}
m["ths"] = {
 "Thakali",
 7709348,
 "sit-tam",
}
m["tht"] = {
 "Tahltan",
 30125,
 "ath-nor",
 "Latn",
}
m["thu"] = {
 "Thuri",
 7799291,
 "sdv-lon",
}
m["thy"] = {
 "Tha",
 3915849,
 "alv-bwj",
}
m["tic"] = {
 "Tira",
 36677,
 "alv-hei",
}
m["tif"] = {
 "Tifal",
 11732691,
 "ngf-okk",
}
m["tig"] = {
 "Tigre",
 34129,
 "sem-eth",
 "Ethi",
 translit = "Ethi-translit",
}
m["tih"] = {
 "Timugon Murut",
 7807680,
 "poz-san",
}
m["tii"] = {
 "Tiene",
 36469,
 "bnt-tek",
}
m["tij"] = {
 "Tilung",
 7803037,
 "sit-kiw",
}
m["tik"] = {
 "Tikar",
 36483,
 "nic-bdn",
 "Latn",
}
m["til"] = {
 "Tillamook",
 2109432,
 "sal",
}
m["tim"] = {
 "Timbe",
 7804599,
 "ngf",
}
m["tin"] = {
 "Tindi",
 36860,
 "cau-and",
 "Cyrl",
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {Cyrl = s["cau-Cyrl-entryname"]},
}
m["tio"] = {
 "Teop",
 3518239,
 "poz-ocw",
}
m["tip"] = {
 "Trimuris",
 7842270,
 "paa-tkw",
}
m["tiq"] = {
 "Tiéfo",
 3914874,
 "alv-sav",
}
m["tis"] = {
 "Masadiit Itneg",
 18748769,
 "phi",
}
m["tit"] = {
 "Tinigua",
 3029805,
}
m["tiu"] = {
 "Adasen",
 11214797,
 "phi",
}
m["tiv"] = {
 "Tiv",
 34131,
 "nic-tvc",
 "Latn",
}
m["tiw"] = {
 "Tiwi",
 1656014,
 "qfa-iso",
 "Latn",
}
m["tix"] = {
 "Southern Tiwa",
 7570552,
 "nai-kta",
 "Latn",
}
m["tiy"] = {
 "Tiruray",
 7809425,
 "phi",
 "Latn",
}
m["tiz"] = {
 "Tai Hongjin",
 3915716,
 "tai-swe",
}
m["tja"] = {
 "Tajuasohn",
 3915326,
 "kro-wkr",
}
m["tjg"] = {
 "Tunjung",
 3542117,
 "poz",
}
m["tji"] = {
 "Northern Tujia",
 12953229,
 "sit-tja",
}
m["tjl"] = {
 "Tai Laing",
 7675773,
 "tai-swe",
 "Mymr",
}
m["tjm"] = {
 "Timucua",
 638300,
 "qfa-iso",
}
m["tjn"] = {
 "Tonjon",
 3913372,
 "dmn-jje",
}
m["tjs"] = {
 "Southern Tujia",
 12633994,
 "sit-tja",
 "Latn",
}
m["tju"] = {
 "Tjurruru",
 3913834,
 "aus-nga",
 "Latn",
}
m["tjw"] = {
 "Chaap Wuurong",
 5285187,
 "aus-pam",
 "Latn",
}
m["tka"] = {
 "Truká",
 7847648,
}
m["tkb"] = {
 "Buksa",
 20983638,
 "inc-eas",
 ancestors = "pra-mag",
}
m["tkd"] = {
 "Tukudede",
 36863,
 "poz-tim",
 "Latn",
}
m["tke"] = {
 "Takwane",
 11030092,
 "bnt-mak",
 ancestors = "vmw",
}
m["tkf"] = {
 "Tukumanféd",
 42330115,
 "tup-gua",
 "Latn",
}
m["tkl"] = {
 "Tokelauan",
 34097,
 "poz-pnp",
 "Latn",
}
m["tkm"] = {
 "Takelma",
 56710,
}
m["tkn"] = {
 "Toku-No-Shima",
 3530484,
 "jpx-ryu",
 "Jpan",
 translit = s["Jpan-translit"],
 sort_key = s["Jpan-sortkey"],
}
m["tkp"] = {
 "Tikopia",
 36682,
 "poz-pnp",
 "Latn",
}
m["tkq"] = {
 "Tee",
 3075144,
 "nic-ogo",
 "Latn",
}
m["tkr"] = {
 "Tsakhur",
 36853,
 "cau-wsm",
 "Cyrl, Latn, Arab",
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
}
m["tks"] = {
 "Ramandi",
 25261947,
 "xme-ttc",
 ancestors = "xme-ttc-sou",
}
m["tkt"] = {
 "Kathoriya Tharu",
 22083822,
 "inc-eas",
 ancestors = "pra-mag",
}
m["tku"] = {
 "Upper Necaxa Totonac",
 56343,
 "nai-ttn",
 "Latn",
}
m["tkv"] = {
 "Mur Pano",
 nil,
 "poz-ocw",
 "Latn",
}
m["tkw"] = {
 "Teanu",
 3516731,
 "poz-oce",
 "Latn",
}
m["tkx"] = {
 "Tangko",
 7682993,
 "ngf-okk",
}
m["tkz"] = {
 "Takua",
 7678544,
 "mkh",
}
m["tla"] = {
 "Southwestern Tepehuan",
 3518245,
 "azc",
 "Latn",
}
m["tlb"] = {
 "Tobelo",
 1142333,
 "paa-nha",
}
m["tlc"] = {
 "Misantla Totonac",
 56460,
 "nai-ttn",
 "Latn",
}
m["tld"] = {
 "Talaud",
 7678964,
 "phi",
}
m["tlf"] = {
 "Telefol",
 7696150,
 "ngf-okk",
}
m["tlg"] = {
 "Tofanma",
 4461493,
 "paa-pau",
}
m["tlh"] = {
 "Klingon",
 10134,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["tli"] = {
 "Tlingit",
 27792,
 "xnd",
 "Latn, Cyrl",
}
m["tlj"] = {
 "Talinga-Bwisi",
 7679530,
 "bnt-haj",
}
m["tlk"] = {
 "Taloki",
 3514563,
 "poz-btk",
}
m["tll"] = {
 "Tetela",
 2613465,
 "bnt-tet",
}
m["tlm"] = {
 "Tolomako",
 3130514,
 "poz-vnc",
}
m["tln"] = {
 "Talondo'",
 7680293,
 "poz-ssw",
}
m["tlo"] = {
 "Talodi",
 36525,
 "alv-tal",
}
m["tlp"] = {
 "Filomena Mata-Coahuitlán Totonac",
 5449202,
 "nai-ttn",
 "Latn",
}
m["tlq"] = {
 "Tai Loi",
 7675784,
 "mkh-pal",
}
m["tlr"] = {
 "Talise",
 3514510,
 "poz-sls",
}
m["tls"] = {
 "Tambotalo",
 7681065,
 "poz-vnc",
}
m["tlt"] = {
 "Teluti",
 12953194,
 "poz-cma",
}
m["tlu"] = {
 "Tulehu",
 7852006,
 "poz-cma",
}
m["tlv"] = {
 "Taliabu",
 3514498,
 "poz-cma",
 "Latn",
}
m["tlx"] = {
 "Khehek",
 3196124,
 "poz-aay",
}
m["tly"] = {
 "Talysh",
 34318,
 "xme-ttc",
 "Latn, Cyrl, fa-Arab",
}
m["tma"] = {
 "Tama (Chad)",
 57001,
 "sdv-tmn",
}
m["tmb"] = {
 "Avava",
 2157461,
 "poz-vnc",
}
m["tmc"] = {
 "Tumak",
 3121045,
 "cdc-est",
}
m["tmd"] = {
 "Haruai",
 12632146,
 "ngf-mad",
}
m["tme"] = {
 "Tremembé",
 5246937,
}
m["tmf"] = {
 "Toba-Maskoy",
 3033544,
 "sai-mas",
 "Latn",
}
m["tmg"] = {
 "Ternateño",
 7232597,
}
m["tmh"] = {
 "Tuareg",
 34065,
 "ber",
 "Latn, Tfng, Arab",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.circ},
}
m["tmi"] = {
 "Tutuba",
 7857052,
 "poz-vnc",
}
m["tmj"] = {
 "Samarokena",
 7408865,
 "paa-tkw",
}
m["tmk"] = {
 "Northwestern Tamang",
 15616509,
 "sit-tam",
 "sit-tam-Tibt, Deva",
 display_text = {["sit-tam-Tibt"] = s["Tibt-displaytext"]},
 entry_name = {["sit-tam-Tibt"] = s["Tibt-entryname"]},
}
m["tml"] = {
 "Tamnim Citak",
 12643315,
 "ngf",
}
m["tmm"] = {
 "Tai Thanh",
 7675842,
 "tai-swe",
}
m["tmn"] = {
 "Taman (Indonesia)",
 7680671,
 "poz",
 "Latn",
}
m["tmo"] = {
 "Temoq",
 7698205,
 "mkh-asl",
}
m["tmq"] = {
 "Tumleo",
 7852641,
 "poz-ocw",
}
m["tms"] = {
 "Tima",
 36684,
 "nic-ktl",
}
m["tmt"] = {
 "Tasmate",
 7687571,
 "poz-vnc",
}
m["tmu"] = {
 "Iau",
 56867,
 "paa-lkp",
}
m["tmv"] = {
 "Motembo",
 11013108,
 "bnt-bun",
}
m["tmy"] = {
 "Tami",
 3514812,
 "poz-oce",
}
m["tmz"] = {
 "Tamanaku",
 3441435,
 "sai-ven",
 "Latn",
}
m["tna"] = {
 "Tacana",
 3182551,
 "sai-tac",
 "Latn",
}
m["tnb"] = {
 "Western Tunebo",
 3181238,
 "cba",
}
m["tnc"] = {
 "Tanimuca-Retuarã",
 36535,
 "sai-tuc",
 "Latn",
}
m["tnd"] = {
 "Angosturas Tunebo",
 25559604,
 "cba",
}
m["tne"] = {
 "Tinoc Kallahan",
 3192219,
}
m["tng"] = {
 "Tobanga",
 3440501,
 "cdc-est",
}
m["tnh"] = {
 "Maiani",
 6735243,
 "ngf-mad",
 "Latn",
}
m["tni"] = {
 "Tandia",
 7682454,
 "poz-hce",
 "Latn",
}
m["tnk"] = {
 "Kwamera",
 3200806,
 "poz-oce",
}
m["tnl"] = {
 "Lenakel",
 3229429,
 "poz-oce",
}
m["tnm"] = {
 "Tabla",
 7673105,
 "paa-sen",
}
m["tnn"] = {
 "North Tanna",
 957945,
 "poz-oce",
}
m["tno"] = {
 "Toromono",
 510544,
 "sai-tac",
 "Latn",
}
m["tnp"] = {
 "Whitesands",
 3063761,
 "poz-oce",
}
m["tnq"] = {
 "Taíno",
 5232952,
 "awd-taa",
 "Latn",
}
m["tnr"] = {
 "Bedik",
 35096,
 "alv-ten",
}
m["tns"] = {
 "Tenis",
 7699870,
 "poz-ocw",
}
m["tnt"] = {
 "Tontemboan",
 3531666,
 "phi",
 "Latn",
}
m["tnu"] = {
 "Tay Khang",
 6362363,
 "tai",
}
m["tnv"] = {
 "Tangchangya",
 7682361,
 "inc-eas",
 "Cakm",
 ancestors = "inc-obn",
}
m["tnw"] = {
 "Tonsawang",
 3531660,
 "phi",
}
m["tnx"] = {
 "Tanema",
 2106984,
 "poz-oce",
}
m["tny"] = {
 "Tongwe",
 7821200,
 "bnt",
}
m["tnz"] = {
 "Ten'edn",
 3073453,
 "mkh-asl",
 "Latn",
}
m["tob"] = {
 "Toba",
 3113756,
 "sai-guc",
 "Latn",
}
m["toc"] = {
 "Coyutla Totonac",
 15615591,
 "nai-ttn",
 "Latn",
}
m["tod"] = {
 "Toma",
 11055484,
 "dmn-msw",
}
m["tof"] = {
 "Gizrra",
 5565941,
}
m["tog"] = {
 "Tonga (Malawi)",
 3847648,
 "bnt-nys",
 "Latn",
}
m["toh"] = {
 "Tonga (Mozambique)",
 7820988,
 "bnt-bso",
}
m["toi"] = {
 "Tonga (Zambia)",
 34101,
 "bnt-bot",
}
m["toj"] = {
 "Tojolabal",
 36762,
 "myn",
}
m["tok"] = {
 "Toki Pona",
 36846,
 "art",
 "Latn",
 type = "appendix-constructed",
}
m["tol"] = {
 "Tolowa",
 20827,
 "ath-pco",
 "Latn",
}
m["tom"] = {
 "Tombulu",
 3531199,
 "phi",
}
m["too"] = {
 "Xicotepec de Juárez Totonac",
 8044353,
 "nai-ttn",
 "Latn",
}
m["top"] = {
 "Papantla Totonac",
 56329,
 "nai-ttn",
 "Latn",
}
m["toq"] = {
 "Toposa",
 3033588,
 "sdv-ttu",
}
m["tor"] = {
 "Togbo-Vara Banda",
 11002922,
 "bad-cnt",
}
m["tos"] = {
 "Highland Totonac",
 13154149,
 "nai-ttn",
 "Latn",
}
m["tou"] = {
 "Tho",
 22694631,
 "mkh-vie",
}
m["tov"] = {
 "Upper Taromi",
 12953183,
 "xme-ttc",
 ancestors = "xme-ttc-cen",
}
m["tow"] = {
 "Jemez",
 3912876,
 "nai-kta",
 "Latn",
}
m["tox"] = {
 "Tobian",
 34022,
 "poz-mic",
}
m["toy"] = {
 "Topoiyo",
 7824977,
 "poz-kal",
}
m["toz"] = {
 "To",
 7811216,
 "alv-mbm",
}
m["tpa"] = {
 "Taupota",
 7688832,
 "poz-ocw",
}
m["tpc"] = {
 "Azoyú Me'phaa",
 25559730,
 "omq",
}
m["tpe"] = {
 "Tippera",
 16115423,
 "tbq-bdg",
}
m["tpf"] = {
 "Tarpia",
 12953185,
 "poz-ocw",
}
m["tpg"] = {
 "Kula",
 6442714,
 "qfa-tap",
}
m["tpi"] = {
 "Tok Pisin",
 34159,
 "crp",
 "Latn",
 ancestors = "en",
}
m["tpj"] = {
 "Tapieté",
 3121063,
}
m["tpk"] = {
 "Tupinikin",
 33924,
 "tup-gua",
}
m["tpl"] = {
 "Tlacoapa Me'phaa",
 16115511,
 "omq",
}
m["tpm"] = {
 "Tampulma",
 36590,
 "nic-gnw",
}
m["tpn"] = {
 "Tupinambá",
 31528147,
 "tup-gua",
 "Latn",
}
m["tpo"] = {
 "Tai Pao",
 7675795,
 "tai-nor",
}
m["tpp"] = {
 "Pisaflores Tepehua",
 56349,
 "nai-ttn",
}
m["tpq"] = {
 "Tukpa",
 12953230,
 "sit-las",
}
m["tpr"] = {
 "Tuparí",
 3542217,
 "tup",
 "Latn",
}
m["tpt"] = {
 "Tlachichilco Tepehua",
 56330,
 "nai-ttn",
}
m["tpu"] = {
 "Tampuan",
 3514882,
 "mkh-ban",
}
m["tpv"] = {
 "Tanapag",
 3397371,
 "poz-mic",
}
m["tpw"] = {
 "Old Tupi",
 56944,
 "tup-gua",
 "Latn",
}
m["tpx"] = {
 "Acatepec Me'phaa",
 31157882,
 "omq",
}
m["tpy"] = {
 "Trumai",
 12294279,
 "qfa-iso",
}
m["tpz"] = {
 "Tinputz",
 3529205,
 "poz-ocw",
}
m["tqb"] = {
 "Tembé",
 10322157,
 "tup-gua",
 "Latn",
}
m["tql"] = {
 "Lehali",
 3229119,
 "poz-oce",
}
m["tqm"] = {
 "Turumsa",
 7856508,
 "paa",
}
m["tqn"] = {
 "Tenino",
 15699255,
 "nai-shp",
 "Latn",
 ancestors = "nai-spt",
}
m["tqo"] = {
 "Toaripi",
 7811403,
 "ngf",
}
m["tqp"] = {
 "Tomoip",
 3531388,
 "poz-ocw",
}
m["tqq"] = {
 "Tunni",
 3514343,
 "cus-som",
}
m["tqr"] = {
 "Torona",
 36679,
 "alv-tal",
}
m["tqt"] = {
 "Western Totonac",
 7116691,
 "nai-ttn",
 "Latn",
}
m["tqu"] = {
 "Touo",
 56750,
}
m["tqw"] = {
 "Tonkawa",
 2454881,
 "qfa-iso",
}
m["tra"] = {
 "Tirahi",
 3812406,
 "inc-dar",
}
m["trb"] = {
 "Terebu",
 7701797,
 "poz-ocw",
}
m["trc"] = {
 "Copala Triqui",
 12953935,
 "omq-tri",
 "Latn",
}
m["trd"] = {
 "Turi",
 7854914,
 "mun",
}
m["tre"] = {
 "East Tarangan",
 18609750,
 "poz",
}
m["trf"] = {
 "Trinidadian Creole English",
 7842493,
 "crp",
 ancestors = "en",
}
m["trg"] = {
 "Lishán Didán",
 56473,
 "sem-nna",
}
m["trh"] = {
 "Turaka",
 12953237,
 "ngf",
}
m["tri"] = {
 "Trió",
 56885,
 "sai-tar",
 "Latn",
}
m["trj"] = {
 "Toram",
 3441225,
 "cdc-est",
}
m["trl"] = {
 "Traveller Scottish",
 3915671,
}
m["trm"] = {
 "Tregami",
 34081,
 "nur-sou",
}
m["trn"] = {
 "Trinitario",
 3539279,
 "awd",
}
m["tro"] = {
 "Tarao",
 3515603,
 "tbq-kuk",
 "Latn",
}
m["trp"] = {
 "Kokborok",
 35947,
 "tbq-bdg",
}
m["trq"] = {
 "San Martín Itunyoso Triqui",
 12953934,
 "omq-tri",
 "Latn",
}
m["trr"] = {
 "Taushiro",
 1957508,
}
m["trs"] = {
 "Chicahuaxtla Triqui",
 3539587,
 "omq-tri",
 "Latn",
}
m["trt"] = {
 "Tunggare",
 615071,
 "paa-egb",
}
m["tru"] = {
 "Turoyo",
 34040,
 "sem-cna",
 "Syrc, Latn",
 entry_name = "Syrc-entryname",
 translit = "tru-translit",
}
m["trv"] = {
 "Taroko",
 716686,
 "map-ata",
 "Latn",
}
m["trw"] = {
 "Torwali",
 2665246,
 "inc-dar",
 "ur-Arab",
}
m["trx"] = {
 "Tringgus",
 7842365,
 "day",
}
m["try"] = {
 "Turung",
 7856514,
 "tai-swe",
 "as-Beng",
}
m["trz"] = {
 "Torá",
 7827518,
 "sai-cpc",
}
m["tsa"] = {
 "Tsaangi",
 36675,
 "bnt-nze",
}
m["tsb"] = {
 "Tsamai",
 2371358,
 "cus-eas",
}
m["tsc"] = {
 "Tswa",
 2085051,
 "bnt-tsr",
}
m["tsd"] = {
 "Tsakonian",
 220607,
 "grk",
 "Grek",
 ancestors = "grc-dor",
 translit = "el-translit",
 entry_name = {remove_diacritics = c.caron .. c.diaerbelow .. c.brevebelow},
 sort_key = s["Grek-sortkey"],
}
m["tse"] = {
 "Tunisian Sign Language",
 7853191,
 "sgn",
}
m["tsf"] = {
 "Southwestern Tamang",
 12953176,
 "sit-tam",
}
m["tsg"] = {
 "Tausug",
 34142,
 "phi",
 "Latn, Arab",
}
m["tsh"] = {
 "Tsuvan",
 3502326,
 "cdc-cbm",
}
m["tsi"] = {
 "Tsimshian",
 20085721,
 "nai-tsi",
}
m["tsj"] = {
 "Tshangla",
 36840,
 "sit-tsk",
 "Tibt, Latn, Deva",
 translit = {Tibt = "Tibt-translit"},
 override_translit = true,
 display_text = {Tibt = s["Tibt-displaytext"]},
 entry_name = {Tibt = s["Tibt-entryname"]},
 sort_key = {Tibt = "Tibt-sortkey"},
}
m["tsl"] = {
 "Ts'ün-Lao",
 3446675,
 "tai",
}
m["tsm"] = {
 "Turkish Sign Language",
 36885,
 "sgn",
}
m["tsp"] = {
 "Northern Toussian",
 11155635,
 "alv-sav",
}
m["tsq"] = {
 "Thai Sign Language",
 7709156,
 "sgn",
 "Sgnw",
}
m["tsr"] = {
 "Akei",
 2828964,
 "poz-vnc",
}
m["tss"] = {
 "Taiwan Sign Language",
 34019,
 "sgn-jsl",
}
m["tsu"] = {
 "Tsou",
 716681,
 "map",
 "Latn",
}
m["tsv"] = {
 "Tsogo",
 36674,
 "bnt-tso",
}
m["tsw"] = {
 "Tsishingini",
 13123571,
 "nic-kam",
}
m["tsx"] = {
 "Mubami",
 6930815,
 "ngf",
}
m["tsy"] = {
 "Tebul Sign Language",
 7692090,
 "sgn",
}
m["tta"] = {
 "Tutelo",
 2311602,
 "sio-ohv",
}
m["ttb"] = {
 "Gaa",
 3438361,
 "nic-dak",
}
m["ttc"] = {
 "Tektiteko",
 36686,
 "myn",
}
m["ttd"] = {
 "Tauade",
 7688634,
}
m["tte"] = {
 "Bwanabwana",
 5003667,
 "poz-ocw",
 "Latn",
}
m["ttf"] = {
 "Tuotomb",
 7853459,
 "nic-mbw",
 "Latn",
}
m["ttg"] = {
 "Tutong",
 3507990,
 "poz-swa",
 "Latn",
}
m["tth"] = {
 "Upper Ta'oih",
 3512660,
 "mkh-kat",
}
m["tti"] = {
 "Tobati",
 7811556,
 "poz-ocw",
 "Latn",
}
m["ttj"] = {
 "Tooro",
 7824218,
 "bnt-nyg",
 "Latn",
}
m["ttk"] = {
 "Totoro",
 3532756,
 "sai-bar",
 "Latn",
}
m["ttl"] = {
 "Totela",
 10962316,
 "bnt-bot",
 "Latn",
}
m["ttm"] = {
 "Northern Tutchone",
 20822,
 "ath-nor",
 "Latn",
}
m["ttn"] = {
 "Towei",
 7829606,
 "paa-pau",
}
m["tto"] = {
 "Lower Ta'oih",
 25559539,
 "mkh-kat",
}
m["ttp"] = {
 "Tombelala",
 6799663,
 "poz-kal",
}
m["ttr"] = {
 "Tera",
 56267,
 "cdc-cbm",
}
m["tts"] = {
 "Isan",
 33417,
 "tai-swe",
 "Thai",
 sort_key = "Thai-sortkey",
}
m["ttt"] = {
 "Tat",
 56489,
 "ira-swi",
 "Cyrl, Latn, Armn, fa-Arab",
 ancestors = "fa",
}
m["ttu"] = {
 "Torau",
 3532208,
 "poz-ocw",
}
m["ttv"] = {
 "Titan",
 3445811,
 "poz-aay",
}
m["ttw"] = {
 "Long Wat",
 7856961,
 "poz-swa",
}
m["tty"] = {
 "Sikaritai",
 7513600,
 "paa-lkp",
}
m["ttz"] = {
 "Tsum",
 12953223,
 "sit-kyk",
}
m["tua"] = {
 "Wiarumus",
 7998045,
 "qfa-tor",
 "Latn",
}
m["tub"] = {
 "Tübatulabal",
 56704,
 "azc",
 "Latn",
}
m["tuc"] = {
 "Mutu",
 3331003,
 "poz-ocw",
 "Latn",
}
m["tud"] = {
 "Tuxá",
 7857217,
}
m["tue"] = {
 "Tuyuca",
 2520538,
 "sai-tuc",
 "Latn",
}
m["tuf"] = {
 "Central Tunebo",
 12953942,
 "cba",
}
m["tug"] = {
 "Tunia",
 863721,
 "alv-bua",
}
m["tuh"] = {
 "Taulil",
 3516141,
 "paa-bng",
}
m["tui"] = {
 "Tupuri",
 36646,
 "alv-mbm",
 "Latn",
}
m["tuj"] = {
 "Tugutil",
 12953228,
 "paa-nha"
}
m["tul"] = {
 "Tula",
 3914907,
 "alv-wjk",
}
m["tum"] = {
 "Tumbuka",
 34138,
 "bnt-nys",
 "Latn",
}
m["tun"] = {
 "Tunica",
 56619,
 "qfa-iso",
 "Latn",
}
m["tuo"] = {
 "Tucano",
 3541834,
 "sai-tuc",
 "Latn",
}
m["tuq"] = {
 "Tedaga",
 36639,
 "ssa-sah",
}
m["tus"] = {
 "Tuscarora",
 36944,
 "iro-nor",
 "Latnx",
}
m["tuu"] = {
 "Tututni",
 20627,
 "ath-pco",
 "Latn",
}
m["tuv"] = {
 "Turkana",
 36958,
 "sdv-ttu",
 "Latn",
}
m["tux"] = {
 "Tuxináwa",
 7857204,
 "sai-pan",
 "Latn",
}
m["tuy"] = {
 "Tugen",
 3541935,
 "sdv-nma",
}
m["tuz"] = {
 "Turka",
 36643,
 "nic-gur",
 "Latn",
}
m["tva"] = {
 "Vaghua",
 3553248,
 "poz-ocw",
 "Latn",
}
m["tvd"] = {
 "Tsuvadi",
 3914936,
 "nic-kam",
}
m["tve"] = {
 "Te'un",
 7690709,
 "poz-cet",
 "Latn",
}
m["tvk"] = {
 "Southeast Ambrym",
 252411,
 "poz-vnc",
 "Latn",
}
m["tvl"] = {
 "Tuvaluan",
 34055,
 "poz-pnp",
 "Latn",
}
m["tvm"] = {
 "Tela-Masbuar",
 7695666,
 "poz-tim",
}
m["tvn"] = {
 "Tavoyan",
 7689158,
 "tbq-brm",
 "Mymr",
 ancestors = "obr",
}
m["tvo"] = {
 "Tidore",
 3528199,
 "paa-nha",
 "Latn, Arab",
}
m["tvs"] = {
 "Taveta",
 15632387,
 "bnt-par",
}
m["tvt"] = {
 "Tutsa Naga",
 7856987,
 "sit-tno",
}
m["tvu"] = {
 "Tunen",
 36632,
 "nic-mbw",
}
m["tvw"] = {
 "Sedoa",
 7445362,
 "poz-kal",
}
m["tvx"] = {
 "Taivoan",
 1975271,
 "map",
 "Latn",
}
m["tvy"] = {
 "Timor Pidgin",
 4904029,
 "crp",
 ancestors = "pt",
}
m["twa"] = {
 "Twana",
 7857412,
 "sal",
}
m["twb"] = {
 "Western Tawbuid",
 12953912,
 "phi",
}
m["twc"] = {
 "Teshenawa",
 3436597,
 "phi",
}
m["twe"] = {
 "Teiwa",
 3519302,
 "ngf",
 "Latn",
}
m["twf"] = {
 "Taos",
 7684320,
 "nai-kta",
 "Latn",
}
m["twg"] = {
 "Tereweng",
 12953200,
 "qfa-tap",
}
m["twh"] = {
 "Tai Dón",
 7675751,
 "tai-swe",
 "Tavt",
 --translit = "Tavt-translit",
 sort_key = {
  from = {"[꪿ꫀ꫁ꫂ]", "([ꪵꪶꪹꪻꪼ])([ꪀ-ꪯ])"},
  to = {"", "%2%1"}
 },
}
m["twm"] = {
 "Tawang Monpa",
 36586,
 "sit-ebo",
 "Tibt",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["twn"] = {
 "Twendi",
 7857682,
 "nic-mmb",
}
m["two"] = {
 "Tswapong",
 3446241,
 "bnt-sts",
}
m["twp"] = {
 "Ere",
 3056045,
 "poz-aay",
 "Latn",
}
m["twq"] = {
 "Tasawaq",
 36564,
 "son",
}
m["twr"] = {
 "Southwestern Tarahumara",
 12953909,
 "azc-trc",
 "Latn",
}
m["twt"] = {
 "Turiwára",
 3542307,
 "tup-gua",
 "Latn",
}
m["twu"] = {
 "Termanu",
 7702572,
 "poz-tim",
}
m["tww"] = {
 "Tuwari",
 7857159,
 "paa-spk",
}
m["twy"] = {
 "Tawoyan",
 3513542,
 "poz-bre",
}
m["txa"] = {
 "Tombonuo",
 7818692,
 "poz-san",
}
m["txb"] = {
 "Tocharian B",
 3199353,
 "ine-toc",
 "Latn",
 wikipedia_article = "Tocharian languages", -- wikidata id has no associated article
 standardChars = "AaÄäĀāCcEeIiKkLlMmṂṃNnṄṅÑñOoPpRrSsŚśṢṣTtUuWwYy" .. c.punc,
}
m["txc"] = {
 "Tsetsaut",
 20829,
 "ath-nor",
 "Latn",
}
m["txe"] = {
 "Totoli",
 7828387,
 "poz-tot",
 "Latn",
}
m["txg"] = {
 "Tangut",
 2727930,
 "sit-qia",
 "Tang",
 translit = "txg-translit",
}
m["txj"] = {
 "Tarjumo",
 nil,
 "ssa-sah",
 "Latn, Arab",
}
m["txh"] = {
 "Thracian",
 36793,
 "ine",
 "Latn, Grek",
 translit = "el-translit",
}
m["txi"] = {
 "Ikpeng",
 9344891,
 "sai-pek",
 "Latn",
}
m["txm"] = {
 "Tomini",
 7818911,
 "poz",
}
m["txn"] = {
 "West Tarangan",
 3515594,
 "poz",
}
m["txo"] = {
 "Toto",
 36709,
 "sit-dhi",
 "Beng, Toto"
}
m["txq"] = {
 "Tii",
 7801784,
 "poz-tim",
}
m["txr"] = {
 "Tartessian",
 36795,
}
m["txs"] = {
 "Tonsea",
 3531659,
 "phi",
}
m["txt"] = {
 "Citak",
 3447279,
 "ngf",
}
m["txu"] = {
 "Kayapó",
 3101212,
 "sai-nje",
 "Latn",
}
m["txx"] = {
 "Tatana",
 18643518,
 "poz-san",
}
m["tya"] = {
 "Tauya",
 7688978,
 "ngf-mad",
}
m["tye"] = {
 "Kyenga",
 3913304,
 "dmn-bbu",
 "Latn",
}
m["tyh"] = {
 "O'du",
 3347428,
 "mkh",
}
m["tyi"] = {
 "Teke-Tsaayi",
 33123613,
 "bnt-nze",
}
m["tyj"] = {
 "Tai Do",
 7675746,
 "tai-nor",
}
m["tyl"] = {
 "Thu Lao",
 12953921,
 "tai-cen",
}
m["tyn"] = {
 "Kombai",
 6428241,
 "ngf",
}
m["typ"] = {
 "Kuku-Thaypan",
 3915693,
 "aus-pmn",
 "Latn",
}
m["tyr"] = {
 "Tai Daeng",
 3915207,
 "tai-swe",
 "Tavt",
}
m["tys"] = {
 "Sapa",
 3446668,
 "tai-sap",
 "Latn",
}
m["tyt"] = {
 "Tày Tac",
 7862029,
 "tai-swe",
}
m["tyu"] = {
 "Kua",
 3832933,
 "khi-kal",
}
m["tyv"] = {
 "Tuvan",
 34119,
 "trk-sib",
 "Cyrl",
 translit = "tyv-translit",
 override_translit = true,
 sort_key = "tyv-sortkey",
}
m["tyx"] = {
 "Teke-Tyee",
 36634,
 "bnt-nze",
}
m["tyz"] = {
 "Tày", -- This does not mean its umbrella "Tai" languages.
 2511476,
 "tai-tay",
 "Latn, Hani",
 sort_key = {Hani = "Hani-sortkey"},
}
m["tza"] = {
 "Tanzanian Sign Language",
 7684177,
 "sgn",
}
m["tzh"] = {
 "Tzeltal",
 36808,
 "myn",
 "Latn",
}
m["tzj"] = {
 "Tz'utujil",
 36941,
 "myn",
 "Latn",
}
m["tzl"] = {
 "Talossan",
 1063911,
 "art",
 "Latn",
 type = "appendix-constructed",
 sort_key = "tzl-sortkey",
}
m["tzm"] = {
 "Central Atlas Tamazight",
 49741,
 "ber",
 "Tfng, Arab, Latn",
 translit = "Tfng-translit",
}
m["tzn"] = {
 "Tugun",
 12953225,
 "poz-tim",
}
m["tzo"] = {
 "Tzotzil",
 36809,
 "myn",
 "Latn",
}
m["tzx"] = {
 "Tabriak",
 56872,
 "paa-lsp",
 "Latn",
}
m["uam"] = {
 "Uamué",
 3441418,
}
m["uan"] = {
 "Kuan",
 6441085,
}
m["uar"] = {
 "Tairuma",
 7676386,
 "ngf",
}
m["uba"] = {
 "Ubang",
 3914467,
 "nic-ben",
 "Latn",
}
m["ubi"] = {
 "Ubi",
 56264,
}
m["ubl"] = {
 "Buhi'non Bikol",
 18664494,
 "phi",
}
m["ubr"] = {
 "Ubir",
 3547642,
 "poz-ocw",
 "Latn",
}
m["ubu"] = {
 "Umbu-Ungu",
 12953245,
 "ngf",
}
m["uby"] = {
 "Ubykh",
 36931,
 "cau-nwc",
 "Cyrl, Latn",
 translit = "uby-translit",
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
 sort_key = "uby-sortkey",
}
m["uda"] = {
 "Uda",
 11011951,
 "nic-lcr",
}
m["ude"] = {
 "Udihe",
 13235,
 "tuw",
 "Cyrl",
}
m["udg"] = {
 "Muduga",
 16886762,
 "dra",
 "Mlym",
 translit = "ml-translit",
}
m["udi"] = {
 "Udi",
 36867,
 "cau-esm",
 "Cyrl, Latn, Armn, Geor",
 ancestors = "xag",
 translit = {
  Cyrl = "udi-translit",
  Armn = "Armn-translit",
  Geor = "Geor-translit",
 },
 override_translit = true,
 display_text = {Cyrl = s["cau-Cyrl-displaytext"]},
 entry_name = {
  Cyrl = s["cau-Cyrl-entryname"],
  Latn = s["cau-Latn-entryname"],
 },
}
m["udj"] = {
 "Ujir",
 14916906,
 "poz-cet",
}
m["udl"] = {
 "Uldeme",
 3515078,
 "cdc-cbm",
}
m["udm"] = {
 "Udmurt",
 13238,
 "urj-prm",
 "Cyrl",
 translit = "udm-translit",
 override_translit = true,
 sort_key = "udm-sortkey",
}
m["udu"] = {
 "Uduk",
 3182573,
 "ssa-kom",
}
m["ues"] = {
 "Kioko",
 18343036,
}
m["ufi"] = {
 "Ufim",
 7877531,
 "ngf-fin",
 "Latn",
}
m["uga"] = {
 "Ugaritic",
 36928,
 "sem-nwe",
 "Ugar",
 translit = "uga-translit",
}
m["ugb"] = {
 "Kuku-Ugbanh",
 10549854,
}
m["uge"] = {
 "Ughele",
 966303,
 "poz-ocw",
}
m["ugn"] = {
 "Ugandan Sign Language",
 7877677,
 "sgn",
}
m["ugo"] = {
 "Gong",
 3448919,
 "tbq-lob",
 "Thai",
 sort_key = "Thai-sortkey",
}
m["ugy"] = {
 "Uruguayan Sign Language",
 7901470,
 "sgn",
}
m["uha"] = {
 "Uhami",
 3913328,
 "alv-nwd",
 "Latn",
}
m["uhn"] = {
 "Damal",
 4748974,
}
m["uis"] = {
 "Uisai",
 7878123,
 "paa-sbo",
}
m["uiv"] = {
 "Iyive",
 11128658,
 "nic-tvc",
 "Latn",
}
m["uji"] = {
 "Tanjijili",
 3914939,
 "nic-pls",
}
m["uka"] = {
 "Kaburi",
 6344482,
}
m["ukg"] = {
 "Ukuriguma",
 7878623,
 "ngf-mad",
}
m["ukh"] = {
 "Ukhwejo",
 36623,
 "bnt-bek",
}
m["ukk"] = {
 "Muak Sa-aak",
 nil,
 "mkh-pal",
}
m["ukl"] = {
 "Ukrainian Sign Language",
 10322106,
 "sgn",
}
m["ukp"] = {
 "Ukpe-Bayobiri",
 3914470,
 "nic-ben",
 "Latn",
}
m["ukq"] = {
 "Ukwa",
 7878635,
 "nic-ief",
}
m["uks"] = {
 "Kaapor Sign Language",
 3322101,
 "sgn",
}
m["uku"] = {
 "Ukue",
 3913387,
 "alv-nwd",
 "Latn",
}
m["ukw"] = {
 "Ukwuani-Aboh-Ndoni",
 36636,
 "alv",
 "Latn",
}
m["uky"] = {
 "Kuuk Yak",
 6448719,
 "aus-psw",
 "Latn",
}
m["ula"] = {
 "Fungwa",
 5509187,
 "nic-shi",
}
m["ulb"] = {
 "Olukumi",
 36722,
 "alv-yor",
 "Latn",
 entry_name = {Latn = {remove_diacritics = c.grave .. c.acute .. c.macron}},
 sort_key = {
  from = {"ch", "ẹ", "gb", "gh", "gw", "kp", "kw", "ọ", "ṣ"},
  to = {"c" .. p[1], "e" .. p[1], "g" .. p[1], "g" .. p[2], "g" .. p[3], "k" .. p[1], "k" .. p[2], "o" .. p[1], "s" .. p[1]}
 },
}
m["ulc"] = {
 "Ulch",
 13239,
 "tuw",
 "Cyrl, Latn",
 entry_name = {
  from = {"['’]"},
  to = {"ʼ"}
 },
 sort_key = "ulc-sortkey",
}
m["ule"] = {
 "Lule",
 12635889,
 nil,
 "Latn",
}
m["ulf"] = {
 "Afra",
 4477735,
 "paa-pau",
}
m["uli"] = {
 "Ulithian",
 36842,
 "poz-mic",
}
m["ulk"] = {
 "Meriam",
 788174,
 "ngf",
 "Latn",
}
m["ull"] = {
 "Ullatan",
 8761579,
 "dra",
}
m["ulm"] = {
 "Ulumanda'",
 3501892,
}
m["uln"] = {
 "Unserdeutsch",
 13244,
 "crp",
 "Latn",
 ancestors = "de",
}
m["ulu"] = {
 "Uma' Lung",
 3548186,
 "poz-swa",
}
m["ulw"] = {
 "Ulwa",
 2405552,
}
m["uma"] = {
 "Umatilla",
 12953952,
 "nai-shp",
 "Latn",
 ancestors = "nai-spt",
}
m["umb"] = {
 "Umbundu",
 36983,
 "bnt",
 "Latn",
}
m["umc"] = {
 "Marrucinian",
 36110,
 "itc-sbl",
 "Latn, Ital",
}
m["umd"] = {
 "Umbindhamu",
 7881346,
 "aus-pmn",
}
m["umg"] = {
 "Umbuygamu",
 3915677,
 "aus-pmn",
}
m["umi"] = {
 "Ukit",
 7878321,
}
m["umm"] = {
 "Umon",
 3915448,
 "nic-ucn",
 "Latn",
}
m["umn"] = {
 "Makyan Naga",
 6740516,
 "sit-kch",
}
m["umo"] = {
 "Umotína",
 7881740,
 "sai-mje",
}
m["ump"] = {
 "Umpila",
 12953954,
 "aus-pmn",
 "Latn",
}
m["umr"] = {
 "Umbugarla",
 2980392,
}
m["ums"] = {
 "Pendau",
 7162371,
 "poz-tot",
}
m["umu"] = {
 "Munsee",
 56547,
 "del",
 "Latn",
 entry_name = {remove_diacritics = c.acute .. c.breve},
}
m["una"] = {
 "North Watut",
 15887898,
 "poz-ocw",
 "Latn",
}
m["und"] = {
 "Undetermined",
 nil,
 "qfa-not",
 "All",
}
m["une"] = {
 "Uneme",
 3913357,
 "alv-yek",
 "Latn",
}
m["ung"] = {
 "Ngarinyin",
 1284885,
 "aus-wor",
 "Latn",
}
m["unk"] = {
 "Enawené-Nawé",
 3307184,
 "awd",
 "Latn",
}
m["unm"] = {
 "Unami",
 3549180,
 "del",
 "Latn",
 --[===[Don't strip diacritics from entry names, per [[WT:Grease pit/2020/May]].
 entry_name = {remove_diacritics = c.grave .. c.diaer},]===]
}
m["unn"] = {
 "Kurnai",
 nil,
 "aus-pam",
 "Latn",
}
m["unr"] = {
 "Mundari",
 3327828,
 "mun",
 "Deva",
 translit = "hi-translit", -- for now
}
m["unu"] = {
 "Unubahe",
 7897776,
}
m["unx"] = {
 "Munda",
 36264959,
 "mun",
 "Latn",
}
m["unz"] = {
 "Unde Kaili",
 12953596,
 "poz-kal",
 "Latn",
}
m["uok"] = {
 "Uokha",
 3441216,
 "alv-edo",
 "Latn",
}
m["uon"] = {
 "Kulon",
 11182000,
 "map",
 "Latn",
}
m["upi"] = {
 "Umeda",
 7881465,
 "paa-brd",
}
m["upv"] = {
 "Uripiv-Wala-Rano-Atchin",
 13249,
 "poz-vnc",
 "Latn",
}
m["ura"] = {
 "Urarina",
 1579560,
}
m["urb"] = {
 "Urubú-Kaapor",
 13893353,
 "tup-gua",
 "Latn",
}
m["urc"] = {
 "Urningangg",
 10710522,
}
m["ure"] = {
 "Uru",
 2992892,
}
m["urf"] = {
 "Uradhi",
 3915680,
 "aus-pam",
 "Latn",
}
m["urg"] = {
 "Urigina",
 7900603,
 "ngf",
 "Latn",
}
m["urh"] = {
 "Urhobo",
 36663,
 "alv-swd",
 "Latn",
}
m["uri"] = {
 "Urim",
 7900609,
 "qfa-tor",
 "Latn",
}
m["urk"] = {
 "Urak Lawoi'",
 7899573,
 "poz-mly",
 "Thai",
 sort_key = "Thai-sortkey",
}
m["url"] = {
 "Urali",
 7899602,
 "dra",
 "Knda",
}
m["urm"] = {
 "Urapmin",
 7899769,
 "ngf-okk",
}
m["urn"] = {
 "Uruangnirin",
 7901389,
 "poz-cet",
 "Latn",
}
m["uro"] = {
 "Ura (New Guinea)",
 3121049,
 "paa-bng",
 "Latn",
}
m["urp"] = {
 "Uru-Pa-In",
 7901376,
 "tup-gua",
 "Latn",
}
m["urr"] = {
 "Lehalurup",
 3272124,
}
m["urt"] = {
 "Urat",
 3502084,
 "qfa-tor",
 "Latn",
}
m["uru"] = {
 "Urumi",
 7901530,
 "tup",
 "Latn",
}
m["urv"] = {
 "Uruava",
 36875,
 "poz-ocw",
 "Latn",
}
m["urw"] = {
 "Sop",
 7562808,
 "ngf-mad",
 "Latn",
}
m["urx"] = {
 "Urimo",
 7900611,
 "qfa-tor",
 "Latn",
}
m["ury"] = {
 "Orya",
 7105295,
 "paa-tkw",
 "Latn",
}
m["urz"] = {
 "Uru-Eu-Wau-Wau",
 10266012,
 "tup-gua",
 "Latn",
}
m["usa"] = {
 "Usarufa",
 7901714,
 "paa-kag",
 "Latn",
}
m["ush"] = {
 "Ushojo",
 3540446,
 "inc-dar",
 "ur-Arab",
}
m["usi"] = {
 "Usui",
 12644231,
}
m["usk"] = {
 "Usaghade",
 3914048,
 "nic-lcr",
 "Latn",
}
m["usp"] = {
 "Uspanteco",
 36728,
 "myn",
 "Latn",
}
m["uss"] = {
 "Saare",
 nil,
 "nic-knn",
 "Latn",
}
m["usu"] = {
 "Uya",
 7904082,
}
m["uta"] = {
 "Otank",
 3913990,
 "nic-tvc",
 "Latn",
}
m["ute"] = {
 "Ute",
 13260,
 "azc-num",
 "Latn",
}
m["uth"] = {
 "Hun",
 nil,
 "nic-knn",
 "Latn",
}
m["utp"] = {
 "Aba",
 2841465,
 "poz-oce",
 "Latn",
}
m["utr"] = {
 "Etulo",
 35262,
 "alv-ido",
 "Latn",
}
m["utu"] = {
 "Utu",
 7903469,
 "ngf-mad",
}
m["uum"] = {
 "Urum",
 13257,
 "trk-kcu",
 "Cyrl",
}
m["uun"] = {
 "Kulon-Pazeh",
 36435,
 "map",
 "Latn",
}
m["uur"] = {
 "Ura (Vanuatu)",
 7899531,
 "poz-oce",
 "Latn",
}
m["uuu"] = {
 "U",
 953082,
 "mkh-pal",
}
m["uve"] = {
 "West Uvean",
 36837,
 "poz-pnp",
 "Latn",
}
m["uvh"] = {
 "Uri",
 7900540,
 "ngf-fin",
 "Latn",
}
m["uvl"] = {
 "Lote",
 3259972,
 "poz-ocw",
 "Latn",
}
m["uwa"] = {
 "Kuku-Uwanh",
 3915687,
 "aus-pmn",
}
m["uya"] = {
 "Doko-Uyanga",
 7904095,
 "nic-ucr",
 "Latn",
}
m["vaa"] = {
 "Vaagri Booli",
 7907798,
}
m["vae"] = {
 "Vale",
 3450194,
 "csu-val",
}
m["vag"] = {
 "Vagla",
 36637,
 "nic-gnw",
}
m["vah"] = {
 "Varhadi",
 155645,
 "inc-sou",
 "Deva, Modi",
 ancestors = "omr",
 translit = {
  Deva = "mr-translit",
  Modi = "mr-Modi-translit",
 },
 wikipedia_article = "Varhadi dialect"
}
m["vai"] = {
 "Vai",
 36939,
 "dmn-vak",
 "Vaii",
 translit = "Vaii-translit",
}
m["vaj"] = {
 "Sekele",
 56528,
}
m["val"] = {
 "Vehes",
 7918407,
}
m["vam"] = {
 "Vanimo",
 3327415,
 "paa-msk",
}
m["van"] = {
 "Valman",
 7912479,
 "qfa-tor",
}
m["vao"] = {
 "Vao",
 2160405,
 "poz-vnc",
}
m["vap"] = {
 "Vaiphei",
 56368,
 "tbq-kuk",
}
m["var"] = {
 "Huarijio",
 10974017,
 "azc-trc",
 "Latn",
}
m["vas"] = {
 "Vasavi",
 765418,
}
m["vau"] = {
 "Vanuma",
 7915259,
 "bnt-nya",
}
m["vav"] = {
 "Varli",
 7915983,
 "inc-sou",
 "Deva, Gujr",
}
m["vay"] = {
 "Vayu",
 7917585,
 "sit-kiw",
}
m["vbb"] = {
 "Southeast Babar",
 12952247,
 "poz-tim",
}
m["vbk"] = {
 "Southwestern Bontoc",
 nil,
 "phi",
 "Latn",
}
m["vec"] = {
 "Venetian",
 32724,
 "roa",
 "Latn",
}
m["ved"] = {
 "Veddah",
 2567934,
}
m["vem"] = {
 "Vemgo-Mabas",
 56268,
}
m["veo"] = {
 "Ventureño",
 56712,
 "nai-chu",
 "Latn",
}
m["vep"] = {
 "Veps",
 32747,
 "urj-fin",
 "Latn",
 sort_key = {
  from = {
   "č", "š", "ž", "ü", "ä", "ö", -- 2 chars
   "z", "'" -- 1 char
  },
  to = {
   "c" .. p[1], "s" .. p[1], "s" .. p[3], "y" .. p[1], "y" .. p[2], "y" .. p[3],
   "s" .. p[2], "y" .. p[4],
  }
 },
}
m["ver"] = {
 "Mom Jango",
 35862,
 "alv-dur",
}
m["vgr"] = {
 "Vaghri",
 7908480,
 "inc-bhi",
 "Gujr",
 translit = "gu-translit",
}
m["vgt"] = {
 "Flemish Sign Language",
 2107617,
 "sgn",
}
m["vic"] = {
 "Virgin Islands Creole",
 7933935,
 "crp",
 "Latn",
 ancestors = "en",
}
m["vid"] = {
 "Vidunda",
 7928151,
 "bnt-ruv",
}
m["vif"] = {
 "Vili",
 3558409,
 "bnt-kng",
}
m["vig"] = {
 "Viemo",
 36912,
 "alv-sav",
}
m["vil"] = {
 "Vilela",
 3409297,
}
m["vis"] = {
 "Vishavan",
 14916908,
 "dra",
}
m["vit"] = {
 "Viti",
 11011055,
 "nic-grf",
}
m["viv"] = {
 "Iduna",
 5989839,
 "poz-ocw",
}
m["vka"] = {
 "Kariyarra",
 13586632,
 "aus-nga",
 "Latn",
}
m["vki"] = {
 "Ija-Zuba",
 11011389,
 "nic-pls",
 ancestors = "uji",
}
m["vkj"] = {
 "Kujarge",
 33448,
}
m["vkk"] = {
 "Kaur",
 6378867,
}
m["vkl"] = {
 "Kulisusu",
 3200326,
 "poz-btk",
}
m["vkm"] = {
 "Kamakan",
 3192316,
 "sai-mje",
 "Latn",
}
m["vko"] = {
 "Kodeoha",
 3198209,
}
m["vkp"] = {
 "Korlai Creole Portuguese",
 3915520,
 "crp",
  "Latn",
 ancestors = "idb",
}
m["vkt"] = {
 "Tenggarong Kutai Malay",
 12683226,
}
m["vku"] = {
 "Kurrama",
 3915684,
 "aus-nga",
 "Latn",
}
m["vlp"] = {
 "Valpei",
 7912582,
 "poz-vnc",
}
m["vls"] = {
 "West Flemish",
 100103,
 "gmw",
 "Latn",
 ancestors = "dum",
}
m["vma"] = {
 "Martuthunira",
 975399,
 "aus-nga",
 "Latn",
}
m["vmb"] = {
 "Mbabaram",
 3303475,
 "aus-pam",
 "Latn",
}
m["vmc"] = {
 "Juxtlahuaca Mixtec",
 25559582,
 "omq-mxt",
 "Latn",
}
m["vmd"] = {
 "Mudu Koraga",
 12952656,
 "dra",
 "Knda",
}
m["vme"] = {
 "East Masela",
 18487451,
 "poz-tim",
}
m["vmf"] = {
 "East Franconian",
 497345,
 "gmw",
 "Latn",
 ancestors = "gmh",
 sort_key = "vmf-sortkey",
}
m["vmg"] = {
 "Minigir",
 17053237,
 "poz-ocw",
 "Latn",
}
m["vmh"] = {
 "Maraghei",
 36220,
 "xme-ttc",
 ancestors = "xme-ttc-eas",
}
m["vmi"] = {
 "Miwa",
 10586712,
 "aus-wor",
}
m["vmj"] = {
 "Ixtayutla Mixtec",
 6101163,
 "omq-mxt",
 "Latn",
}
m["vmk"] = {
 "Makhuwa-Shirima",
 2963909,
 "bnt-mak",
 "Latn",
 ancestors = "vmw",
}
m["vml"] = {
 "Malgana",
 6743201,
 "aus-psw",
 "Latn",
}
m["vmm"] = {
 "Mitlatongo Mixtec",
 6881813,
 "omq-mxt",
 "Latn",
}
m["vmp"] = {
 "Soyaltepec Mazatec",
 7572000,
 nil,
 "Latn",
}
m["vmq"] = {
 "Soyaltepec Mixtec",
 7572001,
 "omq-mxt",
 "Latn",
}
m["vmr"] = {
 "Marenje",
 11128833,
 ancestors = "vmw",
 "bnt-mak",
}
-- vms "Moskela" is extinct and unattested; see Wikipedia
m["vmu"] = {
 "Muluridyi",
 10590149,
}
m["vmv"] = {
 "Valley Maidu",
 5096458,
 "nai-mdu",
 "Latn",
}
m["vmw"] = {
 "Makhuwa",
 33882,
 "bnt-mak",
 "Latn",
}
m["vmx"] = {
 "Tamazola Mixtec",
 12953734,
 "omq-mxt",
 "Latn",
}
m["vmy"] = {
 "Ayautla Mazatec",
 14916912,
 nil,
 "Latn",
}
m["vmz"] = {
 "Mazatlán Mazatec",
 12953706,
 "omq-maz",
 "Latn",
}
m["vnk"] = {
 "Lovono",
 3211090,
 "poz-oce",
}
m["vnm"] = {
 "Neve'ei",
 2157431,
 "poz-vnc",
}
m["vnp"] = {
 "Vunapu",
 7943647,
 "poz-vnc",
}
m["vor"] = {
 "Voro",
 3914407,
 "alv-yun",
}
m["vot"] = {
 "Votic",
 32858,
 "urj-fin",
 "Latn",
 entry_name = {
  from = {"'"},
  to = {"ʹ"}
 }
}
m["vra"] = {
 "Vera'a",
 3555689,
 nil,
 "Latn",
}
m["vro"] = {
 "Võro",
 32762,
 "urj-fin",
 "Latn",
 wikimedia_codes = "fiu-vro",
}
m["vrs"] = {
 "Varisi",
 3554807,
 "poz-ocw",
}
m["vrt"] = {
 "Banam Bay",
 2928522,
 "poz-vnc",
}
m["vsi"] = {
 "Moldova Sign Language",
 12953478,
 "sgn",
}
m["vsl"] = {
 "Venezuelan Sign Language",
 3322064,
 "sgn",
}
m["vsv"] = {
 "Valencian Sign Language",
 32663,
 "sgn",
}
m["vto"] = {
 "Vitou",
 7937210,
 "paa-tkw",
}
m["vum"] = {
 "Vumbu",
 36629,
 "bnt-sir",
}
m["vun"] = {
 "Vunjo",
 12953261,
 "bnt-chg",
 "Latn",
}
m["vut"] = {
 "Vute",
 36897,
 "nic-mmb",
 "Latn",
}
m["vwa"] = {
 "Awa (China)",
 2874642,
 "mkh-pal",
}
m["waa"] = {
 "Walla Walla",
 12953960,
 "nai-shp",
 "Latn",
 ancestors = "nai-spt",
}
m["wab"] = {
 "Wab",
 11222271,
 "poz-ocw",
 "Latn",
}
m["wac"] = {
 "Wasco-Wishram",
 12645081,
 "nai-ckn",
 "Latn",
}
m["wad"] = {
 "Wandamen",
 2806128,
 "poz-hce",
 "Latn",
}
m["waf"] = {
 "Wakoná",
 7961205,
}
m["wag"] = {
 "Wa'ema",
 12953264,
 "poz-ocw",
 "Latn",
}
m["wah"] = {
 "Watubela",
 7975070,
 "poz-cma",
 "Latn",
}
m["waj"] = {
 "Waffa",
 3565058,
 "paa-kag",
 "Latn",
}
m["wal"] = {
 "Wolaytta",
 36943,
 "omv-nom",
}
m["wam"] = {
 "Massachusett",
 56519,
 "alg-eas",
 "Latn",
}
m["wan"] = {
 "Wan",
 3913272,
 "dmn-nbe",
}
m["wao"] = {
 "Wappo",
 56530,
}
m["wap"] = {
 "Wapishana",
 3450493,
 "awd",
 "Latn",
}
m["waq"] = {
 "Wageman",
 3436843,
 "aus-gun",
 "Latn",
}
m["war"] = {
 "Waray-Waray",
 34279,
 "phi",
 "Latn",
 entry_name = {Latn = {remove_diacritics = c.grave .. c.acute .. c.circ}},
 standardChars = {
  Latn = "AaBbKkDdEeGgHhIiLlMmNnOoPpRrSsTtUuWwYy",
  c.punc
 },
 sort_key = {
  Latn = "tl-sortkey",
 },
}
m["was"] = {
 "Washo",
 34198,
}
m["wat"] = {
 "Kaninuwa",
 12952565,
 "poz-ocw",
 "Latn",
}
m["wau"] = {
 "Wauja",
 3450522,
 "awd",
 "Latn",
}
m["wav"] = {
 "Waka",
 3913394,
 "alv-mye",
}
m["waw"] = {
 "Waiwai",
 56632,
 "sai-prk",
 "Latn",
}
m["wax"] = {
 "Watam",
 3566597,
 "paa",
 "Latn",
}
m["way"] = {
 "Wayana",
 5908753,
 "sai-gui",
 "Latn",
}
m["waz"] = {
 "Wampur",
 7966957,
 "poz-ocw",
 "Latn",
}
m["wba"] = {
 "Warao",
 36946,
 "qfa-iso",
 "Latn",
}
m["wbb"] = {
 "Wabo",
 7958701,
 "poz-hce",
 "Latn",
}
m["wbe"] = {
 "Waritai",
 7969453,
 "paa-lkp",
 "Latn",
}
m["wbf"] = {
 "Wara",
 3914052,
 "alv-wan",
}
m["wbh"] = {
 "Wanda",
 7967153,
 "bnt-mwi",
}
m["wbi"] = {
 "Wanji",
 3376818,
 "bnt-bki",
 "Latn",
}
m["wbj"] = {
 "Alagwa",
 56621,
 "cus-sou",
}
m["wbk"] = {
 "Waigali",
 34196,
 "nur-sou",
}
m["wbl"] = {
 "Wakhi",
 34208,
 "xsc-skw",
 "Cyrl, Latn, Arab",
 translit = {Cyrl = "tg-translit"},
}
m["wbm"] = {
 "Wa",
 12644869,
 "mkh-pal",
}
m["wbp"] = {
 "Warlpiri",
 1639998,
 "aus-pam",
 "Latn",
}
m["wbq"] = {
 "Waddar",
 6708569,
 "dra",
 ancestors = "te",
}
m["wbr"] = {
 "Wagdi",
 7959490,
 "inc-bhi",
}
m["wbt"] = {
 "Wanman",
 7967989,
}
m["wbv"] = {
 "Wajarri",
 3913856,
 "aus-psw",
 "Latn",
}
m["wbw"] = {
 "Woi",
 8029092,
 "poz-hce",
 "Latn",
}
m["wca"] = {
 "Yanomámi",
 7960056,
}
m["wci"] = {
 "Waci Gbe",
 36987,
 "alv-gbe",
}
m["wdd"] = {
 "Wandji",
 36976,
 "bnt-nze",
}
m["wdg"] = {
 "Wadaginam",
 7958930,
}
m["wdj"] = {
 "Wadjiginy",
 7959489,
}
m["wdt"] = {
 "Wendat",
 3567223,
 "iro-nor",
 "Latn",
 ancestors = "iro-ohu",
}
m["wdu"] = {
 "Wadjigu",
 10719025,
}
m["wdy"] = {
 "Wadjabangayi",
 nil,
}
m["wea"] = {
 "Wewaw",
 15895870,
}
m["wec"] = {
 "Wè Western",
 11159067,
 "kro-wee",
}
m["wed"] = {
 "Wedau",
 12953294,
 "poz-ocw",
 "Latn",
}
m["weh"] = {
 "Weh",
 7979690,
 "nic-rnw",
}
m["wei"] = {
 "Kiunum",
 7983230,
}
m["wem"] = {
 "Weme Gbe",
 18379970,
 "alv-gbe",
}
m["weo"] = {
 "Wemale",
 7982165,
 "poz-cma",
}
m["wer"] = {
 "Weri",
 11732752,
 "paa",
}
m["wes"] = {
 "Cameroon Pidgin",
 35541,
 "crp",
 "Latn",
 ancestors = "en",
}
m["wet"] = {
 "Perai",
 12953035,
 "poz-tim",
}
m["weu"] = {
 "Welaung",
 7980503,
 "tbq-kuk",
}
m["wew"] = {
 "Weyewa",
 4314526,
 "poz-cet",
 "Latn",
}
m["wfg"] = {
 "Yafi",
 8074520,
 "paa-pau",
}
m["wga"] = {
 "Wagaya",
 7959487,
 "aus-pam",
}
m["wgb"] = {
 "Wagawaga",
 7959485,
}
m["wgg"] = {
 "Wangganguru",
 7967859,
 "aus-kar",
 "Latn",
}
m["wgi"] = {
 "Wahgi",
 3565122,
}
m["wgo"] = {
 "Waigeo",
 7959937,
 "poz-hce",
}
m["wgu"] = {
 "Wirangu",
 2092286,
 "aus-pam",
 "Latn",
}
m["wgy"] = {
 "Warrgamay",
 3915942,
 "aus-pam",
 "Latn",
}
m["wha"] = {
 "Manusela",
 3287127,
 "poz-cma",
}
m["whg"] = {
 "North Wahgi",
 12953273,
 "ngf",
}
m["whk"] = {
 "Wahau Kenyah",
 7959737,
 "poz-swa",
}
m["whu"] = {
 "Wahau Kayan",
 12473397,
}
m["wib"] = {
 "Southern Toussian",
 11158982,
 "alv-sav",
}
m["wic"] = {
 "Wichita",
 56513,
 "cdd",
 "Latn",
}
m["wie"] = {
 "Wik-Epa",
 10720035,
 "aus-pmn",
}
m["wif"] = {
 "Wik-Keyangan",
 10720037,
 "aus-pmn",
}
m["wig"] = {
 "Wik-Ngathana",
 3915695,
 "aus-pmn",
}
m["wih"] = {
 "Wik-Me'anha",
 10720039,
 "aus-pmn",
}
m["wii"] = {
 "Minidien",
 6865237,
 "qfa-tor",
 "Latn",
}
m["wij"] = {
 "Wik-Iiyanh",
 10720036,
 "aus-pmn",
}
m["wik"] = {
 "Wikalkan",
 7999800,
 "aus-pmn",
}
m["wil"] = {
 "Wilawila",
 10720050,
 "aus-wor",
}
m["wim"] = {
 "Wik-Mungkan",
 2092246,
 "aus-pmn",
 "Latn",
}
m["win"] = {
 "Winnebago",
 1957108,
 "sio-msv",
 "Latn",
}
m["wir"] = {
 "Wiraféd",
 12953970,
 "tup-gua",
 "Latn",
}
m["wiu"] = {
 "Wiru",
 8027044,
 "paa",
}
m["wiv"] = {
 "Muduapa",
 3121040,
 "poz-ocw",
 "Latn",
}
m["wiy"] = {
 "Wiyot",
 36937,
 "aql",
 "Latn",
}
m["wja"] = {
 "Waja",
 3914415,
 "alv-wjk",
}
m["wji"] = {
 "Warji",
 3440381,
 "cdc-wst",
}
m["wka"] = {
 "Kw'adza",
 3807652,
 "cus-sou",
}
m["wkb"] = {
 "Kumbaran",
 16878146,
 "dra",
}
m["wkd"] = {
 "Mo",
 7960881,
 "poz-ocw",
 "Latn",
}
m["wkl"] = {
 "Kalanadi",
 6350515,
 "dra",
}
m["wku"] = {
 "Kunduvadi",
 6444383,
 "dra",
}
m["wkw"] = {
 "Wakawaka",
 10719110,
 "aus-pam",
}
m["wky"] = {
 "Wangkayutyuru",
 33060533,
 "aus-kar",
}
m["wla"] = {
 "Walio",
 7961958,
}
m["wlc"] = {
 "Mwali Comorian",
 3319155,
 "bnt-com",
 "Latn",
 sort_key = "bnt-com-sortkey",
}
m["wle"] = {
 "Wolane",
 12645275,
 "sem-eth",
}
m["wlg"] = {
 "Kunbarlang",
 5618523,
 "aus-gun",
 "Latn",
}
m["wli"] = {
 "Waioli",
 7960241,
 "paa-nha"
}
m["wlk"] = {
 "Wailaki",
 20832,
 "ath-pco",
 "Latn",
}
m["wll"] = {
 "Wali (Sudan)",
 30597440,
 "nub-hil",
}
m["wlm"] = {
 "Middle Welsh",
 2487263,
 "cel-bry",
 "Latn",
 ancestors = "owl",
 entry_name = {
  from = {"Ð", "ð"},
  to = {"D", "d"}
 },
 sort_key = "wlm-sortkey",
}
m["wlo"] = {
 "Wolio",
 1185114,
 "poz-wot",
 "Latn, Arab",
}
m["wlr"] = {
 "Wailapa",
 7960062,
 "poz-vnc",
 "Latn",
}
m["wls"] = {
 "Wallisian",
 36979,
 "poz-pnp",
 "Latn",
}
m["wlu"] = {
 "Wuliwuli",
 8039208,
}
m["wlv"] = {
 "Wichí Lhamtés Vejoz",
 13526867,
 "sai-wic",
 "Latn",
}
m["wlw"] = {
 "Walak",
 7961258,
}
m["wlx"] = {
 "Wali (Ghana)",
 36895,
 "nic-mre",
 "Latn",
}
m["wly"] = {
 "Waling",
 7961957,
 "sit-kic",
 ancestors = "bap",
}
m["wmb"] = {
 "Wambaya",
 2083197,
 "aus-mir",
}
m["wmc"] = {
 "Wamas",
 7966909,
 "ngf-mad",
}
m["wmd"] = {
 "Mamaindé",
 3284890,
 "sai-nmk",
 "Latn",
}
m["wme"] = {
 "Wambule",
 56785,
 "sit-kiw",
 "Latn",
}
m["wmh"] = {
 "Waima'a",
 7960132,
 "poz-tim",
 "Latn",
}
m["wmi"] = {
 "Wamin",
 7966934,
}
m["wmm"] = {
 "Maiwa (Indonesia)",
 6737226,
 "poz",
 "Latn",
}
m["wmn"] = {
 "Waamwang",
 7958575,
 "poz-cln",
 "Latn",
}
m["wmo"] = {
 "Wam",
 8030620,
 "qfa-tor",
 "Latn",
}
m["wms"] = {
 "Wambon",
 7966922,
 "ngf",
 "Latn",
}
m["wmt"] = {
 "Walmajarri",
 2232696,
 "aus-pam",
 "Latn",
}
m["wmw"] = {
 "Mwani",
 3042206,
 "bnt-swh",
 "Latn",
}
m["wmx"] = {
 "Womo",
 8031646,
 "paa-msk",
 "Latn",
}
m["wnb"] = {
 "Wanambre",
 7967057,
 "ngf",
 "Latn",
}
m["wnc"] = {
 "Wantoat",
 7968184,
 "ngf-fin",
 "Latn",
}
m["wnd"] = {
 "Wandarang",
 3913767,
 "aus-arn",
 "Latn",
}
m["wne"] = {
 "Waneci",
 7967334,
 "ira-pat",
 "ps-Arab",
}
m["wng"] = {
 "Wanggom",
 11732736,
 "ngf",
 "Latn",
}
m["wni"] = {
 "Ndzwani Comorian",
 2850262,
 "bnt-com",
 "Latn",
 sort_key = "bnt-com-sortkey",
}
m["wnk"] = {
 "Wanukaka",
 2370136,
 "poz",
 "Latn",
}
m["wnm"] = {
 "Wanggamala",
 7967860,
 "aus-kar",
 "Latn",
}
m["wno"] = {
 "Wano",
 3566166,
 "ngf",
 "Latn",
}
m["wnp"] = {
 "Wanap",
 7967060,
 "qfa-tor",
 "Latn",
}
m["wnu"] = {
 "Usan",
 7901709,
 "ngf",
 "Latn",
}
m["wnw"] = {
 "Wintu",
 56754,
 "nai-wtq",
 "Latn",
}
m["wny"] = {
 "Wanyi",
 7968201,
 "aus-gar",
 "Latn",
}
m["woa"] = {
 "Tyaraity",
 10706951,
}
m["wob"] = {
 "Wè Northern",
 3915363,
 "kro-wee",
}
m["woc"] = {
 "Wogeo",
 8029061,
 "poz-ocw",
 "Latn",
}
m["wod"] = {
 "Wolani",
 8029704,
 "ngf",
 "Latn",
}
m["woe"] = {
 "Woleaian",
 34037,
 "poz-mic",
 "Latn",
}
m["wog"] = {
 "Wogamusin",
 56991,
 "paa-spk",
 "Latn",
}
m["woi"] = {
 "Kamang",
 8029096,
 "ngf",
 "Latn",
}
m["wok"] = {
 "Longto",
 35795,
 "alv-dur",
 "Latn",
}
m["wom"] = {
 "Perema",
 3913378,
 "alv-lek",
 "Latn",
}
m["won"] = {
 "Wongo",
 8032058,
 "bnt-bsh",
 "Latn",
}
m["woo"] = {
 "Manombai",
 6751253,
 "poz",
 "Latn",
}
m["wor"] = {
 "Woria",
 8034514,
 "paa-egb",
 "Latn",
}
m["wos"] = {
 "Hanga Hundi",
 6450232,
 "paa-spk",
 "Latn",
}
m["wow"] = {
 "Wawonii",
 3566780,
 "poz-btk",
 "Latn",
}
m["wpc"] = {
 "Wirö",
 12953684,
 nil,
 "Latn",
}
m["wra"] = {
 "Warapu",
 56739,
 "paa-msk",
 "Latn",
}
m["wrb"] = {
 "Warluwara",
 3913761,
 "aus-pam",
 "Latn",
}
m["wrg"] = {
 "Warungu",
 7970854,
 "aus-pam",
 "Latn",
}
m["wrh"] = {
 "Wiradhuri",
 3913840,
 "aus-cww",
 "Latn",
}
m["wri"] = {
 "Wariyangga",
 10719289,
 "aus-psw",
 "Latn",
}
m["wrk"] = {
 "Garawa",
 2524022,
 "aus-gar",
 "Latn",
}
m["wrl"] = {
 "Warlmanpa",
 3913823,
 "aus-pam",
}
m["wrm"] = {
 "Warumungu",
 1764544,
 "aus-pam",
 "Latn",
}
m["wrn"] = {
 "Warnang",
 36971,
 "alv-hei",
}
m["wro"] = {
 "Worora",
 3504106,
 "aus-wor",
}
m["wrp"] = {
 "Waropen",
 7969851,
 "poz-hce",
 "Latn",
}
m["wrr"] = {
 "Wardaman",
 3913842,
 "aus-yng",
}
m["wrs"] = {
 "Waris",
 3502610,
 "paa-brd",
}
m["wru"] = {
 "Waru",
 3566463,
}
m["wrv"] = {
 "Waruna",
 7971078,
}
m["wrw"] = {
 "Gugu Warra",
 5615286,
}
m["wrx"] = {
 "Wae Rana",
 7959375,
}
m["wrz"] = {
 "Warray",
 7969971,
 "aus-gun",
}
m["wsa"] = {
 "Warembori",
 56459,
}
m["wsi"] = {
 "Wusi",
 8039349,
 "poz-vnc",
 "Latn",
}
m["wsk"] = {
 "Waskia",
 7972683,
 "ngf-mad",
 "Latn",
}
m["wsr"] = {
 "Owenia",
 7114727,
}
m["wss"] = {
 "Wasa",
 36914,
 "alv-ctn",
 ancestors = "ak",
}
m["wsu"] = {
 "Wasu",
 7972892,
}
m["wsv"] = {
 "Wotapuri-Katarqalai",
 3877569,
 "inc-dar",
}
m["wtf"] = {
 "Watiwa",
 35316,
 "ngf-mad",
 "Latn",
}
m["wth"] = {
 "Wathaurong",
 7974656,
 "aus-pam",
 "Latn",
}
m["wti"] = {
 "Berta",
 33178,
}
m["wtk"] = {
 "Watakataui",
 7972975,
 "paa-spk",
}
m["wtm"] = {
 "Mewati",
 2605943,
 "inc-wes",
}
m["wtw"] = {
 "Wotu",
 12473488,
}
m["wua"] = {
 "Wikngenchera",
 10720045,
 "aus-pmn",
}
m["wub"] = {
 "Wunambal",
 3913805,
 "aus-wor",
}
m["wud"] = {
 "Wudu",
 36972,
 "alv-gbe",
 "Latn",
}
m["wuh"] = {
 "Wutunhua",
 1012917,
 "crp",
 "Latn",
 ancestors = "cmn, bo, peh",
}
m["wul"] = {
 "Silimo",
 11732514,
 "ngf",
}
m["wum"] = {
 "Wumbvu",
 36891,
 "bnt-kel",
 "Latn",
}
m["wun"] = {
 "Bungu",
 4997686,
 "bnt-mby",
 "Latn",
}
m["wur"] = {
 "Wurrugu",
 8039305,
 "aus-wdj",
}
m["wut"] = {
 "Wutung",
 56743,
 "paa-msk",
 "Latn",
}
m["wuu"] = {
 "Wu",
 34290,
 "zhx",
 "Hani, Hant, Hans",
 ancestors = "ltc",
 generate_forms = "zh-generateforms",
 translit = "zh-translit",
 sort_key = "Hani-sortkey",
}
m["wuv"] = {
 "Wuvulu-Aua",
 3062746,
 "poz-aay",
}
m["wux"] = {
 "Wulna",
 13591670,
}
m["wuy"] = {
 "Wauyai",
 12953295,
 "poz-hce",
}
m["wwa"] = {
 "Waama",
 7958576,
 "nic-eov",
 "Latn",
}
m["wwo"] = {
 "Dorig",
 3037047,
 "poz-vnc",
}
m["wwr"] = {
 "Warrwa",
 7970852,
}
m["www"] = {
 "Wawa",
 36889,
 "nic-mmb",
 "Latn",
}
m["wxa"] = {
 "Waxianghua",
 2252191,
 "zhx",
 "Hani, Hant, Hans",
 generate_forms = "zh-generateforms",
 sort_key = "Hani-sortkey",
}
m["wxw"] = {
 "Wardandi",
 nil,
}
m["wya"] = {
 "Wyandot",
 1185119,
 "iro-nor",
 "Latn",
}
m["wyb"] = {
 "Ngiyambaa",
 3913825,
 "aus-cww",
 "Latn",
}
m["wyi"] = {
 "Woiwurrung",
 8029099,
 "aus-pam",
 "Latn",
}
m["wym"] = {
 "Vilamovian",
 56485,
 "gmw",
 "Latn",
 ancestors = "gmh",
 entry_name = {remove_diacritics = c.dotabove},
}
m["wyr"] = {
 "Wayoró",
 2875044,
 "tup",
}
m["wyy"] = {
 "Western Fijian",
 3062751,
 "poz-occ",
}
m["xaa"] = {
 "Andalusian Arabic",
 1137945,
 "sem-arb",
 "Arab, Latn",
 entry_name = {
  remove_diacritics = c.kashida .. c.fathatan .. c.dammatan .. c.kasratan .. c.fatha .. c.damma .. c.kasra .. c.shadda .. c.sukun .. c.superalef,
  from = {u(0x0671)},
  to = {u(0x0627)}
 },
}
m["xab"] = {
 "Sambe",
 36265,
 "nic-alu",
 "Latn",
}
m["xac"] = {
 "Kachari",
 3442442,
 "tbq-bdg",
}
m["xad"] = {
 "Adai",
 346744,
}
m["xae"] = {
 "Aequian",
 930579,
 "itc",
}
m["xag"] = {
 "Aghwan",
 34931,
 "cau-esm",
 "Aghb",
 translit = "Aghb-translit",
 override_translit = true,
}
m["xai"] = {
 "Kaimbé",
 6348017,
}
m["xaj"] = {
 "Ararandewára",
 nil,
 "tup-gua",
 "Latn",
}
m["xak"] = {
 "Maku",
 2032882,
 nil,
 "Latn",
}
m["xal"] = {
 "Kalmyk",
 33634,
 "xgn-cen",
 "Cyrl, xwo-Mong",
 ancestors = "xwo",
 translit = "xal-translit",
 override_translit = true,
 sort_key = "xal-sortkey",
}
m["xam"] = {
 "ǀXam",
 2086145,
 "khi-tuu",
 "Latn",
}
m["xan"] = {
 "Xamtanga",
 56527,
 "cus-cen",
}
m["xao"] = {
 "Khao",
 3196077,
 "mkh-pal",
}
m["xap"] = {
 "Apalachee",
 686501,
 "nai-mus",
 "Latn",
}
m["xaq"] = {
 "Aquitanian",
 500522,
 "euq",
 "Latn",
}
m["xar"] = {
 "Karami",
 11732281,
}
m["xas"] = {
 "Kamassian",
 35991,
 translit = "xas-translit",
 "syd",
 "Cyrl",
}
m["xat"] = {
 "Katawixi",
 3440512,
 "sai-ktk",
}
m["xau"] = {
 "Kauwera",
 6378983,
 "paa-tkw",
}
m["xav"] = {
 "Xavante",
 36962,
 "sai-cje",
 "Latn",
}
m["xaw"] = {
 "Kawaiisu",
 56338,
 "azc-num",
 "Latn",
}
m["xay"] = {
 "Kayan Mahakam",
 25337171,
}
m["xbb"] = {
 "Lower Burdekin",
 6693353,
}
m["xbc"] = {
 "Bactrian",
 756651,
 "ira-sbc",
 "Grek, Mani",
 translit = "xbc-translit",
 entry_name = {
  from = {"Þ", "þ"},
  to = {"Ϸ", "ϸ"}
 },
}
m["xbd"] = {
 "Bindal",
 4913975,
}
m["xbe"] = {
 "Bigambal",
 16841801,
 "aus-pam", --unclassified within
}
m["xbg"] = {
 "Bunganditj",
 4997615,
}
m["xbi"] = {
 "Kombio",
 6428259,
 "qfa-tor",
 "Latn",
}
m["xbj"] = {
 "Birrpayi",
 nil,
}
m["xbm"] = {
 "Middle Breton",
 787610,
 "cel-bry",
 "Latn",
 ancestors = "obt",
}
m["xbn"] = {
 "Kenaboi",
 6388752,
}
m["xbo"] = {
 "Bulgar",
 36880,
 "trk-ogr",
 "Arab, Grek",
 entry_name = {
  Arab = "ar-entryname",
 }
}
m["xbp"] = {
 "Bibbulman",
 22918391,
}
m["xbr"] = {
 "Kambera",
 3053279,
 "poz-cet",
 "Latn",
}
m["xbw"] = {
 "Kambiwá",
 9006744,
}
m["xby"] = {
 "Butchulla",
 31752631,
}
m["xcb"] = {
 "Cumbric",
 35965,
 "cel-bry",
}
m["xcc"] = {
 "Camunic",
 489011,
 nil,
 "Ital",
 translit = "Ital-translit",
}
m["xce"] = {
 "Celtiberian",
 37012,
 "cel",
 "Latn",
}
m["xch"] = {
 "Chemakum",
 56397,
 "chi",
 "Latn",
}
m["xcl"] = {
 "Old Armenian",
 181074,
 "hyx",
 "Armn",
 translit = "Armn-translit",
 override_translit = true,
 entry_name = {
  remove_diacritics = "՞՜՛՟",
  from = {"եւ"},
  to = {"և"}
 },
}
m["xcm"] = {
 "Comecrudo",
 609808,
 "nai-pak",
}
m["xcn"] = {
 "Cotoname",
 56889,
 "nai-pak",
}
m["xco"] = {
 "Khwarezmian",
 33138,
 "ira-sbc",
 "Arab, Armi, Chrs, Phlv, Sogd",
 translit = {Chrs = "Chrs-translit"},
}
m["xcr"] = {
 "Carian",
 35929,
 "ine-ana",
 "Cari",
}
m["xct"] = {
 "Classical Tibetan",
 5128314,
 "sit-tib",
 "Tibt, Hani, Marc, Mong, mnc-Mong, xwo-Mong, Phag, Tang, Zanb",
 translit = {
  Tibt = "Tibt-translit",
  Mong = "Mong-translit",
  ["mnc-Mong"] = "mnc-translit",
  ["xwo-Mong"] = "xwo-translit",
  Tang = "txg-translit",
 },
 override_translit = true,
 display_text = {
  Tibt = s["Tibt-displaytext"],
  Mong = s["Mong-displaytext"],
 },
 entry_name = {
  Tibt = s["Tibt-entryname"],
  Mong = s["Mong-entryname"],
 },
 sort_key = {
  Tibt = "Tibt-sortkey",
  Hani = "Hani-sortkey",
 },
}
m["xcu"] = {
 "Curonian",
 35857,
 "bat",
 "Latn",
}
m["xcv"] = {
 "Chuvan",
 3516641,
 "qfa-yuk",
 "Cyrl",
 translit = "xcv-translit"
}
m["xcw"] = {
 "Coahuilteco",
 2008062,
 "nai-pak",
}
m["xcy"] = {
 "Cayuse",
 2472016,
}
m["xda"] = {
 "Darkinjung",
 5223660,
 "aus-yuk",
 "Latn",
}
m["xdc"] = {
 "Dacian",
 682547,
 "ine",
 "Latn",
}
m["xdk"] = {
 "Dharug",
 1166814,
 "aus-yuk",
 "Latn",
}
m["xdm"] = {
 "Edomite",
 2363529,
 "sem-can",
 "Phnx",
 translit = "Phnx-translit",
}
m["xdy"] = {
 "Malayic Dayak",
 3514892,
}
m["xeb"] = {
 "Eblaite",
 35345,
 "sem-eas",
 "Xsux",
}
m["xed"] = {
 "Hdi",
 56246,
 "cdc-cbm",
 "Latn",
}
m["xeg"] = {
 "ǁXegwi",
 3509732,
 "khi-tuu",
 "Latn",
}
m["xel"] = {
 "Kelo",
 6386412,
 "sdv-eje",
}
m["xem"] = {
 "Kembayan",
 6386874,
}
m["xep"] = {
 "Epi-Olmec",
 nil,
}
m["xer"] = {
 "Xerénte",
 3073436,
 "sai-cje",
 "Latn",
}
m["xes"] = {
 "Kesawai",
 6394907,
 "ngf-mad",
 "Latn",
}
m["xet"] = {
 "Xetá",
 2980404,
 "tup-gua",
 "Latn",
}
m["xeu"] = {
 "Keoru-Ahia",
 11732313,
 "ngf",
}
m["xfa"] = {
 "Faliscan",
 35669,
 "itc",
 "Ital, Latn",
 translit = "Ital-translit",
 entry_name = {remove_diacritics = c.macron .. c.breve .. c.diaer},
}
m["xga"] = {
 "Galatian",
 27403,
 "cel",
 "Latn, Grek",
 ancestors = "cel-gau",
}
m["xgb"] = {
 "Gbin",
 16934745,
 "dmn-mse",
 "Latn",
}
m["xgd"] = {
 "Gudang",
 5614528,
}
m["xgf"] = {
 "Gabrielino-Fernandeño",
 56387,
 "azc-tak",
 "Latn",
}
m["xgg"] = {
 "Goreng",
 nil,
}
m["xgi"] = {
 "Garingbal",
 nil,
}
m["xgl"] = {
 "Galindan",
 1190494,
 "bat",
 "Latn",
}
m["xgm"] = {
 "Darumbal",
 16954400,
}
m["xgr"] = {
 "Garza",
 3098656,
 "nai-pak",
}
m["xgu"] = {
 "Unggumi",
 62000004,
 "aus-wor",
 "Latn",
}
m["xgw"] = {
 "Guwa",
 5621992,
}
m["xha"] = {
 "Harami",
 41506724,
 nil,
 "Sarb",
 translit = "Sarb-translit",
}
m["xhc"] = {
 "Hunnic",
 35959,
}
m["xhd"] = {
 "Hadrami",
 1032453,
 "sem-osa",
 "Sarb",
 translit = "Sarb-translit",
}
m["xhe"] = {
 "Khetrani",
 2614111,
 "inc-pan",
 ancestors = "lah",
}
m["xhm"] = {
 "Middle Khmer",
 25226861,
 "mkh-kmr",
 "Latnx, Khmr", --and also Pallava
 ancestors = "okz",
}
m["xhr"] = {
 "Hernican",
 5908773,
 "itc-sbl",
 "Ital",
}
m["xht"] = {
 "Hattic",
 31107,
 "qfa-iso",
 "Xsux",
}
m["xhu"] = {
 "Hurrian",
 35740,
 "qfa-hur",
 "Xsux, Ugar",
}
m["xhv"] = {
 "Khua",
 22970290,
 "mkh-kat",
}
m["xib"] = {
 "Iberian",
 855215,
 "qfa-iso",
 "Latn, Ibrn",
}
m["xii"] = {
 "Xiri",
 36876,
}
m["xin"] = {
 "Xinca",
 1546494,
 "nai-xin",
 "Latn",
}
m["xil"] = {
 "Illyrian",
 35976,
 "ine",
 type = "reconstructed",
}
m["xir"] = {
 "Xiriâna",
 2028772,
 "awd",
 "Latn",
}
m["xis"] = {
 "Kisan",
 nil,
}
m["xiv"] = {
 "Indus Valley Language",
 3428279,
 nil,
 "Inds",
}
m["xiy"] = {
 "Xipaya",
 13226,
 "tup",
}
m["xjb"] = {
 "Minjungbal",
 nil,
 "aus-pam",
 "Latn",
}
m["xka"] = {
 "Kalkoti",
 3877551,
 "inc-dar",
 "xka-Arab",
}
m["xkb"] = {
 "Manigri-Kambolé Ede Nago",
 36042,
 "alv-ede",
}
m["xkc"] = {
 "Khoini",
 6401919,
 "xme-ttc",
 ancestors = "xme-ttc-wes",
}
m["xkd"] = {
 "Mendalam Kayan",
 12952597,
}
m["xke"] = {
 "Kereho",
 6437086,
 "poz",
 "Latn",
}
m["xkf"] = {
 "Khengkha",
 3695207,
 "sit-ebo",
 "Tibt",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["xkg"] = {
 "Kagoro",
 11159524,
 "dmn-wmn",
}
m["xki"] = {
 "Kenyan Sign Language",
 6392859,
 "sgn",
}
m["xkj"] = {
 "Kajali",
 14916876,
 "xme-ttc",
 ancestors = "xme-ttc-cen",
}
m["xkk"] = {
 "Kaco'",
 6344767,
 "mkh",
}
m["xkl"] = {
 "Bakung",
 6736761,
 "poz-swa",
 "Latn",
}
m["xkn"] = {
 "Kayan River Kayan",
 12473395,
 "poz",
}
m["xko"] = {
 "Kiorr",
 6414519,
 "mkh-pal",
}
m["xkp"] = {
 "Kabatei",
 34165,
 "xme-ttc",
 ancestors = "xme-ttc-cen",
}
m["xkq"] = {
 "Koroni",
 3199000,
 "poz-btk",
}
m["xkr"] = {
 "Xakriabá",
 3073441,
 "sai-cje",
 "Latn",
}
m["xks"] = {
 "Kumbewaha",
 6443722,
}
m["xkt"] = {
 "Kantosi",
 35651,
 "nic-dag",
}
m["xku"] = {
 "Kaamba",
 11042324,
 "bnt-kng",
}
m["xkv"] = {
 "Kgalagadi",
 2088743,
 "bnt-sts",
 "Latn",
}
m["xkw"] = {
 "Kembra",
 12953627,
 "paa-pau",
}
m["xkx"] = {
 "Karore",
 6373260,
 "poz-ocw",
}
m["xky"] = {
 "Uma' Lasan",
 nil,
 "poz-swa",
}
m["xkz"] = {
 "Kurtöp",
 3695193,
 "sit-ebo",
 "Tibt, Latn",
 translit = {Tibt = "Tibt-translit"},
 display_text = {Tibt = s["Tibt-displaytext"]},
 entry_name = {Tibt = s["Tibt-entryname"]},
 sort_key = {Tibt = "Tibt-sortkey"},
}
m["xla"] = {
 "Kamula",
 10957277,
 "ngf",
}
m["xlb"] = {
 "Loup B",
 13108281,
 "alg-eas",
 "Latn",
}
m["xlc"] = {
 "Lycian",
 35969,
 "ine-ana",
 "Lyci",
 translit = "Lyci-translit",
}
m["xld"] = {
 "Lydian",
 36095,
 "ine-ana",
 "Lydi",
 translit = "Lydi-translit",
}
m["xle"] = {
 "Lemnian",
 36203,
 "qfa-tyn",
 "Ital",
 translit = "Ital-translit",
}
m["xlg"] = {
 "Ancient Ligurian",
 36104,
 "ine",
}
m["xli"] = {
 "Liburnian",
 35835,
 "ine",
}
--xln is etymology-only
m["xlo"] = {
 "Loup A",
 27921265,
 "alg-eas",
 "Latn",
}
m["xlp"] = {
 "Lepontic",
 35993,
 "cel",
 "Ital",
 translit = "Ital-translit",
}
m["xls"] = {
 "Lusitanian",
 35960,
 "ine",
 "Latn",
}
m["xlu"] = {
 "Luwian",
 12634577,
 "ine-ana",
 "Xsux, Hluw",
}
m["xly"] = {
 "Elymian",
 35329,
 nil,
 "Grek",
}
m["xmb"] = {
 "Mbonga",
 36064,
 "nic-jrn",
 "Latn",
}
m["xmc"] = {
 "Makhuwa-Marrevone",
 11127231,
 "bnt-mak",
 ancestors = "vmw",
}
m["xmd"] = {
 "Mbudum",
 6799790,
 "cdc-cbm",
 "Latn",
}
m["xmf"] = {
 "Mingrelian",
 13359,
 "ccs-zan",
 "Geor",
 translit = "Geor-translit",
 override_translit = true,
}
m["xmg"] = {
 "Mengaka",
 36017,
 "bai",
 "Latn",
}
m["xmh"] = {
 "Kugu-Muminh",
 10549849,
 "aus-pmn",
 "Latn",
}
m["xmj"] = {
 "Majera",
 6737666,
 "cdc-cbm",
 "Latn",
}
m["xmk"] = {
 "Ancient Macedonian",
 35974,
 "grk",
 "Polyt",
 translit = "grc-translit",
 entry_name = {remove_diacritics = c.macron .. c.breve},
 sort_key = s["Grek-sortkey"],
}
m["xml"] = {
 "Malaysian Sign Language",
 33420,
 "sgn",
}
m["xmm"] = {
 "Manado Malay",
 1068112,
}
m["xmo"] = {
 "Morerebi",
 12953749,
 "tup",
 "Latn",
}
m["xmp"] = {
 "Kuku-Mu'inh",
 10549852,
 nil,
 "Latn",
}
m["xmq"] = {
 "Kuku-Mangk",
 10549851,
 "aus-pam",
 "Latn",
}
m["xmr"] = {
 "Meroitic",
 13366,
 "afa",
 "Mero, Merc, Latn", -- we have entries in Latn
 translit = "xmr-translit",
}
m["xms"] = {
 "Moroccan Sign Language",
 6913107,
 "sgn",
}
m["xmt"] = {
 "Matbat",
 6786187,
 "poz-hce",
}
m["xmu"] = {
 "Kamu",
 6359779,
}
m["xmx"] = {
 "Maden",
 12952756,
 "poz-hce",
}
m["xmy"] = {
 "Mayaguduna",
 3436736,
}
m["xmz"] = {
 "Mori Bawah",
 3324069,
 "poz-btk",
 "Latn",
}
m["xna"] = {
 "Ancient North Arabian",
 1472213,
 "sem",
 "Narb",
 translit = "Narb-translit",
}
m["xnb"] = {
 "Kanakanabu",
 172244,
 "map",
 "Latn",
}
m["xng"] = {
 "Middle Mongol",
 2582455,
 "xgn",
 "Mong, Phag, Hani, Arab, Armn",
 translit = {Mong = "Mong-translit"},
 display_text = {Mong = s["Mong-displaytext"]},
 entry_name = {Mong = s["Mong-entryname"]},
 sort_key = {Hani = "Hani-sortkey"},
}
m["xnh"] = {
 "Kuanhua",
 6441084,
 "mkh-pal",
}
m["xni"] = {
 "Ngarigu",
 7022072,
 "aus-yuk",
}
m["xnk"] = {
 "Nganakarti",
 33087049,
}
m["xnn"] = {
 "Northern Kankanay",
 12953609,
 "phi",
}
-- "xno" IS TREATED AS "fro", SEE WT:LT
m["xnr"] = {
 "Kangri",
 2331560,
 "him",
 "Deva, Takr, fa-Arab",
 ancestors = "doi",
 translit = "hi-translit",
}
m["xns"] = {
 "Kanashi",
 6360672,
 "sit-whm",
}
m["xnt"] = {
 "Narragansett",
 3336118,
 "alg-eas",
 "Latn",
 entry_name = {remove_diacritics = c.grave .. c.acute .. c.tilde .. c.macron},
}
m["xnu"] = {
 "Nukunul",
 7068904,
}
m["xny"] = {
 "Nyiyaparli",
 16919427,
 "aus-nga",
 "Latn",
}
m["xoc"] = {
 "O'chi'chi'",
 3813833,
 "nic-cde",
 "Latn",
}
m["xod"] = {
 "Kokoda",
 6426734,
 "ngf-sbh",
}
m["xog"] = {
 "Soga",
 33784,
 "bnt-nyg",
 "Latn",
}
m["xoi"] = {
 "Kominimung",
 6428352,
 "paa",
 "Latn",
}
m["xok"] = {
 "Xokleng",
 3027930,
 "sai-sje",
}
m["xom"] = {
 "Komo",
 56681,
 "ssa-kom",
}
m["xon"] = {
 "Konkomba",
 35674,
 "nic-grm",
 "Latn",
}
m["xoo"] = { -- contrast kzw, sai-kat, sai-xoc
 "Xukurú",
 9096758,
}
m["xop"] = {
 "Kopar",
 11732346,
}
m["xor"] = {
 "Korubo",
 3199022,
}
m["xow"] = {
 "Kowaki",
 6434920,
 "ngf-mad",
}
m["xpa"] = {
 "Pirriya",
 16978087,
}
m["xpb"] = {
 "Pyemmairre",
 7262964,
 nil,
 "Latn",
}
m["xpc"] = {
 "Pecheneg",
 877881,
 "trk",
}
m["xpd"] = {
 "Paredarerme",
 7136678,
 nil,
 "Latn",
}
m["xpe"] = {
 "Liberia Kpelle",
 20527226,
 "dmn-msw",
 ancestors = "kpe",
}
m["xpf"] = {
 "Southeast Tasmanian",
 7068421,
 nil,
 "Latn",
}
m["xpg"] = {
 "Phrygian",
 36751,
 "ine",
 "Grek",
 translit = "grc-translit",
}
m["xph"] = {
 "Tyerrernotepanner",
 7859815,
 nil,
 "Latn",
}
m["xpi"] = {
 "Pictish",
 856383,
 "cel",
 "Ogam, Latn",
}
m["xpj"] = {
 "Mpalitjanh",
 6928192,
 "aus-pam",
}
m["xpk"] = {
 "Kulina",
 6443027,
 "sai-pan",
}
m["xpl"] = {
 "Port Sorell",
 7230944,
 nil,
 "Latn",
}
m["xpm"] = {
 "Pumpokol",
 2991985,
 "qfa-yen",
 "Latn",
}
m["xpn"] = {
 "Kapinawá",
 6366667,
}
m["xpo"] = {
 "Pochutec",
 2427341,
 "azc-nah",
 "Latn",
}
m["xpp"] = {
 "Puyo-Paekche",
 nil,
}
m["xpq"] = {
 "Mohegan-Pequot",
 3319130,
 "alg-eas",
 "Latn",
}
m["xpr"] = {
 "Parthian",
 25953,
 "ira-mpr",
 "Prti, Mani, Phlv",
 translit = {
  Prti = "Prti-translit",
  Mani = "Mani-translit",
 },
}
m["xps"] = {
 "Pisidian",
 36580,
 "ine-ana",
}
m["xpu"] = {
 "Punic",
 535958,
 "sem-can",
 "Phnx, Latn, Grek",
 ancestors = "phn",
 translit = {Phnx = "Phnx-translit"},
}
m["xpv"] = {
 "Tommeginne",
 7819095,
 nil,
 "Latn",
}
m["xpw"] = {
 "Peerapper",
 7160431,
 nil,
 "Latn",
}
m["xpx"] = {
 "Toogee",
 7824008,
 nil,
 "Latn",
}
m["xpy"] = {
 "Buyeo",
 5003359,
 "qfa-kor",
 "Hani",
 sort_key = "Hani-sortkey",
}
m["xpz"] = {
 "Bruny Island",
 4979601,
 nil,
 "Latn",
}
m["xqa"] = {
 "Karakhanid",
 nil,
 "trk-kar",
 "Arab",
 entry_name = "ar-entryname",
}
m["xqt"] = {
 "Qatabanian",
 384101,
 "sem-osa",
 "Sarb",
 translit = "Sarb-translit",
}
m["xra"] = {
 "Krahô",
 3199549,
 "sai-nje",
}
m["xrb"] = {
 "Eastern Karaboro",
 35716,
 "alv-krb",
}
m["xrd"] = {
 "Gundungurra",
 nil,
}
m["xre"] = {
 "Kreye",
 3199686,
 "sai-nje",
}
m["xrg"] = {
 "Minang",
 22893424,
}
m["xri"] = {
 "Krikati-Timbira",
 3199710,
}
m["xrm"] = {
 "Armazic",
 7599646,
}
m["xrn"] = {
 "Arin",
 34088,
 "qfa-yen",
 "Latn",
}
m["xrq"] = {
 "Karranga",
 6373349,
 nil,
 "Latn",
}
m["xrr"] = {
 "Raetic",
 36689,
 nil,
 "Ital",
 translit = "Ital-translit",
}
m["xrt"] = {
 "Aranama-Tamique",
 2859505,
}
m["xru"] = {
 "Marriammu",
 10577724,
 "aus-dal",
}
m["xrw"] = {
 "Karawa",
 6368857,
 "paa-spk",
}
m["xsa"] = {
 "Sabaean",
 1070391,
 "sem-osa",
 "Sarb",
 translit = "Sarb-translit",
}
m["xsb"] = {
 "Sambali",
 2592378,
 "phi",
 "Latn",
}
m["xsd"] = {
 "Sidetic",
 36659,
 "ine-ana",
}
m["xse"] = {
 "Sempan",
 3504358,
}
m["xsh"] = {
 "Shamang",
 3914876,
 "nic-plc",
}
m["xsi"] = {
 "Sio",
 3485100,
 "poz-ocw",
}
m["xsj"] = {
 "Subi",
 7631298,
 "bnt-haj",
}
m["xsl"] = {
 "South Slavey",
 28552,
 "den",
 "Latn",
}
m["xsm"] = {
 "Kasem",
 35552,
 "nic-gnn",
}
m["xsn"] = {
 "Sanga (Nigeria)",
 3915334,
 "nic-jer",
 "Latn",
}
m["xso"] = {
 "Solano",
 2474492,
 nil,
 "Latn",
}
m["xsp"] = {
 "Silopi",
 7515533,
 "ngf-mad",
}
m["xsq"] = {
 "Makhuwa-Saka",
 11008159,
 "bnt-mak",
 ancestors = "vmw",
}
m["xsr"] = {
 "Sherpa",
 36612,
 "sit-tib",
 "Tibt, Deva",
 ancestors = "xct",
 translit = {
  Tibt = "Tibt-translit",
  Deva = "xsr-Deva-translit",
 },
 override_translit = true,
 display_text = {Tibt = s["Tibt-displaytext"]},
 entry_name = {Tibt = s["Tibt-entryname"]},
 sort_key = {Tibt = "Tibt-sortkey"},
}
m["xss"] = {
 "Assan",
 34089,
 "qfa-yen",
 "Latn",
}
m["xsu"] = {
 "Sanumá",
 251728,
 "sai-ynm",
}
m["xsv"] = {
 "Sudovian",
 35603,
 "bat",
 "Latn",
}
m["xsy"] = {
 "Saisiyat",
 716695,
 "map",
 "Latn",
}
m["xta"] = {
 "Alcozauca Mixtec",
 25559587,
 "omq-mxt",
 "Latn",
}
m["xtb"] = {
 "Chazumba Mixtec",
 12182838,
 "omq-mxt",
 "Latn",
}
m["xtc"] = {
 "Kadugli",
 3407136,
 "qfa-kad",
 "Latn",
}
m["xtd"] = {
 "Diuxi-Tilantongo Mixtec",
 7802048,
 "omq-mxt",
 "Latn",
}
m["xte"] = {
 "Ketengban",
 10990152,
}
m["xth"] = {
 "Yitha Yitha",
 nil,
}
m["xti"] = {
 "Sinicahua Mixtec",
 12953733,
 "omq-mxt",
 "Latn",
}
m["xtj"] = {
 "San Juan Teita Mixtec",
 32093049,
 "omq-mxt",
 "Latn",
}
m["xtl"] = {
 "Tijaltepec Mixtec",
 12953738,
 "omq-mxt",
 "Latn",
}
m["xtm"] = {
 "Magdalena Peñasco Mixtec",
 7179700,
 "omq-mxt",
 "Latn",
}
m["xtn"] = {
 "Northern Tlaxiaco Mixtec",
 25559585,
 "omq-mxt",
 "Latn",
}
m["xto"] = {
 "Tocharian A",
 2827041,
 "ine-toc",
 "Latn",
 wikipedia_article = "Tocharian languages", -- wikidata id has no associated article
}
m["xtp"] = {
 "San Miguel Piedras Mixtec",
 7414970,
 "omq-mxt",
 "Latn",
}
m["xtq"] = {
 "Tumshuqese",
 nil,
 "xsc-sak",
 "Brah, Khar",
 translit = "Brah-translit",
}
m["xtr"] = {
 "Early Tripuri",
 nil,
}
m["xts"] = {
 "Sindihui Mixtec",
 13583581,
 "omq-mxt",
 "Latn",
}
m["xtt"] = {
 "Tacahua Mixtec",
 7673668,
 "omq-mxt",
 "Latn",
}
m["xtu"] = {
 "Cuyamecalco Mixtec",
 12953726,
 "omq-mxt",
 "Latn",
}
m["xtv"] = {
 "Thawa",
 7711494,
}
m["xtw"] = {
 "Tawandê",
 nil,
 "sai-nmk",
 "Latn",
}
m["xty"] = {
 "Yoloxochitl Mixtec",
 8054817,
 "omq-mxt",
 "Latn",
}
m["xtz"] = {
 "Tasmanian",
 530739,
 nil,
 "Latn",
}
m["xua"] = {
 "Alu Kurumba",
 12952679,
 "dra",
}
m["xub"] = {
 "Betta Kurumba",
 16841033,
 "dra",
 "Knda, Mlym, Taml",
}
m["xud"] = {
 "Umiida",
 61999874,
 "aus-wor",
 "Latn",
}
m["xug"] = {
 "Kunigami",
 56558,
 "jpx-ryu",
 "Jpan",
 translit = s["Jpan-translit"],
 sort_key = s["Jpan-sortkey"],
}
m["xuj"] = {
 "Jennu Kurumba",
 21282543,
 "dra",
}
m["xul"] = {
 "Ngunawal",
 7022712,
 "aus-yuk",
 "Latn",
}
m["xum"] = {
 "Umbrian",
 36957,
 "itc-sbl",
 "Ital, Latn",
 translit = "Ital-translit",
}
m["xun"] = {
 "Unggaranggu",
 61999823,
 "aus-wor",
 "Latn",
}
m["xuo"] = {
 "Kuo",
 6445233,
 "alv-mbm",
}
m["xup"] = {
 "Upper Umpqua",
 20607,
 "ath-pco",
 "Latn",
}
m["xur"] = {
 "Urartian",
 36934,
 "qfa-hur",
 "Xsux",
}
m["xut"] = {
 "Kuthant",
 6448417,
}
m["xuu"] = {
 "Khwe",
 28305,
 "khi-kal",
 "Latn",
}
m["xve"] = {
 "Venetic",
 36871,
 "ine",
 "Ital",
 translit = "Ital-translit",
}
-- m["xvi"] = { "Kamviri", 1193495, "nur-nor", Arab } moved to etym-only code
m["xvn"] = {
 "Vandalic",
 36835,
 "gme",
 "Latn",
}
m["xvo"] = {
 "Volscian",
 622110,
 "itc-sbl",
 "Latn",
}
m["xvs"] = {
 "Vestinian",
 2576407,
 "itc",
 "Latn",
}
m["xwa"] = {
 "Kwaza",
 3200839,
}
m["xwc"] = {
 "Woccon",
 3569569,
 "nai-cat",
 "Latn",
}
m["xwd"] = {
 "Wadi Wadi",
 7959249,
}
m["xwe"] = {
 "Xwela Gbe",
 36887,
 "alv-pph",
}
m["xwg"] = {
 "Kwegu",
 56723,
 "sdv",
}
m["xwj"] = {
 "Wajuk",
 33110188,
}
m["xwk"] = {
 "Wangkumara",
 7967891,
 "aus-pam",
 "Latn",
}
m["xwl"] = {
 "Western Xwla Gbe",
 36924,
 "alv-pph",
 "Latn",
}
m["xwo"] = {
 "Written Oirat",
 56959,
 "xgn-cen",
 "xwo-Mong",
 translit = "xwo-translit",
}
m["xwr"] = {
 "Kwerba Mamberamo",
 6450325,
 "paa-tkw",
}
m["xww"] = {
 "Wemba-Wemba",
 18472819,
 "aus-pam",
 "Latn",
}
m["xxb"] = {
 "Boro",
 16844787,
 nil,
 "Latn",
}
m["xxk"] = {
 "Ke'o",
 3195346,
}
m["xxm"] = {
 "Minkin",
 6867836,
}
m["xxr"] = {
 "Koropó",
 6432560,
}
m["xxt"] = {
 "Tambora",
 36711,
 "paa",
 "Latn",
}
m["xya"] = {
 "Yaygir",
 8050525,
 "aus-pam",
}
m["xyb"] = {
 "Yandjibara",
 nil,
 nil,
 "Latn",
}
m["xyl"] = {
 "Yalakalore",
 12645352,
 "sai-nmk",
 "Latn",
}
m["xyt"] = {
 "Mayi-Thakurti",
 47004719,
 "aus-pam",
 "Latn",
}
m["xyy"] = {
 "Yorta Yorta",
 8055849,
 "aus-pam",
 "Latn",
}
m["xzh"] = {
 "Zhang-Zhung",
 3437292,
 "sit-alm",
 "xzh-Tibt, Marc",
 display_text = {["xzh-Tibt"] = s["Tibt-displaytext"]},
 entry_name = {["xzh-Tibt"] = s["Tibt-entryname"]},
}
m["xzm"] = {
 "Zemgalian",
 47631,
 "bat",
}
m["xzp"] = {
 "Ancient Zapotec",
 nil,
}
m["yaa"] = {
 "Yaminahua",
 3026110,
 "sai-pan",
 "Latn",
}
m["yab"] = {
 "Yuhup",
 3573115,
 "sai-nad",
 "Latn",
}
m["yac"] = {
 "Pass Valley Yali",
 12953309,
 "ngf",
 "Latn",
}
m["yad"] = {
 "Yagua",
 3182567,
 nil,
 "Latn",
}
m["yae"] = {
 "Pumé",
 3121835,
 nil,
 "Latn",
}
m["yaf"] = {
 "Yaka",
 35588,
 "bnt-yak",
 "Latn",
}
m["yag"] = {
 "Yámana",
 531826,
 "qfa-iso",
 "Latn",
}
m["yah"] = {
 "Yazghulami",
 34186,
 "ira-shy",
 "Latn, Cyrl",
 translit = "yah-translit",
}
m["yai"] = {
 "Yagnobi",
 34247,
 "ira-sgc",
 "Latn, Cyrl",
 translit = "tg-translit",
}
m["yaj"] = {
 "Banda-Yangere",
 8048561,
 "bad",
}
m["yak"] = {
 "Yakima",
 35976053,
 "nai-shp",
 "Latn",
 ancestors = "nai-spt",
}
m["yal"] = {
 "Yalunka",
 35524,
 "dmn-sya",
}
m["yam"] = {
 "Yamba",
 36904,
 "nic-nka",
 "Latn",
}
m["yan"] = {
 "Mayangna",
 3302929,
 "nai-min",
 "Latn",
}
m["yao"] = {
 "Yao",
 36902,
 "bnt-rvm",
 "Latn",
}
m["yap"] = {
 "Yapese",
 34029,
 "poz-oce",
 "Latn",
}
m["yaq"] = {
 "Yaqui",
 34191,
 "azc-trc",
 "Latn",
}
m["yar"] = {
 "Yabarana",
 3571238,
 "sai-map",
 "Latn",
}
m["yas"] = {
 "Gunu",
 36358,
 "nic-ymb",
 "Latn",
}
m["yat"] = {
 "Yambeta",
 8048020,
 "nic-mbw",
 "Latn",
}
m["yau"] = {
 "Yuwana",
 5876347,
}
m["yav"] = {
 "Yangben",
 12953315,
 "nic-ymb",
 "Latn",
}
m["yaw"] = {
 "Yawalapití",
 3450709,
 "awd",
 "Latn",
}
m["yay"] = {
 "Agwagwune",
 34736,
 "nic-ucn",
 "Latn",
}
m["yaz"] = {
 "Lokaa",
 3914439,
 "nic-uce",
 "Latn",
}
m["yba"] = {
 "Yala",
 3914920,
 "alv-ido",
 "Latn",
}
m["ybb"] = {
 "Yemba",
 36917,
 "bai",
 "Latn",
}
m["ybe"] = {
 "Western Yugur",
 34224,
 "trk-sib",
 ancestors = "oui",
}
m["ybh"] = {
 "Yakkha",
 56666,
 "sit-kie",
 "Deva",
}
m["ybi"] = {
 "Yamphu",
 56316,
 "sit-kie",
 "Deva",
 translit = "ybi-translit",
} 
m["ybj"] = {
 "Hasha",
 3915338,
 "nic-alu",
}
m["ybk"] = {
 "Bokha",
 nil,
 "tbq-lol",
}
m["ybl"] = {
 "Yukuben",
 3915846,
 "nic-ykb",
}
m["ybm"] = {
 "Yaben",
 8046372,
 "ngf-mad",
}
m["ybn"] = {
 "Yabaâna",
 3450534,
 "awd",
 "Latn",
}
m["ybo"] = {
 "Yabong",
 8046383,
 "ngf-mad",
}
m["ybx"] = {
 "Yawiyo",
 8050463,
 "paa-spk",
}
m["yby"] = {
 "Yaweyuha",
 3571231,
 "paa-kag",
}
m["ych"] = {
 "Chesu",
 nil,
 "tbq-lol",
}
m["ycl"] = {
 "Lolopo",
 56441,
 "tbq-lol",
}
m["ycn"] = {
 "Yucuna",
 3438356,
 "awd-nwk",
 "Latn",
}
m["ycp"] = {
 "Chepya",
 46603077,
 "tbq-lol",
}
m["ycr"] = {
 "Yilan Creole",
 10955036,
 "crp",
 "Latn",
}
m["yda"] = {
 "Yanda",
 8048318,
 "aus-pam",
}
m["yde"] = {
 "Yangum Dey",
 nil,
 "qfa-tor",
 "Latn",
}
m["ydg"] = {
 "Yidgha",
 34179,
 "ira-mny",
 "Arab",
}
m["ydk"] = {
 "Yoidik",
 8054512,
 "ngf-mad",
}
m["yea"] = {
 "Ravula",
 7296830,
 "dra",
 "Knda, Mlym",
 translit = {
  Knda = "kn-translit",
  Mlym = "ml-translit",
 },
}
m["yec"] = {
 "Yeniche",
 1365342,
 "gmw",
 "Latn",
 ancestors = "gmh",
}
m["yee"] = {
 "Yimas",
 36954,
 "paa-lsp",
}
m["yei"] = {
 "Yeni",
 34213,
 "nic-mmb",
}
m["yej"] = {
 "Yevanic",
 34200,
 "grk",
 "Hebr",
 ancestors = "gkm",
 entry_name = {remove_diacritics = u(0x0591) .. "-" .. u(0x05BD) .. u(0x05BF) .. "-" .. u(0x05C5) .. u(0x05C7)},
}
m["yen"] = {
 "Yendang",
 nil,
 "alv-mye",
 "Latn",
}
m["yer"] = {
 "Tarok",
 3914953,
 "nic-tar",
 "Latn",
}
m["yes"] = {
 "Yeskwa",
 3914962,
 "nic-plc",
 "Latn",
}
m["yet"] = {
 "Yetfa",
 8053020,
 "paa-pau",
}
m["yeu"] = {
 "Yerukula",
 3535117,
 "dra",
}
m["yev"] = {
 "Yapunda",
 11044384,
 "qfa-tor",
 "Latn",
}
m["yey"] = {
 "Yeyi",
 8053347,
 "bnt",
}
m["ygi"] = {
 "Yiningayi",
 nil,
 "aus-pam",
}
m["ygl"] = {
 "Yangum Gel",
 nil,
 "qfa-tor",
 "Latn",
}
m["ygm"] = {
 "Yagomi",
 20771657,
 "ngf-fin",
 "Latn",
}
m["ygp"] = {
 "Gepo",
 5548692,
 "tbq-lol",
}
m["ygr"] = {
 "Yagaria",
 8046690,
 "paa-kag",
 "Latn",
}
m["ygs"] = {
 "Yolngu Sign Language",
 16211970,
 "sgn",
}
m["ygu"] = {
 "Yugul",
 8060437,
 "aus-arn",
}
m["ygw"] = {
 "Yagwoia",
 8046761,
 "ngf",
 "Latn",
}
m["yha"] = {
 "Baha",
 2879238,
 "qfa-kra",
}
m["yhl"] = {
 "Hlepho Phowa",
 nil,
 "tbq-lol",
}
m["yia"] = {
 "Yinggarda",
 3913777,
 "aus-psw",
 "Latn",
}
m["yif"] = {
 "Ache",
 10949828,
 "tbq-lol",
}
m["yig"] = {
 "Wusa Nasu",
 12953334,
 "tbq-lol",
}
m["yii"] = {
 "Yidiny",
 3053283,
 "aus-yid",
 "Latn",
}
m["yij"] = {
 "Yindjibarndi",
 3121073,
 "aus-nga",
 "Latn",
}
m["yik"] = {
 "Dongshanba Lalo",
 12953333,
 "tbq-lal",
}
m["yil"] = {
 "Yindjilandji",
 10723541,
 "aus-pam",
 "Latn",
}
m["yim"] = {
 "Yimchungru Naga",
 56348,
 "sit-aao",
 "Latn",
}
m["yin"] = {
 "Yinchia",
 12953981,
 "mkh-pal",
}
m["yip"] = {
 "Pholo",
 7187103,
 "tbq-lol",
}
m["yiq"] = {
 "Miqie",
 6827993,
 "tbq-lol",
}
m["yir"] = {
 "North Awyu",
 12642164,
 "ngf",
}
m["yis"] = {
 "Yis",
 8053831,
 "qfa-tor",
 "Latn",
}
m["yit"] = {
 "Eastern Lalu",
 12953328,
 "tbq-lal",
}
m["yiu"] = {
 "Awu",
 11163308,
 "tbq-lol",
}
m["yiv"] = {
 "Northern Nisu",
 25559454,
 "tbq-lol",
}
m["yix"] = {
 "Axi",
 4830439,
 "tbq-lol",
}
m["yiy"] = {
 "Yir-Yoront",
 8053819,
 "aus-pmn",
 "Latn",
}
m["yiz"] = {
 "Azhe",
 4832535,
 "tbq-lol",
}
m["yka"] = {
 "Yakan",
 3571351,
 "poz-sbj",
}
m["ykg"] = {
 "Northern Yukaghir",
 56319,
 "qfa-yuk",
 "Cyrl",
 translit = "ykg-translit",
}
m["ykh"] = {
 "Khamnigan Mongol",
 3196052,
 "xgn-cen",
 "Mong, Latn, Cyrl",
 translit = {Mong = "Mong-translit"},
 display_text = {Mong = s["Mong-displaytext"]},
 entry_name = {Mong = s["Mong-entryname"]},
}
m["yki"] = {
 "Yoke",
 3832977,
}
m["ykk"] = {
 "Yakaikeke",
 8047041,
 "poz-oce",
}
m["ykl"] = {
 "Khlula",
 6401849,
 "tbq-lol",
}
m["ykm"] = {
 "Kap",
 8047048,
 "poz-ocw",
 "Latn",
}
m["ykn"] = {
 "Kua-nsi",
 6440952,
 "tbq-lol",
}
m["yko"] = {
 "Yasa",
 36899,
 "bnt-yko",
 "Latn",
}
m["ykr"] = {
 "Yekora",
 11732781,
 "ngf",
}
m["ykt"] = {
 "Kathu",
 6377155,
 "sit-mnz",
}
m["yku"] = {
 "Kuamasi",
 6441074,
 "tbq-lol",
}
m["yky"] = {
 "Yakoma",
 3571364,
 "nic-ngd",
}
m["yla"] = {
 "Yaul",
 8050336,
 "paa",
 "Latn",
}
m["ylb"] = {
 "Yaleba",
 37710600,
 "poz-oce",
}
m["yle"] = {
 "Yele",
 36942,
}
m["ylg"] = {
 "Yelogu",
 8052024,
 "paa-spk",
}
m["yli"] = {
 "Angguruk Yali",
 3514481,
 "ngf",
}
m["yll"] = {
 "Yil",
 3501797,
 "qfa-tor",
 "Latn",
}
m["ylm"] = {
 "Limi",
 12953327,
 "tbq-lol",
}
m["yln"] = {
 "Langnian Buyang",
 2929025,
 "qfa-buy",
}
m["ylo"] = {
 "Naruo",
 6961032,
 "tbq-lol",
}
m["ylr"] = {
 "Yalarnnga",
 3915686,
 "aus-pam",
 "Latn",
}
m["ylu"] = {
 "Aribwaung",
 11044246,
 "poz-ocw",
 "Latn",
}
m["yly"] = {
 "Nyâlayu",
 303154,
 "poz-cln",
 "Latn",
}
m["ymb"] = {
 "Yambes",
 8048022,
 "qfa-tor",
 "Latn",
}
m["ymc"] = {
 "Southern Muji",
 nil,
 "tbq-lol",
}
m["ymd"] = {
 "Muda",
 6931494,
 "tbq-lol",
}
m["yme"] = {
 "Yameo",
 3121032,
}
m["ymg"] = {
 "Yamongeri",
 11008893,
 "bnt-mon",
 "Latn",
 ancestors = "lol",
}
m["ymh"] = {
 "Mili",
 12953329,
 "tbq-lol",
}
m["ymi"] = {
 "Moji",
 6895060,
 "tbq-lol",
}
m["ymk"] = {
 "Makwe",
 6740513,
 "bnt-swh",
}
m["yml"] = {
 "Iamalele",
 8047849,
 "poz-ocw",
 "Latn",
}
m["ymm"] = {
 "Maay",
 36221,
 "cus-som",
 "Latn",
}
m["ymn"] = {
 "Sunum",
 8048083,
 "poz-ocw",
 "Latn",
}
m["ymo"] = {
 "Yangum Mon",
 nil,
 "qfa-tor",
 "Latn",
}
m["ymp"] = {
 "Yamap",
 8047913,
 "poz-ocw",
 "Latn",
}
m["ymq"] = {
 "Qila Muji",
 nil,
 "tbq-lol",
}
m["ymr"] = {
 "Malasar",
 16889525,
 "dra",
}
m["yms"] = {
 "Mysian",
 2577228,
 "ine",
}
m["ymx"] = {
 "Northern Muji",
 nil,
 "tbq-lol",
}
m["ymz"] = {
 "Muzi",
 6944445,
 "tbq-lol",
}
m["yna"] = {
 "Aluo",
 4737539,
 "tbq-lol",
}
m["ynd"] = {
 "Yandruwandha",
 8048335,
 "aus-kar",
 "Latn",
}
m["yne"] = {
 "Lang'e",
 6485577,
 "tbq-lol",
}
m["yng"] = {
 "Yango",
 13123599,
 "nic-nkk",
 "Latn",
}
m["ynk"] = {
 "Naukanski",
 27963,
 "ypk",
 "Cyrl, Latn",
}
m["ynl"] = {
 "Yangulam",
 8048663,
 "ngf-mad",
}
m["ynn"] = {
 "Yana",
 56419,
 "qfa-iso",
}
m["yno"] = {
 "Yong",
 8054978,
 "tai-swe",
 "Lana, Thai",
 sort_key = "nod-sortkey",
}
m["yns"] = {
 "Yansi",
 36953,
 "bnt-yak",
}
m["ynu"] = {
 "Yahuna",
 8050347,
 "sai-tuc",
}
m["yob"] = {
 "Yoba",
 8054220,
 "poz-ocw",
 "Latn",
}
m["yog"] = {
 "Yogad",
 8054343,
 "phi",
}
m["yoi"] = {
 "Yonaguni",
 34243,
 "jpx-ryu",
 "Jpan",
 translit = s["Jpan-translit"],
 sort_key = s["Jpan-sortkey"],
}
m["yol"] = {
 "Yola",
 56395,
 "gmw",
 "Latn",
 ancestors = "enm",
}
m["yom"] = {
 "Yombe",
 10961975,
 "bnt-kng",
 "Latn",
}
m["yon"] = {
 "Yongkom",
 8055002,
 "ngf-okk",
}
m["yox"] = {
 "Yoron",
 2424943,
 "jpx-ryu",
 "Jpan",
 translit = s["Jpan-translit"],
 sort_key = s["Jpan-sortkey"],
}
m["yoy"] = {
 "Yoy",
 3503717,
 "tai",
}
m["ypa"] = {
 "Phala",
 36211907,
 "tbq-lol",
}
m["ypb"] = {
 "Labo Phowa",
 nil,
 "tbq-lol",
}
m["ypg"] = {
 "Phola",
 nil,
 "tbq-lol",
}
m["yph"] = {
 "Phupha",
 7188378,
 "tbq-lol",
}
m["ypm"] = {
 "Phuma",
 nil,
 "tbq-lol",
}
m["ypn"] = {
 "Ani Phowa",
 33590104,
 "tbq-lol",
}
m["ypo"] = {
 "Alo Phola",
 33522157,
 "tbq-lol",
}
m["ypp"] = {
 "Phupa",
 48565467,
 "tbq-lol",
}
m["ypz"] = {
 "Phuza",
 48565339,
 "tbq-lol",
}
m["yra"] = {
 "Yerakai",
 8052531,
}
m["yrb"] = {
 "Yareba",
 3571876,
 "ngf",
}
m["yre"] = {
 "Yaouré",
 3913951,
 "dmn-mda",
}
m["yri"] = {
 "Yarí",
 8049616,
}
m["yrk"] = {
 "Tundra Nenets",
 36452,
 "syd",
 "Cyrl",
 entry_name = {
  from = {"ӑ", "а̄", "э̇", "ӣ", "ы̄", "ӯ", "ю̄", "я̆", "я̄"},
  to = {"а", "а", "э", "и", "ы", "у", "ю", "я", "я"},
 },
 translit = "yrk-translit",
}
m["yrl"] = {
 "Nheengatu",
 34333,
 "tup-gua",
 ancestors = "tpw",
}
m["yrn"] = {
 "Yerong",
 3572191,
 "qfa-buy",
}
m["yro"] = {
 "Yaroamë",
 24190396,
 "sai-ynm",
 "Latn",
}
m["yrw"] = {
 "Yarawata",
 8049237,
 "ngf-mad",
}
m["yry"] = {
 "Yarluyandi",
 33061540,
 "aus-kar",
}
m["ysc"] = {
 "Jassic",
 2479368,
 "xsc",
 "Latn",
 ancestors = "oos",
}
m["ysd"] = {
 "Samatao",
 7408902,
 "tbq-lol",
}
m["ysg"] = {
 "Sonaga",
 7560736,
 "tbq-lol",
}
m["ysl"] = {
 "Yugoslavian Sign Language",
 8060373,
 "sgn",
}
m["ysn"] = {
 "Sani",
 1055287,
 "tbq-lol",
 "Yiii",
}
m["yso"] = {
 "Nisi",
 12953326,
 "sit-mnz",
}
m["ysp"] = {
 "Southern Lolopo",
 12633989,
 "tbq-lol",
}
m["ysr"] = {
 "Sirenik",
 28156,
 "ypk",
 "Cyrl",
}
m["yss"] = {
 "Yessan-Mayo",
 8052927,
 "paa-spk",
 "Latn",
}
m["ysy"] = {
 "Sanie",
 7418287,
 "tbq-lol",
}
m["yta"] = {
 "Talu",
 16999095,
 "tbq-lol",
}
m["ytl"] = {
 "Tanglang",
 7786695,
 "tbq-lol",
}
m["ytp"] = {
 "Thopho",
 7796015,
 "tbq-lol",
}
m["ytw"] = {
 "Yout Wam",
 nil,
 "ngf-fin",
 "Latn",
}
m["yty"] = {
 "Yatay",
 nil,
 "aus-pmn",
}
m["yua"] = {
 "Yucatec Maya",
 13354,
 "myn",
 "Latn",
}
m["yub"] = {
 "Yugambal",
 3446663,
}
m["yuc"] = {
 "Yuchi",
 34204,
 "qfa-iso",
}
m["yue"] = {
 "Cantonese",
 9186,
 "zhx",
 "Hani, Hant, Hans, Latn",
 wikimedia_codes = "yue, zh-yue",
 ancestors = "ltc",
 generate_forms = "zh-generateforms",
 translit = {Hani = "zh-translit"},
 sort_key = {Hani = "Hani-sortkey"},
}
m["yuf"] = {
 "Havasupai-Walapai-Yavapai",
 3565286,
 "nai-yuc",
 "Latn",
}
m["yug"] = {
 "Yug",
 56311,
 "qfa-yen",
}
m["yui"] = {
 "Yurutí",
 3573266,
 "sai-tuc",
 "Latn",
}
m["yuj"] = {
 "Karkar-Yuri",
 2992906,
 "paa-pau",
 "Latn",
}
m["yuk"] = {
 "Yuki",
 36993,
 nil,
 "Latn",
}
m["yul"] = {
 "Yulu",
 3915595,
 "csu-bba",
}
m["yum"] = {
 "Yuma",
 3573199,
 "nai-yuc",
 "Latn",
}
m["yun"] = {
 "Bena",
 3913283,
 "alv-yun",
}
m["yup"] = {
 "Yukpa",
 3441447,
 "sai-yuk",
 "Latn",
}
m["yuq"] = {
 "Yuqui",
 8061440,
 "tup-gua",
 "Latn",
}
m["yur"] = {
 "Yurok",
 34685,
 "aql",
 "Latn",
}
m["yut"] = {
 "Yopno",
 12953338,
 "ngf-fin",
 "Latn",
}
m["yuw"] = {
 "Finisterre Yau",
 12953319,
 "ngf-fin",
 "Latn",
}
m["yux"] = {
 "Southern Yukaghir",
 56545,
 "qfa-yuk",
 "Cyrl",
 translit = "yux-translit",
}
m["yuy"] = {
 "East Yugur",
 29902,
 "xgn-sou",
}
m["yuz"] = {
 "Yuracare",
 2640646,
 "qfa-iso",
 "Latn",
}
m["yva"] = {
 "Yawa",
 3572020,
 "paa",
 "Latn",
}
m["yvt"] = {
 "Yavitero",
 3441427,
 "awd",
 "Latn",
}
m["ywa"] = {
 "Kalou",
 6354305,
 "paa-spk",
 "Latn",
}
m["ywg"] = {
 "Yinhawangka",
 8053734,
 "aus-nga",
 "Latn",
}
m["ywl"] = {
 "Western Lalu",
 12953325,
 "tbq-lal",
}
m["ywn"] = {
 "Yawanawa",
 10322118,
 "sai-pan",
 "Latn",
}
m["ywq"] = {
 "Nasu",
 25559456,
 "tbq-lol",
 "Plrd, Yiii",
}
m["ywr"] = {
 "Yawuru",
 8050479,
 "aus-nyu",
 "Latn",
}
m["ywt"] = {
 "Xishanba Lalo",
 12953336,
 "tbq-lal",
}
m["ywu"] = {
 "Wumeng Nasu",
 25559442,
 "tbq-lol",
}
m["yww"] = {
 "Yawarawarga",
 10723454,
 "aus-kar",
 "Latn",
}
m["yxa"] = {
 "Mayawali",
 33060513,
 "aus-pam",
 "Latn",
}
m["yxg"] = {
 "Yagara",
 nil,
 "aus-pam",
 "Latn",
}
m["yxl"] = {
 "Yarli",
 46264708,
 "aus-pam",
 "Latn",
}
m["yxm"] = {
 "Yinwum",
 8053763,
 "aus-pam",
 "Latn",
}
m["yxu"] = {
 "Yuyu",
 8062232,
 "aus-pam",
 "Latn",
}
m["yxy"] = {
 "Yabula Yabula",
 8046394,
 "aus-pam",
 "Latn",
}
m["yyu"] = {
 "Torricelli Yau",
 8050328,
 "qfa-tor",
 "Latn",
}
m["yyz"] = {
 "Ayizi",
 20527363,
 "tbq-lol",
}
m["yzg"] = {
 "E'ma Buyang",
 16115619,
 "qfa-buy",
}
m["yzk"] = {
 "Zokhuo",
 8073523,
 "tbq-lol",
}
m["zaa"] = {
 "Sierra de Juárez Zapotec",
 12953989,
 "omq-zap",
 "Latn",
}
m["zab"] = {
 "San Juan Guelavía Zapotec",
 5614751,
 "omq-zpc",
 "Latn",
}
m["zac"] = {
 "Ocotlán Zapotec",
 7076643,
 "omq-zap",
 "Latn",
}
m["zad"] = {
 "Cajonos Zapotec",
 5017997,
 "omq-zpc",
 "Latn",
}
m["zae"] = {
 "Yareni Zapotec",
 12645368,
 "omq-zap",
 "Latn",
}
m["zaf"] = {
 "Ayoquesco Zapotec",
 4831570,
 "omq-zpc",
 "Latn",
}
m["zag"] = {
 "Zaghawa",
 37007,
 "ssa-sah",
 "Latn", -- also Beria
}
m["zah"] = {
 "Zangwal",
 3441387,
 "cdc-wst",
 "Latn",
}
m["zai"] = {
 "Isthmus Zapotec",
 56728,
 "omq-zpc",
 "Latn",
}
m["zaj"] = {
 "Zaramo",
 8066599,
 "bnt-ruv",
 "Latn",
}
m["zak"] = {
 "Zanaki",
 8066018,
 "bnt-lok",
 "Latn",
}
m["zal"] = {
 "Zauzou",
 3616358,
 "tbq-lol",
 "Latn, Hani",
 sort_key = {Hani = "Hani-sortkey"},
}
m["zam"] = {
 "Central Mahuatlán Zapoteco",
 13541830,
 "omq-zap",
 "Latn",
}
m["zao"] = {
 "Ozolotepec Zapotec",
 7116610,
 "omq-zap",
 "Latn",
}
m["zap"] = {
 "Zapotec",
 13214,
 "omq-zap",
 "Latn",
}
m["zaq"] = {
 "Aloápam Zapotec",
 4734726,
 "omq-zap",
 "Latn",
}
m["zar"] = {
 "Rincón Zapotec",
 7334628,
 "omq-zap",
 "Latn",
}
m["zas"] = {
 "Santo Domingo Albarradas Zapotec",
 4709425,
 "omq-zap",
 "Latn",
}
m["zat"] = {
 "Tabaa Zapotec",
 7672849,
 "omq-zap",
 "Latn",
}
m["zau"] = {
 "Zangskari",
 771203,
 "sit-lab",
 "Tibt",
 ancestors = "lbj",
 translit = "Tibt-translit",
 override_translit = true,
 display_text = s["Tibt-displaytext"],
 entry_name = s["Tibt-entryname"],
 sort_key = "Tibt-sortkey",
}
m["zav"] = {
 "Yatzachi Zapotec",
 8050301,
 "omq-zpc",
 "Latn",
}
m["zaw"] = {
 "Mitla Zapotec",
 3053288,
 "omq-zpc",
 "Latn",
}
m["zax"] = {
 "Xadani Zapotec",
 8042823,
 "omq-zap",
 "Latn",
}
m["zay"] = {
 "Zayse-Zergulla",
 673895,
 "omv-eom",
 "Latn",
}
m["zaz"] = {
 "Zari",
 3914398,
 "cdc-wst",
 "Latn",
}
m["zbt"] = {
 "Batui",
 16839143,
 "poz-slb",
 "Latn",
}
m["zca"] = {
 "Coatecas Altas Zapotec",
 5138603,
 "omq-zap",
 "Latn",
}
m["zdj"] = {
 "Ngazidja Comorian",
 3114653,
 "bnt-com",
 "Latn",
 sort_key = "bnt-com-sortkey",
}
m["zea"] = {
 "Zealandic",
 237409,
 "gmw",
 "Latn",
 ancestors = "dum",
 sort_key = {
  from = {"^'([aeiouy].*)$"},
  to = {"%1'"}
 }
}
m["zeg"] = {
 "Zenag",
 12953345,
 "poz-ocw",
 "Latn",
}
m["zen"] = {
 "Zenaga",
 37005,
 "ber",
 "Latn",
}
m["zga"] = {
 "Kinga",
 11005332,
 "bnt-bki",
 "Latn",
}
m["zgh"] = {
 "Moroccan Amazigh",
 7598268,
 "ber",
 "Tfng",
 translit = "Tfng-translit",
}
m["zgr"] = {
 "Magori",
 3277370,
 "poz-ocw",
 "Latn",
}
m["zhb"] = {
 "Zhaba",
 56334,
 "sit-qia",
}
m["zhi"] = {
 "Zhire",
 3914910,
 "nic-plc",
 "Latn",
}
m["zhn"] = {
 "Nong Zhuang",
 7049385,
 "tai-cen",
 "Latn",
 sort_key = {remove_diacritics = "%p"},
}
m["zhw"] = {
 "Zhoa",
 8070885,
 "nic-rnw",
 "Latn",
}
m["zia"] = {
 "Zia",
 3038636,
 "ngf",
 "Latn",
}
m["zib"] = {
 "Zimbabwe Sign Language",
 8072097,
 "sgn",
}
m["zik"] = {
 "Zimakani",
 56740,
 "ngf",
 "Latn",
}
m["zil"] = {
 "Zialo",
 36991,
 "dmn-msw",
 "Latn",
}
m["zim"] = {
 "Mesme",
 56282,
 "cdc-mas",
 "Latn",
}
m["zin"] = {
 "Zinza",
 8072460,
 "bnt-haj",
 "Latn",
}
m["zir"] = {
 "Ziriya",
 3913943,
 "nic-jer",
 "Latn",
}
m["ziw"] = {
 "Zigula",
 37010,
 "bnt-seu",
 "Latn",
}
m["ziz"] = {
 "Zizilivakan",
 56300,
 "cdc-cbm",
 "Latn",
}
m["zka"] = {
 "Kaimbulawa",
 6348011,
 "poz-mun",
 "Latn",
}
m["zkb"] = {
 "Koibal",
 949259,
 "syd",
 "Latn, Cyrl",
}
m["zkg"] = {
 "Goguryeo",
 706327,
 "qfa-kor",
 "Hani",
 sort_key = "Hani-sortkey",
}
m["zkh"] = {
 "Khorezmian Turkic",
 25502,
 "trk",
 "Arab",
}
m["zkk"] = {
 "Karankawa",
 3192947,
 nil,
 "Latn",
}
m["zko"] = {
 "Kott",
 34163,
 "qfa-yen",
 "Latn",
}
m["zkp"] = {
 "São Paulo Kaingáng",
 7665661,
 "sai-jee",
 "Latn",
}
m["zkr"] = {
 "Zakhring",
 56996,
 "sit-mdz",
 "Latn, Hani",
 sort_key = {Hani = "Hani-sortkey"},
}
m["zkt"] = {
 "Khitan",
 1064482,
 "qfa-xgx",
 "Kitl, Kits, Hani",
 translit = {Kits = "zkt-translit"},
 sort_key = {Hani = "Hani-sortkey"},
}
m["zku"] = {
 "Kaurna",
 6378899,
 "aus-psw",
 "Latn",
}
m["zkv"] = {
 "Krevinian",
 6436902,
 "urj-fin",
 "Latn",
 ancestors = "vot",
}
m["zkz"] = {
 "Khazar",
 1067986,
 "trk",
 "Orkh",
}
m["zma"] = {
 "Manda (Australia)",
 18650060,
 "aus-dal",
 "Latn",
}
m["zmb"] = {
 "Zimba",
 8071960,
 "bnt-lgb",
 "Latn",
}
m["zmc"] = {
 "Margany",
 10577017,
 "aus-pam",
 "Latn",
}
m["zmd"] = {
 "Maridan",
 10577273,
 "aus-dal",
 "Latn",
}
m["zme"] = {
 "Mangerr",
 10576387,
 nil,
 "Latn",
}
m["zmf"] = {
 "Mfinu",
 35915,
 "bnt-tek",
 "Latn",
}
m["zmg"] = {
 "Marti Ke",
 10577823,
 "aus-dal",
 "Latn",
}
m["zmh"] = {
 "Makolkol",
 12636052,
 "paa-bng",
 "Latn",
}
m["zmi"] = {
 "Negeri Sembilan Malay",
 3915909,
 "poz-mly",
 "Latn",
}
m["zmj"] = {
 "Maridjabin",
 10577274,
 "aus-dal",
 "Latn",
}
m["zmk"] = {
 "Mandandanyi",
 10576338,
 "aus-pam",
 "Latn",
}
m["zml"] = {
 "Madngele",
 10575155,
 "aus-dal",
 "Latn",
}
m["zmm"] = {
 "Marimanindji",
 10577424,
 "aus-dal",
 "Latn",
}
m["zmn"] = {
 "Mbangwe",
 35928,
 "bnt-kel",
 "Latn",
}
m["zmo"] = {
 "Molo",
 15974357,
 "sdv-eje",
 "Latn",
}
m["zmp"] = {
 "Mbuun",
 106249400,
 "bnt",
 "Latn",
}
m["zmq"] = {
 "Mituku",
 6883590,
 "bnt-mbe",
 "Latn",
}
m["zmr"] = {
 "Maranungku",
 6772792,
 "aus-dal",
 "Latn",
}
m["zms"] = {
 "Mbesa",
 6799676,
 "bnt-ske",
 "Latn",
}
m["zmt"] = {
 "Maringarr",
 10577443,
 "aus-dal",
 "Latn",
}
m["zmu"] = {
 "Muruwari",
 3915442,
 "aus-pam",
 "Latn",
}
m["zmv"] = {
 "Mbariman-Gudhinma",
 3915672,
 "aus-pmn",
 "Latn",
}
m["zmw"] = {
 "Mbo (Congo)",
 6799710,
 "bnt-nya",
 "Latn",
}
m["zmx"] = {
 "Bomitaba",
 35063,
 "bnt-ngn",
 "Latn",
}
m["zmy"] = {
 "Mariyedi",
 10577501,
 "aus-dal",
 "Latn",
}
m["zmz"] = {
 "Mbandja",
 3915310,
 "bad",
 "Latn",
}
m["zna"] = {
 "Zan Gula",
 863726,
 "alv-bua",
 "Latn",
}
m["zne"] = {
 "Zande",
 35015,
 "znd",
 "Latn",
}
m["zng"] = {
 "Mang",
 720192,
 "mkh-mng",
}
m["znk"] = {
 "Manangkari",
 6746906,
 "aus-wdj",
 "Latn",
}
m["zns"] = {
 "Mangas",
 3438780,
 "cdc-wst",
 "Latn",
}
m["zoc"] = {
 "Copainalá Zoque",
 12954017,
 "nai-miz",
 "Latn",
}
m["zoh"] = {
 "Chimalapa Zoque",
 5099289,
 "nai-miz",
 "Latn",
}
m["zom"] = {
 "Zou",
 37011,
 "tbq-kuk",
}
m["zoo"] = {
 "Asunción Mixtepec Zapotec",
 4811888,
 "omq-zap",
 "Latn",
}
m["zoq"] = {
 "Tabasco Zoque",
 323325,
 "nai-miz",
 "Latn",
}
m["zor"] = {
 "Rayón Zoque",
 12954015,
 "nai-miz",
 "Latn",
}
m["zos"] = {
 "Francisco León Zoque",
 12954011,
 "nai-miz",
 "Latn",
}
m["zpa"] = {
 "Lachiguiri Zapotec",
 6468403,
 "omq-zap",
 "Latn",
}
m["zpb"] = {
 "Yautepec Zapotec",
 7413392,
 "omq-zap",
 "Latn",
}
m["zpc"] = {
 "Choapan Zapotec",
 5103425,
 "omq-zap",
 "Latn",
}
m["zpd"] = {
 "Southeastern Ixtlán Zapotec",
 8050392,
 "omq-zap",
 "Latn",
}
m["zpe"] = {
 "Petapa Zapotec",
 7171675,
 "omq-zap",
 "Latn",
}
m["zpf"] = {
 "San Pedro Quiatoni Zapotec",
 7271640,
 "omq-zpc",
 "Latn",
}
m["zpg"] = {
 "Guevea de Humboldt Zapotec",
 13459953,
 "omq-zap",
 "Latn",
}
m["zph"] = {
 "Totomachapan Zapotec",
 7828390,
 "omq-zap",
 "Latn",
}
m["zpi"] = {
 "Santa María Quiegolani Zapotec",
 7271823,
 "omq-zpc",
 "Latn",
}
m["zpj"] = {
 "Quiavicuzas Zapotec",
 7271642,
 "omq-zap",
 "Latn",
}
m["zpk"] = {
 "Tlacolulita Zapotec",
 7810685,
 "omq-zpc",
 "Latn",
}
m["zpl"] = {
 "Lachixío Zapotec",
 6468420,
 "omq-zap",
 "Latn",
}
m["zpm"] = {
 "Mixtepec Zapotec",
 7414598,
 "omq-zpc",
 "Latn",
}
m["zpn"] = {
 "Santa Inés Yatzechi Zapotec",
 8050300,
 "omq-zap",
 "Latn",
}
m["zpo"] = {
 "Amatlán Zapotec",
 4740613,
 "omq-zpc",
 "Latn",
}
m["zpp"] = {
 "El Alto Zapotec",
 5350733,
 "omq-zap",
 "Latn",
}
m["zpq"] = {
 "Zoogocho Zapotec",
 8074100,
 "omq-zpc",
 "Latn",
}
m["zpr"] = {
 "Santiago Xanica Zapotec",
 8042924,
 "omq-zap",
 "Latn",
}
m["zps"] = {
 "Coatlán Zapotec",
 7420514,
 "omq-zap",
 "Latn",
}
m["zpt"] = {
 "San Vicente Coatlán Zapotec",
 13541831,
 "omq-zap",
 "Latn",
}
m["zpu"] = {
 "Yalálag Zapotec",
 8047534,
 "omq-zpc",
 "Latn",
}
m["zpv"] = {
 "Chichicapan Zapotec",
 5096050,
 "omq-zap",
 "Latn",
}
m["zpw"] = {
 "Zaniza Zapotec",
 8066220,
 "omq-zpc",
 "Latn",
}
m["zpx"] = {
 "San Baltazar Loxicha Zapotec",
 7413390,
 "omq-zap",
 "Latn",
}
m["zpy"] = {
 "Mazaltepec Zapotec",
 6798223,
 "omq-zap",
 "Latn",
}
m["zpz"] = {
 "Texmelucan Zapotec",
 7708357,
 "omq-zpc",
 "Latn",
}
m["zra"] = {
 "Kaya",
 5528695,
 "qfa-kor",
}
m["zrg"] = {
 "Mirgan",
 6873206,
 "inc-eas",
 ancestors = "pra-mag",
}
m["zrn"] = {
 "Zirenkel",
 3441365,
 "cdc-est",
 "Latn",
}
m["zro"] = {
 "Záparo",
 10206,
 "sai-zap",
 "Latn",
}
m["zrs"] = {
 "Mairasi",
 3038645,
 "paa-mai",
 "Latn",
}
m["zsa"] = {
 "Sarasira",
 nil,
 "poz-ocw",
}
m["zsk"] = { -- attested?
 "Kaskean",
 6374586,
}
m["zsl"] = {
 "Zambian Sign Language",
 8065713,
 "sgn",
}
m["zsr"] = {
 "Southern Rincon Zapotec",
 12954000,
 "omq-zpc",
 "Latn",
}
m["zsu"] = {
 "Sukurum",
 nil,
 "poz-ocw",
}
m["zte"] = {
 "Elotepec Zapotec",
 5367223,
 "omq-zap",
 "Latn",
}
m["ztg"] = {
 "Xanaguía Zapotec",
 8042887,
 "omq-zpc",
 "Latn",
}
m["ztl"] = {
 "Lapaguía-Guivini Zapotec",
 6488084,
 "omq-zap",
 "Latn",
}
m["ztm"] = {
 "San Agustín Mixtepec Zapotec",
 7413220,
 "omq-zap",
 "Latn",
}
m["ztn"] = {
 "Santa Catarina Albarradas Zapotec",
 7419277,
 "omq-zap",
 "Latn",
}
m["ztp"] = {
 "Loxicha Zapotec",
 6694268,
 "omq-zap",
 "Latn",
}
m["ztq"] = {
 "Quioquitani-Quierí Zapotec",
 3574818,
 "omq-zpc",
 "Latn",
}
m["zts"] = {
 "Tilquiapan Zapotec",
 7802959,
 "omq-zpc",
 "Latn",
}
m["ztt"] = {
 "Tejalapan Zapotec",
 13510225,
 "omq-zap",
 "Latn",
}
m["ztu"] = {
 "San Pablo Güilá Zapotec",
 5626813,
 "omq-zap",
 "Latn",
}
m["ztx"] = {
 "Zaachila Zapotec",
 8063390,
 "omq-zap",
 "Latn",
}
m["zty"] = {
 "Yatee Zapotec",
 3574815,
 "omq-zpc",
 "Latn",
}
m["zua"] = {
 "Zeem",
 3450131,
 "cdc-wst",
 "Latn",
}
m["zuh"] = {
 "Tokano",
 7813481,
 "ngf",
 "Latn",
}
m["zum"] = {
 "Kumzari",
 36158,
 "ira-swi",
 "Arab",
 ancestors = "pal",
}
m["zun"] = {
 "Zuni",
 10188,
 "qfa-iso",
 "Latn",
}
m["zuy"] = {
 "Zumaya",
 56626,
 "cdc-mas",
 "Latn",
}
m["zwa"] = {
 "Zay",
 10195,
 "sem-eth",
}
m["zyp"] = {
 "Zyphe",
 57004,
 "tbq-kuk",
 "Latn",
}
m["zza"] = {
 "Zazaki",
 10199,
 "ira-zgr",
 "Latn",
 dotted_dotless_i = true,
 sort_key = "zza-sortkey",
 wikimedia_codes = "diq",
}
m["zzj"] = {
 "Zuojiang Zhuang",
 13848149,
 "tai-cen",
 "Latn",
 sort_key = {remove_diacritics = "%p"},
}

return m
end
