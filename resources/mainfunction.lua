
function(word,lang,langinfo)
-- function(word,lang,langinfostr)

mw = {ustring = require 'ustring/ustring'}
u = mw.ustring.char

-- m = {}

-- PUNCTUATION = " !#%&*+,-./:;<=>?@^_`|~'()"
-- 
-- u = mw.ustring.char
-- -- UTF-8 encoded strings for some commonly-used diacritics
-- GRAVE     = u(0x0300)
-- ACUTE     = u(0x0301)
-- CIRC      = u(0x0302)
-- TILDE     = u(0x0303)
-- MACRON    = u(0x0304)
-- BREVE     = u(0x0306)
-- DOTABOVE  = u(0x0307)
-- DIAER     = u(0x0308)
-- CARON     = u(0x030C)
-- DGRAVE    = u(0x030F)
-- INVBREVE  = u(0x0311)
-- DOTBELOW  = u(0x0323)
-- RINGBELOW = u(0x0325)
-- CEDILLA   = u(0x0327)
-- OGONEK    = u(0x0328)
-- CGJ       = u(0x034F) -- combining grapheme joiner
-- DOUBLEINVBREVE = u(0x0361)


-- langinfo = m[lang]
--load('langinfo = '..langinfostr)()

if langinfo then
   replacements = langinfo.entry_name
end


function hasSubdictionary(D)
    for key, value in pairs(D) do
        if type(value) == "table" then
            return true, value
        end
    end
    return false, nil  
end

local function do_entry_name_or_sort_key_replacements(text, replacements)
   if replacements then 
      if replacements.from then
         for i, from in ipairs(replacements.from) do
            local to = replacements.to[i] or ""
            text = mw.ustring.gsub(text, from, to)
         end
      end
      
      if replacements.remove_diacritics then
         text = mw.ustring.toNFD(text)
         text = mw.ustring.gsub(text,
            '[' .. replacements.remove_diacritics .. ']',
            '')
         text = mw.ustring.toNFC(text)
      elseif select(1, hasSubdictionary(replacements)) then
         text = do_entry_name_or_sort_key_replacements(text, select(2, hasSubdictionary(replacements)))
      end
   end
      
	return text
end

--
return do_entry_name_or_sort_key_replacements(word, replacements)
-- return langinfo

end


