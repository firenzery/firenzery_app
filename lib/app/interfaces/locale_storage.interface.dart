abstract class ILocaleStorage {
  Future getValue(key);
  Future addValue(key, value);
  Future removeValue(key);
}
