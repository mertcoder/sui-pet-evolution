module sui_pet_evolution::pet{
    
    use std::string::{Self, String};
    use sui::object::UID;
    use sui::tx_context::{TxContext, sender};
    use sui::object;
    use sui::transfer;
    use sui::package;
    use sui::display; //to solve no media (:

    //otw
    public struct PET has drop {}

    public struct Pet has key, store {
        id: UID,
        name: String,
        image_url: String,
        level: u8,
        description: String
    }

    public struct MagicFood has key, store {
        id: UID,
    }

    fun init(otw: PET, ctx: &mut TxContext) {
        let keys = vector[
            string::utf8(b"name"),
            string::utf8(b"image_url"),
            string::utf8(b"description"),
            string::utf8(b"level"),
        ];

        let values = vector[
            string::utf8(b"{name}"),
            string::utf8(b"{image_url}"),
            string::utf8(b"{description}"),
            string::utf8(b"Level {level}"),
        ];

        let publisher = package::claim(otw, ctx);
        let mut display = display::new_with_fields<Pet>(
            &publisher, keys, values, ctx
        );
        
        display::update_version(&mut display);
        
        transfer::public_transfer(publisher, sender(ctx));
        transfer::public_transfer(display, sender(ctx));
    }

    public entry fun own_pet(name: String, ctx: &mut TxContext) {
        let pet = Pet{
            id: object::new(ctx),
            name: name,
            image_url: string::utf8(b"https://i.imgur.com/2SDwMqq.png"),
            level: 1,
            description: string::utf8(b"A newly hatched pet.")
        };
        transfer::public_transfer(pet, sender(ctx));
    }

    public entry fun cook_magic_food(ctx: &mut TxContext){
        let food = MagicFood {id: object::new(ctx) };
        transfer::public_transfer(food, sender(ctx));
    }

    public entry fun evolve_pet(pet: &mut Pet, food: MagicFood, _ctx: &mut TxContext){
        let MagicFood {id: food_id} = food;
        object::delete(food_id);

        pet.level = pet.level + 1;

        if(pet.level == 3){
            pet.description = string::utf8(b"Your dragon is growing so fast!");
            pet.image_url = string::utf8(b"https://i.imgur.com/QfxosaU.png");
        };

        if(pet.level == 10){
            pet.description = string::utf8(b"Your dragon is on fire!!!");
            pet.image_url = string::utf8(b"https://i.imgur.com/xDA0bkS.png");
        };
    } 
}