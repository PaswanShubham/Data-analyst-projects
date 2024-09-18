SELECT 
    *
FROM
    pizza.orders
    
    ;
    -- Q1.Retrieve the total number of orders placed.
    select count(order_id) as total_orders from orders;
    -- Q2. 
    select round( sum(order_details.quantity*pizzas.price),2) as total_sales from
    order_details join pizzas on pizzas.pizza_id = order_details.pizza_id;
    
    -- Q3
    select pizza_types.name,pizzas.price from pizza_types join pizzas on 
    pizza_types.pizza_type_id=pizzas.pizza_type_id order by pizzas.price desc limit 1;
    
    -- Q4 
    select pizzas.size,count(order_details.order_details_id) as order_count from pizzas join order_details
    on pizzas.pizza_id = order_details.pizza_id group by pizzas.size order by order_count desc;
    
    -- Q5 
    select pizza_types.name, sum(order_details.quantity) as quantity from pizza_types join pizzas on
    pizza_types.pizza_type_id = pizzas.pizza_type_id join order_details on order_details.pizza_id=pizzas.pizza_id
    group by pizza_types.name order by quantity desc limit 5; 
    
    -- IntermediateQ6.
    select pizza_types.category, sum(order_details.quantity) as quantity from pizza_types join pizzas on 
    pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on
    order_details.pizza_id = pizzas.pizza_id group by pizza_types.category order by quantity desc; 
    
    -- Q7 
    select hour(order_time) as hour, count(order_id) as order_count from orders group by hour(order_time);
    -- Q8. 
    select category, count(name) from pizza_types group by category;
    
    -- Q9
    select round(avg(quantity),0) as avg_pizza_ordered_per_day from
    (
      select orders.order_date,sum(order_details.quantity) as quantity from orders join order_details
      on orders.order_id = order_details_id group by orders.order_date
      ) as order_quantity;
      
      -- Q10
      select pizza_types.name, sum(order_details.quantity* pizzas.price) as revenue from pizza_types
      join pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id join order_details on 
      order_details.pizza_id=pizzas.pizza_id group by pizza_types.name order by revenue desc limit 3;
      
      -- Q11 
      select pizza_types.category, round(sum(order_details.quantity*pizzas.price)/
      ( select round(sum(order_details.quantity* pizzas.price),2) as total_sales from order_details
      join pizzas on pizzas.pizza_id = order_details.pizza_id)*100,2) as revenue from pizza_types join pizzas on
      pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on order_details.pizza_id=pizzas.pizza_id
      group by pizza_types.category order by revenue desc;
      
        -- Q12
        select order_date, sum(revenue) over(order by order_date) as cum_revenue from
        ( select orders.order_date, sum(order_details.quantity*pizzas.price) as revenue
        from order_details join pizzas on order_details.pizza_id=pizzas.pizza_id join
        orders on orders.order_id=order_details.order_id group by orders.order_date) as sales;
        
        
      -- Q13
      select name, revenue from (
         select category,name,revenue, rank() over( partition by category order by revenue desc) as rn from
           ( select pizza_types.category,pizza_types.name, sum((order_details.quantity)*pizzas.price) as revenue from
           pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on 
           order_details.pizza_id=pizzas.pizza_id group by pizza_types.category,pizza_types.name)as a) as b where rn<=3 limit 3;
           

    
           