#include <bits/stdc++.h>

using namespace std ;

typedef long long ll ; 
typedef pair<int, int> pii ; 
typedef pair<ll, ll> pll ; 
typedef long double ld ; 
typedef vector <int> vi ;
typedef vector <ll> vll ;
 
void debug_out() { cerr << endl; }
 
template <typename Head, typename... Tail>
void debug_out(Head H, Tail... T) {
	cerr << " " << H ;
	debug_out(T...);
}
 
#define debug(...)             cerr << "(" << #__VA_ARGS__ << "): ", debug_out(__VA_ARGS__)
#define hey                    cerr << "Ey BABA!\n"
#define MP                     make_pair
#define F                     first
#define S                     second
#define pb 					   push_back
#define ppb                    pop_back 
#define all(v)                 v.begin() ,v.end() 
#define len(v)                 (int) v.size()
#define uniq(v)                 v.resize(unique(all(v)) - v.begin());
	
vector <int> ROM = {8, 7, 6, 5, 4, 5, 2, 7, 8, 9, 14, 11, 20, 3, 14, 15} ; 

vector <vector<int>> build(int start_address){
	vector <vector <int>> res ; 
	for (int i = 0; i < 3; i++){
		vector <int> tmp ; 
		for (int j = 0; j < 3; j++){
			tmp.push_back(ROM[(start_address + i * 3 + j) % 16]) ;  
		}
		res.push_back(tmp) ; 
	}
	return res ; 
}

int main(){
	while (true){
		int start_address; 
		cout << "enter start address :" << endl ;
		cin >> start_address; 
		vector <vector<int>> v = build(start_address) ; 
		int det1 = (v[1][1] * v[2][2] - v[2][1] * v[1][2]) ; 
		int det2 = (v[1][0] * v[2][2] - v[2][0] * v[1][2]) ; 
		int det3 = (v[1][0] * v[2][1] - v[2][0] * v[1][1]) ; 
		for (int i = 0; i < 3; i++){
			for (int j = 0; j < 3; j++){
				cout << v[i][j] << " \n"[j == 2] ; 
			}
		}
		debug(det1) ; 
		debug(det2) ; 
		debug(det3) ; 
		int res1 = det1 * v[0][0] ;  
		int res2 = det2 * v[0][1] ;  
		int res3 = det3 * v[0][2] ;  
		debug(res1) ; 
		debug(res2) ; 
		debug(res3) ; 
		int ans = res1 - res2 + res3 ; 
		debug(ans);
	}
	return 0 ;
}








