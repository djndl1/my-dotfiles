require('minuet').setup {
    provider = 'openai_compatible',
    n_completions = 1, -- recommend for local model for resource saving
    -- I recommend beginning with a small context window size and incrementally
    -- expanding it, depending on your local computing power. A context window
    -- of 512, serves as an good starting point to estimate your computing
    -- power. Once you have a reliable estimate of your local computing power,
    -- you should adjust the context window to a larger value.
    context_window = 512,
    provider_options = {
        openai_compatible_alt = {
            -- For Windows users, TERM may not be present in environment variables.
            -- Consider using APPDATA instead.
            api_key = 'MYQWEN_API_KEY',
            name = 'Qwen',
            end_point = 'https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions',
            model = 'qwen3-coder-flash',
            optional = {
                max_tokens = 50,
                top_p = 0.9,
            },
        },
        openai_compatible = {
            -- For Windows users, TERM may not be present in environment variables.
            -- Consider using APPDATA instead.
            api_key = 'DEEPSEEK_API_KEY',
            name = 'DS',
            end_point = 'http://mycisdi:8899/api/chat/completions',
            model = 'AGIOne.101876501632454656',
            optional = {
                max_tokens = 50,
                top_p = 0.9,
            },
        },
    },
}

require("parrot").setup {
    providers = {
        deepseek = {
            name = "deepseek",
            api_key = os.getenv "DEEPSEEK_API_KEY",
            endpoint = 'http://mycisdi:8899/api/chat/completions',
            model_endpoint = 'http://mycisdi:8899/api/models',
            params = {
                chat = { temperature = 1.1, top_p = 1 },
                command = { temperature = 1.1, top_p = 1 },
            },
            topic = {
                model = "AGIOne.101876501632454656",
                params = { max_completion_tokens = 64 },
            },
            models = {
                "AGIOne.101876501632454656",
            }
        }
    },

    system_propmt = { }
}
