
class SharedState:
   def __init__(self)          : self._value = None
   def _SET_(self, value)      : self._value = value
   def __getattr__(self, name) : return getattr(self._value, name)

DB = SharedState()


