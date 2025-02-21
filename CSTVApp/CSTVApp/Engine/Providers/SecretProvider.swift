/*/
 It's not safe to store a secret locally, but this class just represent
    the logic to get the token. Other strategy should be analysed for
    this situation, possibily an encripted file to store the key if
    the token is not provided by authentication flow.
 */

struct SecretProvider {
    static let token = "oBQ0Q9W_ETwOUwXPEtmldY4vu3zcDp2jx0HFLiPKwFgcS_mlpzw"
}
