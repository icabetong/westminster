abstract class Repository<T> {
  Future put(T data);
  Future remove(T data);
  List<T> fetch();
}
