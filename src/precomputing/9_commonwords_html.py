
from src.precomputing.coordinator import *


RESULTS = []
def FUN(gram):
   GLOBALCACHES.wipe_all()
   results = []
   for word in gram.AllRealGivenWords():
      result, time = Time(lambda: Word_HTML(word), 'boop', to_print=False)
      results.append((word, result))
      RESULTS.append((word, time))
   return results

to_do_1 = {'generator source':[(x,) for x in list(reversed(DB._CommonEnglishGrams.OneValue()))[600:700]], 'function':FUN, 'target tables':[DB._WORD_HTMLs], }

CALL([to_do_1, ])



'''


unpledged, en], 1, 1.1475951671600342),
 ([longfin, en], 1, 1.4442510604858398),
 ([Bumgarner, en], 1, 1.5535352230072021),
 ([superbus, en], 1, 1.6668882369995117),
 ([swept-back, en], 0, 1.917510747909546),
 ([longfin, en], 0, 2.1570990085601807),
 ([porin, en], 1, 2.3152289390563965),
 ([cellulosic, en], 1, 2.429374933242798),
 ([flaking, en], 0, 2.574404239654541),
 ([flaking, en], 1, 2.736158847808838),
 ([enjoin, en], 1, 3.2741539478302),
 ([gas-powered, en], 0, 4.00358510017395),
 ([doxycycline, en], 1, 5.90042519569397),
 ([saturnalia, en], 0, 6.761960983276367),
 ([doxycycline, en], 0, 6.842113018035889),
 ([Horsfield, en], 1, 7.290464878082275),
 ([adventitious, en], 1, 7.518402099609375),
 ([saturnalia, en], 1, 7.944031000137329),
 ([Horsfield, en], 0, 10.317797183990479),
 ([mixed-sex, en], 0, 10.89962911605835),
 ([Emmental, en], 1, 11.581265211105347),
 ([right-footed, en], 0, 12.11204195022583),
 ([beeman, en], 1, 12.587791919708252),
 ([beeman, en], 0, 13.28754472732544),
 ([Seaborg, en], 1, 29.57074499130249)]






[Teufel, en], 1, 0.3610110282897949),
 ([megahertz, en], 0, 0.42528700828552246),
 ([Teufel, en], 0, 0.5398519039154053),
 ([cityhood, en], 1, 0.6586470603942871),
 ([cartulary, en], 1, 0.7071549892425537),
 ([miscast, en], 1, 0.8970298767089844),
 ([treacherously, en], 1, 0.9569528102874756),
 ([inpatients, en], 1, 2.1675801277160645),
 ([inpatients, en], 0, 2.410454034805298),
 ([destructor, en], 1, 2.4811580181121826),
 ([floruit, en], 1, 2.528135061264038),
 ([protoplanetary, en], 1, 2.6858322620391846),
 ([pro-vice-chancellor, en], 0, 2.860150098800659),
 ([protoplanetary, en], 0, 3.0271129608154297),
 ([destructor, en], 0, 3.07598614692688),
 ([pro-vice-chancellor, en], 1, 3.448240041732788),
 ([Swakopmund, en], 1, 4.094856023788452),
 ([counter-productive, en], 1, 4.364691972732544),
 ([occident, en], 1, 4.661227703094482),
 ([Swakopmund, en], 0, 5.089692115783691),
 ([brokeback, en], 1, 5.106168031692505),
 ([brokeback, en], 2, 5.14811110496521),
 ([mantises, en], 1, 5.277052164077759),
 ([accredits, en], 1, 5.434905052185059),
 ([accredits, en], 0, 6.448953866958618),
 ([protoplanetary, en], 2, 6.64795994758606),
 ([prunella, en], 1, 6.658156871795654),
 ([brokeback, en], 0, 6.678192853927612),
 ([bombsight, en], 1, 6.817838907241821),
 ([prunella, en], 2, 7.500697135925293),
 ([naw, en], 1, 8.058120965957642),
 ([inimical, en], 1, 8.355839014053345),
 ([mantises, en], 0, 8.561543941497803),
 ([televangelist, en], 1, 9.040403842926025),
 ([inferential, en], 1, 10.016683101654053)]
 '''

