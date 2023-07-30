
/* 
 * 1. Entity 对象有4个属性，id，name，age，sex
 * 2. 数据库中有1000条记录，查询返回 List<Entity>
 * 2. 按 age 和 sex 进行分组
 * 2. 对 List<Entity> 按规则；同一组串行调用，不同组并行调用 service 层的 sendAndWait 方法
 *  3. 考虑异常设计
 * 
 */
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

 public class CompletableFutrueBatchTask {

    private static final int THREAD_NUM = 5;

    public static void main(String[] args) {
        List<Entity> entityList = new ArrayList<>();
        // 1. 数据库中有1000条记录，查询返回 List<Entity>
        for (int i = 0; i < 1000; i++) {
            entityList.add(new Entity(i, "name" + i, i, i % 2));
        }
        Map<Integer, List<Entity>> map = entityList.stream().collect(Collectors.groupingBy(Entity::getSex));
        System.out.println("map:" + map);

        // 2. 对 List<Entity> 按规则；同一组串行调用，不同组并行调用 service 层的 sendAndWait 方法
        CompletableFuture[] cfs = map.entrySet().stream().map(entry -> CompletableFuture.runAsync(() -> {
            // 2.1 同一组串行调用
            List<Entity> list = entry.getValue();
            for (int i = 0; i < list.size(); i++) {
                Entity entity = list.get(i);
                // 2.2 调用 service 层的 sendAndWait 方法
                sendAndWait(entity);
            }
        })).toArray(CompletableFuture[]::new);

        // 3. 考虑异常设计
        CompletableFuture.allOf(cfs).exceptionally(e -> {
            System.out.println(e.getMessage());
            return null;
        }).join();

    }

    private static void sendAndWait(Entity entity) {
        System.out.println("sendAndWait:" + entity);
    }


 }