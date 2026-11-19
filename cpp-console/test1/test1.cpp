#include<iostream>
#include<algorithm>
#include<cstring>
#include<queue>

using namespace std;

const int N = 510;

int n, m, a, b;
int dist[N][N];  //感染时间的结果集， 多个感染源需要更新
//队列配置
typedef pair<int, int> PII;
queue<PII> q;

int dx[] = { -1, 0, 1, 0 };
int dy[] = { 0, 1 ,0, -1 };

void bfs(int x, int y) {
    memset(dist, -1, sizeof(dist));
    dist[x][y] = 0;  //感染源为0
    q.push({ x, y });
    while (!q.empty()) {
        auto t = q.front();
        q.pop();  //弹出
        for (int i = 0; i < 4; i++) {
            int u = t.first + dx[i], v = t.second + dy[i];
            if (u < 1 || u > n || v < 1 || v > m) continue;
            if (dist[u][v] > 0) continue;

            q.push({ u, v });
            dist[u][v] = min((dist[t.first][t.second] + 1), dist[u][v]);

        }
    }
    dist[x][y] = 0;


}
int main() {
    scanf("%d %d %d %d", &n, &m, &a, &b);
    while (a--) {
        int x, y;
        scanf("%d %d", &x, &y);
        bfs(x, y);  //两次并且更新dist
    }

    while (b--) {
        int f, g;
        scanf("%d %d", &f, &g);
        printf("%d\n", dist[f][g]);
    }
    return 0;

}