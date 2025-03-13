using UnityEngine;

public class CoinSpawnerScript : MonoBehaviour
{
    [SerializeField] private GameObject coinPrefab;
    [SerializeField] private BoxCollider groundCollider;
    [SerializeField] private int coinAmount = 10;
    void Start()
    {
        for (int i = 0; i < coinAmount; i++)
        {
            Vector3 startPos = RandomPointInBounds(groundCollider.bounds);
            GameObject coin = Instantiate(coinPrefab, startPos, Quaternion.identity);
        }
        
    }

    public static Vector3 RandomPointInBounds(Bounds bounds){
        return new Vector3(
            Random.Range(bounds.min.x, bounds.max.x),
            1f,
            Random.Range(bounds.min.z, bounds.max.z)
        );
    }


}
